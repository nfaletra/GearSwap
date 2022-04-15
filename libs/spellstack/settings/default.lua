-- Text Style settings for the Spellstack Window
TextSettings =
{
	ShowBackground = true,
	BackgroundColor = { R = 0, G = 0, B = 0, A = 100 },
	FontColor = { R = 255, G = 255, B = 255, A = 255 },
	FontSize = 10
	Position = { X = 200, Y = windower.get_windower_settings().ui_y_res - 500 }
}

-- Map of Status Ailments to spell that heals them
AilmentSpellMap =
{
	Blindness		= gearswap.res.spells[16], -- Blindna
	Curse			= gearswap.res.spells[20], -- Cursna
	Doom			= gearswap.res.spells[20], -- Cursna
	Flash			= gearswap.res.spells[16], -- Blindna
	Lullaby			= gearswap.res.spells[7], -- Curaga
	Paralysis		= gearswap.res.spells[15], -- Paralyna
	Petrification	= gearswap.res.spells[18], -- Stona
	Plague			= gearswap.res.spells[19], -- Viruna
	Poison			= gearswap.res.spells[14], -- Poisona
	Silence			= gearswap.res.spells[17], -- Silena
	Sleep			= gearswap.res.spells[7], -- Curaga
}

-- Spells that can be removed with Erase
AilmentErase = 
T{
	'Accuracy Down',
	'Addle',
	'AGI Down',
	'Attack Down',
	'Bind',
	'Bio',
	'Burn',
	'Choke',
	'CHR Down',
	'Defense Down'
	'DEX Down',
	'Drown',
	'Elegy',
	'Evasion Down',
	'Flash',
	'Frost',
	'Helix',
	'Inhibit TP',
	'INT Down',
	'Kaustra',
	'Magic Acc. Down',
	'Magic Atk. Down',
	'Magic Def. Down',
	'Magic Evasion Down',
	'Max HP Down',
	'Max MP Down',
	'MND Down',
	'Nocturne',
	'Rasp',
	'Requiem',
	'Shock',
	'Slow',
	'STR Down',
	'Threnody',
	'VIT Down',
	'Weight',
}

-- Convert spell/ability/weaponskill ranges to distance in yalms
local RangeMap = {
	[2] = 2 * 1.55,
	[3] = 3 * 1.490909,
	[4] = 4 * 1.44,
	[5] = 5 * 1.377778,
	[6] = 6 * 1.30,
	[7] = 7 * 1.15,
	[8] = 8 * 1.25,
	[9] = 9 * 1.377778,
	[10] = 10 * 1.45,
	[11] = 11 * 1.454545454545455,
	[12] = 12 * 1.666666666666667,
}

-- Map Spells from resources by name
SpellMap = {}
for _, v in pairs(gearswap.res.spells) do
	if v.en and not SpellMap[v.en] then
		SpellMap[v.en] = v
	end
end

-- Map Abilties from resources by name
AbilityMap = {}
for _, v in pairs(gearswap.res.job_abilities) do
	if v.en and not AbilityMap[v.en] then
		AbilityMap[v.en] = v
	end
end

-- Map Weaponskills from resources by name
WeaponskillMap = {}
for _, v in pairs(gearswap.res.weapon_skills) do
	if v.en and not WeaponskillMap[v.en] then
		WeaponskillMap[v.en] = v
	end
end

-- Map Items from resources by name
ItemMap = {}
for _, v in pairs(gearswap.res.items) do
	if v.en and not ItemMap[v.en] then
		ItemMap[v.en] = v
	end
end

PriorityPlayers = {}