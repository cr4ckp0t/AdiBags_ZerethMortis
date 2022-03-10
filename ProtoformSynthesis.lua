-------------------------------------------------------------------------------
-- AdiBags - Zereth Mortis By Crackpot (US, Illidan)
-------------------------------------------------------------------------------

local addonName, addon = ...
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

local tonumber = _G["tonumber"]

local L = addon.L
local tooltip

local function tooltipInit()
    local tip, leftside = CreateFrame("GameTooltip"), {}
    for i = 1, 6 do
        local left, right = tip:CreateFontString(), tip:CreateFontString()
        left:SetFontObject(GameFontNormal)
        right:SetFontObject(GameFontNormal)
        tip:AddFontStrings(left, right)
        leftside[i] = left
    end
    tip.leftside = leftside
    return tip
end

local protoformFilter = AdiBags:RegisterFilter("Protoform Synthesis", 98, "ABEvent-1.0")
protoformFilter.uiName = L["Protoform Synthesis"]
protoformFilter.uiDesc = L["Items relating to Protoform Synthesis."]
protoformFilter.items = {
    -- From: https://www.wowhead.com/item=189175/mawforged-bridle#comments:id=5327838

    -- Base Item
    [188957] = true, -- Genesis Mote

    -- Lattices
    [187634] = true, -- Ambystan Lattice
    [187636] = true, -- Aurelid Lattice
    [187633] = true, -- Bufonid Lattice
    [187635] = true, -- Cervid Lattice
    [189146] = true, -- Geomental Lattice
    [189145] = true, -- Helicid Lattice
    [189147] = true, -- Leporid Lattice
    [189388] = true, -- Lupine Lattice
    [189148] = true, -- Poultrid Lattice
    [189149] = true, -- Proto Avian Lattice
    [189150] = true, -- Raptora Lattice
    [189151] = true, -- Scarabid Lattice
    [189152] = true, -- Tarachnid Lattice
    [189153] = true, -- Unformed Lattice
    [189154] = true, -- Vespoid Lattice
    [189155] = true, -- Viperid Lattice
    [189156] = true, -- Vombata Lattice

    -- Glimmers (Battle Pet Items)
    [189157] = true, -- Glimmer of Animation
    [189158] = true, -- Glimmer of Cunning
    [189159] = true, -- Glimmer of Discovery
    [189160] = true, -- Glimmer of Focus
    [189161] = true, -- Glimmer of Malice
	[189162] = true, -- Glimmer of Metamorphosis
    [189164] = true, -- Glimmer of Multiplicity
    [189165] = true, -- Glimmer of Predation
    [189166] = true, -- Glimmer of Renewal
    [189167] = true, -- Glimmer of Satisfaction
    [189168] = true, -- Glimmer of Serenity
    [189169] = true, -- Glimmer of Survival
    [189170] = true, -- Glimmer of Vigilance

    -- Mount Crafting Items
    [189171] = true, -- Bauble of Pure Innovation
    [189172] = true, -- Crystalized Echo of the First Song
	[189173] = true, -- Eternal Ragepearl
    [189174] = true, -- Lens of Focused Intention
    [189175] = true, -- Mawforged Bridle
    [189176] = true, -- Protoform Sentience Crown
    [189177] = true, -- Revelation Key
    [189178] = true, -- Tools of Incomprehensible Experimentation
    [189179] = true, -- Unalloyed Bronze Ingot
    [189180] = true, -- Wind's Infinite Call
}

function protoformFilter:OnInitialize()
    self.db = AdiBags.db:RegisterNamespace("Protoform Synthesis", {
        profile = {
            filterProtoform = true,
        }
    })
end

function protoformFilter:Update()
    self:SendMessage("AdiBags_FiltersChanged")
end

function protoformFilter:OnEnable() AdiBags:UpdateFilters() end
function protoformFilter:OnDisable() AdiBags:UpdateFilters() end

function protoformFilter:Filter(slotData)
    if self.db.profile.filterProtoform and self.items[tonumber(slotData.itemId)] then
        return L["Protoform Synthesis"]
    end

    tooltip = tooltip or tooltipInit()
    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:ClearLines()

    if slotData.bag == BANK_CONTAINER then
        tooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(slotData.slot, nil))
    else
        tooltip:SetBagItem(slotData.bag, slotData.slot)
    end

    tooltip:Hide()
end

function protoformFilter:GetOptions()
    return {
        filterProtoform = {
            name = L["Protoform Synthesis"],
            type = "toggle",
            order = 10,
        },
    },
    AdiBags:GetOptionHandler(self, false, function() return self:Update() end)
end