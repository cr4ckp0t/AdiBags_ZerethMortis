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
        -- From: https://www.wowhead.com/guides/rare-spawn-treasure-locations-loot-zereth-mortis

        -- Crafting Materials
        [187703] = true, -- Silken Protofiber
		[187707] = true, -- Progenitor Essentia
        [187704] = true, -- Protoflesh
        
        -- Cosmetic Transmog
        [190637] = true, -- Percussive Maintenance Instrument
        [190952] = true, -- Protoflora Harvester
        [190942] = true, -- Protomineral Extractor
        [190638] = true, -- Tormented Mawsteel Greatsword

        -- Keys & Key Fragments
        [190198] = true, -- Sandworm Chest Key Fragment
        [189863] = true, -- Spatial Opener
        
        -- Lore
        [187810] = true, -- Cypher Lore Codex
        
        -- Miscellaneous
        [190339] = true, -- Enlightened Offering
		[187841] = true, -- Explosive Core
        [190953] = true, -- Protofruit Flesh
		[190739] = true, -- Provis Wax
        [187662] = true, -- Strange Goop
        [190189] = true, -- Sandworm Relic
        [190941] = true, -- Teachings of the Elders

        -- Pocopoc Attire
        [190061] = true, -- Admiral Pocopoc
        [190060] = true, -- Adventurous Pocopoc
        [189451] = true, -- Chef Pocopoc
        [187833] = true, -- Dapper Pocopoc
        [190058] = true, -- Peaceful Pocopoc
        [190059] = true, -- Pirate Pocopoc
        [190098] = true, -- Pepepec

        -- Protoform Synthesis
        [187634] = true, -- Ambystan Lattice
        [187633] = true, -- Bufonid Lattice
        [187635] = true, -- Cervid Lattice
        [189146] = true, -- Geomental Lattice
        [189159] = true, -- Glimmer of Discovery
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

        -- Schematics
        [189478] = true, -- Schematic: Adorned Vombata
        [189435] = true, -- Schematic: Multichicken
        [189469] = true, -- Schematic: Prototype Leaper
        [189456] = true, -- Schematic: Sundered Zerethsteed
        [189447] = true, -- Schematic: Viperid Menace

        -- Toys
        [190853] = true, -- Bushel of Mysterious Fruit
        [190754] = true, -- Firim's Specimen Container
        [190926] = true, -- Infested Automa Core
        [190457] = true, -- Protopological Cube
        
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
