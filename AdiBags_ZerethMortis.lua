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

local shardFilter = AdiBags:RegisterFilter("Zereth Mortis", 98, "ABEvent-1.0")
shardFilter.uiName = L["Zereth Mortis"]
shardFilter.uiDesc = L["Items relating to Zereth Mortis and patch 9.2."]

function shardFilter:OnInitialize()
    self.zerethMortis = {
        -- Crafting Materials
        [187703] = true, -- Silken Protofiber
        [187704] = true, -- Protoflesh
		
        -- Cosmetic Transmog
        [190637] = true, -- Percussive Maintenance Instrument

        -- Keys & Key Fragments
        [189863] = true, -- Spatial Opener
		
		-- Lore
		[187810] = true, -- Cypher Lore Codex
		
		-- Toys
		[190754] = true, -- Firim's Specimen Container
		
		-- Tales of the Exile Scrolls
		[189575] = true, -- Firim in Exile, Part 1
		[189576] = true, -- Firim in Exile, Part 2
		[189578] = true, -- Firim in Exile, Part 3
		[189579] = true, -- Firim in Exile, Part 4
		[189580] = true, -- Firim in Exile, Part 5
		[189581] = true, -- Firim in Exile, Part 6
		[189582] = true, -- Firim in Exile, Part 7
		[189753] = true, -- Firim in Exile, Epilogue
    }
end

function shardFilter:Updatee()
    self:SendMessage("AdiBags_FiltersChanged")
end

function shardFilter:OnEnable()
    AdiBags:UpdateFilters()
end

function shardFilter:OnDisable()
    AdiBags:UpdateFilters()
end

function shardFilter:Filter(slotData)
    if self.zerethMortis[tonumber(slotData.itemId)] then
        return L["Zereth Mortis"]
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
