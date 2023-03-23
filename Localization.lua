-------------------------------------------------------------------------------
-- AdiBags - Zereth Mortis By Crackpot (US, Illidan)
-------------------------------------------------------------------------------
local addonName, addon = ...

local L =
	setmetatable(
	{},
	{
		__index = function(self, key)
			if key then
				rawset(self, key, tostring(key))
			end
			return tostring(key)
		end
	}
)
addon.L = L

local locale = GetLocale()

if locale == "deDE" then
	--Translation missing
elseif locale == "enUS" then
	L["Cosmetic (Transmogrification) items added in 9.2."] = true
	L["Cosmetic Items"] = true
	L["Crafting Materials"] = true
	L["Deepstar Polyp Items"] = true
	L["Items relating to Protoform Synthesis."] = true
	L["Items relating to Zereth Mortis and patch 9.2."] = true
	L["Items required for the Tales of the Exile achievement."] = true
	L["Items required to craft the lure to get the Deepstar Polyp mount."] = true
	L["Items used in crafting new items added in 9.2."] = true
	L["Keys & Key Fragments"] = true
	L["Keys and key fragments added in 9.2."] = true
	L["Lore Items"] = true
	L["Miscellaneous"] = true
	L["Pocopoc Costumes"] = true
	L["Protoform Synthesis"] = true
	L["Schematics"] = true
	L["Tales of the Exile"] = true
	L["Toys"] = true
	L["Zereth Mortis"] = true	
elseif locale == "esES" then
	--Translation missing
elseif locale == "esMX" then
	--Translation missing
elseif locale == "frFR" then
	L["Cosmetic (Transmogrification) items added in 9.2."] = "Objets cosmétiques (transmogrifications) ajoutés dans le Patch 9.2"
	L["Cosmetic Items"] = "Objets cosmétiques"
	L["Crafting Materials"] = "Matériaux d'artisanat"
	L["Deepstar Polyp Items"] = "Objets pour le Polype stellaire"
	L["Items relating to Protoform Synthesis."] = "Objets liés à la Synthèse de protoforme"
	L["Items relating to Zereth Mortis and patch 9.2."] = "Objets liés à Zereth Mortis et au Patch 9.2"
	L["Items required for the Tales of the Exile achievement."] = "Objets requis pour le haut fait Récits de l’exil"
	L["Items required to craft the lure to get the Deepstar Polyp mount."] = "Objets requis pour confectionner l'hameçon pour la monture Polype stellaire des profondeurs"
	L["Items used in crafting new items added in 9.2."] = "Objets utilisés pour l'artisanat du Patch 9.2"
	L["Keys & Key Fragments"] = "Clés et fragments de clé"
	L["Keys and key fragments added in 9.2."] = "Clés et fragments de clés aujoutés dans le Patch 9.2"
	L["Lore Items"] = "Objets d'histoire"
	L["Miscellaneous"] = "Divers"
	L["Pocopoc Costumes"] = "Costumes de pocopoc"
	L["Protoform Synthesis"] = "Synthèse de protoforme"
	L["Schematics"] = "Schémas"
	L["Tales of the Exile"] = "Récits de l’exil"
	L["Toys"] = "Jouets"
	L["Zereth Mortis"] = "Zereth Mortis"	
elseif locale == "itIT" then
	--Translation missing
elseif locale == "koKR" then
	--Translation missing
elseif locale == "ptBR" then
	--Translation missing
elseif locale == "ruRU" then
	--Translation missing
elseif locale == "zhCN" then
	--Translation missing
elseif locale == "zhTW" then
--Translation missing
end

-- values by their key
for k, v in pairs(L) do
	if v == true then
		L[k] = k
	end
end
