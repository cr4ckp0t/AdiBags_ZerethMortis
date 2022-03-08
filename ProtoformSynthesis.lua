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
    [187634] = true, -- Ambystan Lattice
    [187633] = true, -- Bufonid Lattice
    [187635] = true, -- Cervid Lattice
    [189146] = true, -- Geomental Lattice
    [188957] = true, -- Genesis Mote
    [189157] = true, -- Glimmer of Animation
    [189159] = true, -- Glimmer of Discovery
    [189160] = true, -- Glimmer of Focus
    [189164] = true, -- Glimmer of Multiplicity
    [189167] = true, -- Glimmer of Satisfaction
    [189145] = true, -- Helicid Lattice
    [190388] = true, -- Lupine Lattice
    [189176] = true, -- Protoform Sentience Crown
    [189150] = true, -- Raptora Lattice
    [189177] = true, -- Revelation Key
    [189151] = true, -- Scarabid Lattice
    [189152] = true, -- Tarachnid Lattice
    [189153] = true, -- Unformed Lattice
    [189154] = true, -- Vespoid Lattice
    [189155] = true, -- Viperid Lattice
    [189156] = true, -- Vombata Lattice
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