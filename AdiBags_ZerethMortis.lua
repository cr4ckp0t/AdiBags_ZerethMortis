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
