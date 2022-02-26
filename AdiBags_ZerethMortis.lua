-------------------------------------------------------------------------------
-- AdiBags - Zereth Mortis By Crackpot (US, Illidan)
-------------------------------------------------------------------------------

local addonName, addon = ...
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

local tonumber = _G["tonumber"]

local L = addon.L
local tooltip
local filterList = {}

-- From: https://www.wowhead.com/guides/rare-spawn-treasure-locations-loot-zereth-mortis

-- Crafting Items
local crafting = {
    187728, -- Ephemera Strand
    187703, -- Silken Protofiber
    187707, -- Progenitor Essentia
    187704, -- Protoflesh
	187893, -- Volatile Precursor
}

-- Cosmetic Items
local cosmetic = {
    190637, -- Percussive Maintenance Instrument
    190952, -- Protoflora Harvester
    190942, -- Protomineral Extractor
    190638, -- Tormented Mawsteel Greatsword
}

-- Deepstar Polyp Items
local deepstar = {
    187923, -- Aurelid Lure
    187916, -- Coilclutch Vine
    187676, -- Deepstar Polyp
    187922, -- Flipper Fish
    187915, -- Pungent Blobfish
}

-- Keys & Key Fragments
local keys = {
    190198, -- Sandworm Chest Key Fragment
    189863, -- Spatial Opener
}

-- Lore Items
local lore = {
    187810, -- Cypher Lore Codex
}

-- Miscellaneous Items
local miscellaneous = {
    190339, -- Enlightened Offering
    187841, -- Explosive Core
    190953, -- Protofruit Flesh
    190739, -- Provis Wax
    187662, -- Strange Goop
    190189, -- Sandworm Relic
    190941, -- Teachings of the Elders
}

-- Pocopoc Cosmetic Items
local pocopoc = {
    190061, -- Admiral Pocopoc
    190060, -- Adventurous Pocopoc
    189451, -- Chef Pocopoc
    187833, -- Dapper Pocopoc
    190058, -- Peaceful Pocopoc
    190059, -- Pirate Pocopoc
    190098, -- Pepepec
}

-- Protoform Synthesis
local protoform = {
    187634, -- Ambystan Lattice
    187633, -- Bufonid Lattice
    187635, -- Cervid Lattice
    189146, -- Geomental Lattice
    189159, -- Glimmer of Discovery
    189145, -- Helicid Lattice
    190388, -- Lupine Lattice
    189176, -- Protoform Sentience Crown
    189150, -- Raptora Lattice
    189177, -- Revelation Key
    189151, -- Scarabid Lattice
    189152, -- Tarachnid Lattice
    189153, -- Unformed Lattice
    189154, -- Vespoid Lattice
    189155, -- Viperid Lattice
    189156, -- Vombata Lattice
}

-- Schematics
local schematics = {
    189478, -- Schematic: Adorned Vombata
    189435, -- Schematic: Multichicken
    189469, -- Schematic: Prototype Leaper
    189456, -- Schematic: Sundered Zerethsteed
    189447, -- Schematic: Viperid Menace
}

-- Toys
local toys = {
    190853, -- Bushel of Mysterious Fruit
    190754, -- Firim's Specimen Container
    190926, -- Infested Automa Core
    190457, -- Protopological Cube
}

-- Tales of the Exiled
local exile = {
    189575, -- Firim in Exile, Part 1
    189576, -- Firim in Exile, Part 2
    189578, -- Firim in Exile, Part 3
    189579, -- Firim in Exile, Part 4
    189580, -- Firim in Exile, Part 5
    189581, -- Firim in Exile, Part 6
    189582, -- Firim in Exile, Part 7
    189753, -- Firim in Exile, Epilogue
}

local function addToFilter(set, list)
    for _, v in ipairs(list) do
        set[v] = true
    end
end

local function filterItemsInit(self)
    local items = {}

    if self.db.profile.filterCrafting then addToFilter(items, crafting) end
    if self.db.profile.filterCosmetic then addToFilter(items, cosmetic) end
    if self.db.profile.filterDeepstar then addToFilter(items, deepstar) end
    if self.db.profile.filterExile then addToFilter(items, exile) end
    if self.db.profile.filterKeys then addToFilter(items, keys) end
    if self.db.profile.filterLore then addToFilter(items, lore) end
    if self.db.profile.filterMisc then addToFilter(items, miscellaneous) end
    if self.db.profile.filterPocopoc then addToFilter(items, pocopoc) end
    if self.db.profile.filterProtoform then addToFilter(items, protoform) end
    if self.db.profile.filterSchematics then addToFilter(items, schematics) end
    if self.db.profile.filterToys then addToFilter(items, toys) end

    return items
end

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
    self.db = AdiBags.db:RegisterNamespace("Zereth Mortis", {
        profile = {
            filterCrafting = true,
            filterCosmetic = true,
            filterDeepstar = true,
            filterExile = true,
            filterKeys = true,
            filterLore = true,
            filterMisc = true,
            filterPocopoc = true,
            filterProtoform = true,
            filterSchematics = true,
            filterToys = true,
        }
    })
end

function shardFilter:Update()
    filterItems = nil
    self:SendMessage("AdiBags_FiltersChanged")
end

function shardFilter:OnEnable()
    AdiBags:UpdateFilters()
end

function shardFilter:OnDisable()
    AdiBags:UpdateFilters()
end

function shardFilter:Filter(slotData)
    filterItems = filterItems or filterItemsInit(self)
    if filterItems[tonumber(slotData.itemId)] then
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

function shardFilter:GetOptions()
    return {
        filterCrafting = {
            name = L["Crafting Materials"],
            desc = L["Items used in crafting new items added in 9.2."],
            type = "toggle",
            order = 10,
        },
        filterCosmetic = {
            name = L["Cosmetic Items"],
            desc = L["Cosmetic (Transmogrification) items added in 9.2."],
            type = "toggle",
            order = 20,
        },
        filterDeepstar = {
            name = L["Deepstar Polyp Items"],
            desc = L["Items required to craft the lure to get the Deepstar Polyp mount."],
            type = "toggle",
            order = 30,
        },
        filterKeys = {
            name = L["Keys & Key Fragments"],
            desc = L["Keys and key fragments added in 9.2."],
            type = "toggle",
            order = 40,
        },
        filterLore = {
            name = L["Lore Items"],
            type = "toggle",
            order = 50,
        },
        filterMisc = {
            name = L["Miscellaneous"],
            type = "toggle",
            order = 60,
        },
        filterPocopoc = {
            name = L["Pocopoc Costumes"],
            type = "toggle",
            order = 70,
        },
        filterProtoform = {
            name = L["Protoform Synthesis"],
            type = "toggle",
            order = 80,
        },
        filterSchematics = {
            name = L["Schematics"],
            type = "toggle",
            order = 90,
        },
        filterToys = {
            name = L["Toys"],
            type = "toggle",
            order = 100,
        },
        filterExile = {
            name = L["Tales of the Exile"],
            desc = L["Items required for the Tales of the Exile achievement."],
            type = "toggle",
            order = 110,
        },
    },
    AdiBags:GetOptionHandler(self, false, function() return self:Update() end)
end
