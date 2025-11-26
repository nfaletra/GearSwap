-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal', 'Hybrid', 'FullDT', 'MEVA', 'Evasion', 'Tank', 'Cait')
	state.RangedMode:options('Normal')
	state.WeaponskillMode:options('Match', 'Normal', 'PDL', 'Proc')
	state.IdleMode:options('Normal', 'Evasion')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Aeneas', 'Gandring', 'Aeolian', 'Savage', 'Evisceration', 'Trial', 'Karambit', 'Throwing', 'SwordThrowing', 'Bow')

	state.ExtraMeleeMode = M{ ['description'] = 'Extra Melee Mode', 'None', 'Suppa', 'DWMax', 'Parry'}
	state.AmbushMode = M(false, 'Ambush Mode')

	gear.Toutatis =
	{
		TP = { name = "Toutatis's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Store TP"+10', 'Damage taken-5%' } },
		WSD = { name = "Toutatis's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%' } },
		DW = { name = "Toutatis's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dual Wield"+10', 'Phys. dmg. taken-10%' } }
	}

	-- Additional local binds
	send_command('bind ^` input /ja "Flee" <me>')
	send_command('bind !` input /ra <t>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace input /item "Thief\'s Tools" <t>')
	send_command('bind ^q gs c weapons ProcWeapons;gs c set WeaponSkillMode proc;')
	send_command('bind !q gs c weapons SwordThrowing')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind @r gs c weapons Default;gs c set WeaponSkillMode match') --Requips weapons and gear.
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Special sets (required by rules)
	--------------------------------------
	sets.TreasureHunter = { hands = "Plun. Armlets +3", feet = "Skulk. Poulaines +2" }
	sets.Kiting = { ring1 = "Shneddick Ring" }

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}

	sets.buff['Sneak Attack'] = {}
	sets.buff['Trick Attack'] = { hands = "Pill. Armlets +3" }

	-- Extra Melee sets.  Apply these on top of melee sets.
	sets.Knockback = {}
	sets.Suppa = { ear1 = "Sherida Earring", ear2 = "Suppanomimi" }
	sets.DWEarrings = { ear1 = "Eabani Earring", ear2 = "Suppanomimi" }
	sets.DWMax = { ear1 = "Eabani Earring", ear2 = "Suppanomimi", body = gear.adhemar.body.b, hands = "Floral Gauntlets", waist = "Reiki Yotai" }
	sets.Parry = {}
	sets.Ambush = {}

	-- Weapons sets
	sets.weapons.Aeneas = { main = "Aeneas", sub = "Centovente" }
	sets.weapons.Gandring = { main = "Gandring", sub = "Gleti's Knife" }
	sets.weapons.Aeolian = { main = "Gandring", sub = "Malevolence" }
	sets.weapons.Savage = { main = "Naegling", sub = "Gleti's Knife" }
	sets.weapons.Evisceration = { main = "Tauret", sub = "Gleti's Knife" }
	sets.weapons.Trial = { main = "Fusetto +3", sub = "Gleti's Knife" }
	sets.weapons.Karambit = { main = "Karambit" }
	sets.weapons.Throwing = { main = "Aeneas", sub = "Gleti's Knife", range = "Raider's Bmrng.", ammo = empty }
	sets.weapons.SwordThrowing = { main = "Naegling", sub = "Gleti's Knife", range = "Raider's Bmrng.", ammo = empty }
	sets.weapons.Bow = { main = "Aeneas", sub = "Kustawi +1", range = "Kaja Bow", ammo = "Chapuli Arrow" }

	-- Actions we want to use to tag TH.
	sets.precast.Step =
	{
		ammo = "C. Palug Stone",
		head = "Malignance Chapeau", neck = "Combatant's Torque", ear1 = "Mache Earring +1", ear2 = "Odr Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Ramuh Ring +1", ring2 = "Ramuh Ring +1",
		back = gear.Toutatis.TP, waist = "Olseni Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.JA['Violent Flourish'] =
	{
		ammo = "C. Palug Stone",
		head = "Malignance Chapeau", neck = "Combatant's Torque", ear1 = "Digni. Earring", ear2 = "Odr Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Ramuh Ring +1", ring2 = "Ramuh Ring +1",
		back = gear.Toutatis.TP, waist = "Olseni Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Collaborator'] = { head = "Skulker's Bonnet +2" }
	sets.precast.JA['Accomplice'] = { head = "Skulker's Bonnet +2" }
	sets.precast.JA['Flee'] = { feet = "Rogue's Poulaines" }
	sets.precast.JA['Hide'] = { body = "Rogue's Vest" }
	sets.precast.JA['Conspirator'] = {} 
	sets.precast.JA['Steal'] = { head = "Rogue's Bonnet", hands = "Rogue's Armlets", legs = "Rogue's Culottes", feet = "Rogue's Poulaines" }
	sets.precast.JA['Mug'] = {}
	sets.precast.JA['Despoil'] = { ammo = "Barathrum", legs = "Raider's Culottes +1", feet = "Skulk. Poulaines +2" }
	sets.precast.JA['Perfect Dodge'] = { hands = "Plun. Armlets +3" }
	sets.precast.JA['Feint'] = { legs = "Plun. Culottes +3" }

	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
	sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

	-- Waltz set (chr and vit)
	sets.precast.Waltz =
	{
		ammo = "Yamarang",
		head = "Mummu Bonnet +2", neck = "Unmoving Collar +1", ear1 = "Enchntr. Earring +1",
		ring2 = "Defending Ring",
	}

	sets.Self_Waltz = { head = "Mummu Bonnet +2" }

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		ammo = "Sapience Orb",
		head = gear.herculean_fc_head, ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = gear.adhemar.body.d, hands = "Leyline Gloves", ring1 = "Rahab Ring", ring2 = "Medada's Ring",
		legs = "Limbo Trousers"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	-- Ranged snapshot gear
	sets.precast.RA = {}

	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Plun. Bonnet +3", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Ilabrat Ring", ring2 = "Regal Ring",
		back = gear.Toutatis.WSD, waist = "Kentarch Belt +1", legs = "Nyame Flanchard", feet = "Plun. Poulaines +3"
	}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Rudra's Storm"] =
	{
		ammo = "Coiste Bodhar",
		head = "Nyame Helm", neck = "Asn. Gorget +2", ear1 = "Odr Earring", ear2 = "Moonshade Earring",
		body = "Skulker's Vest +2", hands = "Nyame Gauntlets", ring1 = "Ilabrat Ring", ring2 = "Regal Ring",
		back = gear.Toutatis.WSD, waist = "Kentarch Belt +1", legs = "Plun. Culottes +3", feet = "Nyame Sollerets"
	}
	sets.precast.WS["Rudra's Storm"].PDL = set_combine(sets.precast.WS["Rudra's Storm"],
	{
		ammo = "Crepuscular Pebble",
		head = "Skulker's Bonnet +2", ear1 = "Odr Earring",
		hands = "Gleti's Gauntlets", ring1 = "Epaminondas's Ring",
		legs = "Gleti's Breeches",
	})
	sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"],
	{
		ammo = "Yetshila +1",
		head = "Pill. Bonnet +3", ear1 = "Odr Earring",
	})
	sets.precast.WS["Rudra's Storm"].SA.PDL = set_combine(sets.precast.WS["Rudra's Storm"].SA, {})
	sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].SA, {})
	sets.precast.WS["Rudra's Storm"].TA.PDL = set_combine(sets.precast.WS["Rudra's Storm"].SA.PDL, {})
	sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].SA, {})
	sets.precast.WS["Rudra's Storm"].SATA.PDL = set_combine(sets.precast.WS["Rudra's Storm"].SA.PDL, {})

	sets.precast.WS["Mandalic Stab"] = set_combine(sets.precast.WS["Rudra's Storm"],
	{
		head = "Skulker's Bonnet +2",
	})
	sets.precast.WS["Mandalic Stab"].PDL = set_combine(sets.precast.WS["Mandalic Stab"], sets.precast.WS["Rudra's Storm"].PDL, {})
	sets.precast.WS["Mandalic Stab"].SA = set_combine(sets.precast.WS["Rudra's Storm"].SA, {})
	sets.precast.WS["Mandalic Stab"].SA.PDL = set_combine(sets.precast.WS["Rudra's Storm"].SA.PDL, {})
	sets.precast.WS["Mandalic Stab"].TA = set_combine(sets.precast.WS["Rudra's Storm"].SA, {})
	sets.precast.WS["Mandalic Stab"].TA.PDL = set_combine(sets.precast.WS["Rudra's Storm"].TA.PDL, {})
	sets.precast.WS["Mandalic Stab"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].SA, {})
	sets.precast.WS["Mandalic Stab"].SATA.PDL = set_combine(sets.precast.WS["Rudra's Storm"].SATA.PDL, {})

	sets.precast.WS['Shark Bite'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Nyame Helm", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Meg. Gloves +2", ring1 = "Ilabrat Ring", ring2 = "Regal Ring",
		back = gear.Toutatis.WSD, waist = "Grunfeld Rope", legs = "Plun. Culottes +3", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Shark Bite'] = set_combine(sets.precast.WS['Shark Bite'],
	{
		ammo = "Crepuscular Pebble",
		head = "Pill. Bonnet +3",
		body = "Gleti's Cuirass",
		waist = "Kentarch Belt +1", legs = "Gleti's Breeches"
	})

	sets.precast.WS['Evisceration'] =
	{
		ammo = "Yetshila +1",
		head = "Blistering Sallet +1", neck = "Fotia Gorget", ear1 = "Odr Earring", ear2 = "Moonshade Earring",
		body = "Plunderer's Vest +3", hands = gear.adhemar.hands.b, ring1 = "Begrudging Ring", ring2 = "Regal Ring",
		back = gear.Toutatis.WSD, waist = "Fotia Belt", legs = "Pill. Culottes +3", feet = "Adhe. Gamashes +1"
	}
	sets.precast.WS['Evisceration'].PDL = set_combine(sets.precast.WS['Evisceration'],
	{
		head = "Skulker's Bonnet +2",
		hands = "Gleti's Gauntlets",
		legs = "Gleti's Breeches", feet = "Gleti's Boots"
	})

	sets.precast.WS['Exenterator'] =
	{
		ammo = "C. Palug Stone",
		head = "Skulker's Bonnet +2", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Balder Earring +1",
		body = "Plunderer's Vest +3", hands = "Meg. Gloves +2", ring1 = "Ilabrat Ring", ring2 = "Regal Ring",
		back = gear.Toutatis.WSD, waist = "Fotia Belt", legs = "Meg. Chausses +2", feet = "Plun. Poulaines +3"
	}
	sets.precast.WS['Exenterator'].PDL = set_combine(sets.precast.WS['Exenterator'],
	{
		ammo = "Crepuscular Pebble",
		body = "Gleti's Cuirass", hands = "Malignance Gloves", ring2 = "Gere Ring",
		legs = "Malignance Gloves", feet = "Malignance Boots"
	})

	sets.precast.WS['Dancing Edge'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Skulker's Bonnet +2", neck = "Warder's Charm +1", ear1 = "Sherida Earring", ear2 = "Balder Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Mujin Band",
		back = "Sacro Mantle", waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS["Savage Blade"] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Telos Earring", ear2 = "Moonshade Earring",
		body = "Skulker's Vest +2", hands = "Nyame Gauntlets", ring1 = "Epaminondas's Ring", ring2 = "Regal Ring",
		back = gear.Toutatis.WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS["Savage Blade"].PDL = set_combine(sets.precast.WS["Savage Blade"],
	{
		ammo = "Crepuscular Pebble",
		head = "Skulker's Bonnet +2", neck = "Asn Gorget +2", ear1 = "Moonshade Earring",
		hands = "Gleti's Gauntlets", ring2 = "Sroda Ring",
	})

	sets.precast.WS.Proc =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau",
		body = "Malignance Tabard", hands = "Malignance Gloves",
		legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Last Stand'] =
	{
		head = "Pill. Bonnet +3", neck = "Fotia Gorget", ear1 = "Telos Earring", ear2 = "Enervating Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Crepuscular Ring", ring2 = "Regal Ring",
		back = gear.Toutatis.WSD, waist = "Fotia Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Empyreal Arrow'] =
	{
		head = "Pill. Bonnet +3", neck = "Fotia Gorget", ear1 = "Telos Earring", ear2 = "Enervating Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Apate Crepuscular", ring2 = "Regal Ring",
		back = gear.Toutatis.WSD, waist = "Fotia Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Aeolian Edge'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Nyame Helm", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Dingir Ring",
		back = gear.Toutatis.WSD, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = { ear1 = "Sherida Earring", ear2 = "Ishvara Earring" }
	sets.AccMaxTP = { ear1 = "Sherida Earring", ear2 = "Odr Earring" }

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	sets.midcast.FastRecast =
	{
		ammo = "Sapience Orb",
		head = gear.herculean_fc_head, ear1 = "Loquac. Earring",
		hands = "Leyline Gloves",
		legs = "Limbo Trousers", feet = "Malignance Boots"
	}

	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Poisonga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Sleepga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

	sets.midcast['Absorb-TP'] = set_combine(sets.midcast.FastRecast,
	{
		ammo = "Pemphredo Tathlum",
		head = "Malignance Chapeau", neck = "Sanctity Necklace", ear1 = "Crep. Earring", ear2 = "Hermetic Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Medada's Ring", ring2 = "Metamor. Ring +1",
		waist = "Eschan Stone", legs = "Malignance Tights", feet = "Malignance Boots"
	})

	-- Ranged gear

	sets.midcast.RA =
	{
		head = "Malignance Chapeau", neck = "Iskur Gorget", ear1 = "Telos Earring", ear2 = "Enervating Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Crepuscular Ring", ring2 = "Regal Ring",
		back = gear.Toutatis.TP, waist = "Chaac Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {})

	--------------------------------------
	-- Idle/resting/defense sets
	--------------------------------------
	-- Resting sets
	sets.resting = {}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle =
	{
		ammo = "Staunch Tathlum +1",
		head = "Malignance Chapeau", neck = "Loricate Torque +1", ear1 = "Sherida Earring", ear2 = "Etiolation Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Gere Ring", ring2 = "Defending Ring",
		back = gear.Toutatis.TP, waist = "Reiki Yotai", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.idle.Evasion =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Balder Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Gere Ring", ring2 = "Petrov Ring",
		back = gear.Toutatis.TP, waist = "Reiki Yotai", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.idle.Weak = set_combine(sets.idle, {})

	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.ExtraRegen = { hands = "Turms Mittens +1" }

	--------------------------------------
	-- Melee sets
	--------------------------------------
	-- Normal melee group
	sets.engaged =
	{
		ammo = "Aurgelmir Orb",
		head = "Skulker's Bonnet +2", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Skulk. Earring +1",
		body = "Pillager's Vest +3", hands = "Gleti's Gauntlets", ring1 = "Gere Ring", ring2 = "Hetairoi Ring",
		back = gear.Toutatis.TP, waist = "Reiki Yotai", legs = "Gleti's Breeches", feet = "Plun. Poulaines +3"
	}
	sets.engaged.Haste30 = set_combine(sets.engaged,
	{
		ear1 = "Eabani Earring", ear2 = "Suppanomimi",
		back = gear.Toutatis.DW,
	})
	sets.engaged.Haste15 = set_combine(sets.engaged.Haste30,
	{
		body = gear.adhemar.body.b, hands = "Pill. Armlets +3"
	})
	sets.engaged.Haste0 = set_combine(sets.engaged.Haste15,
	{
		-- hands = "Herculean Gloves", -- 6% DW
		-- feet = "Herculean Boots" -- 5% DW
	})

	sets.engaged.Hybrid =
	{
		ammo = "Aurgelmir Orb",
		head = "Malignance Chapeau", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Skulk. Earring +1",
		body = "Pillager's Vest +3", hands = "Malignance Gloves", ring1 = "Gere Ring", ring2 = "Moonlight Ring",
		back = gear.Toutatis.TP, waist = "Reiki Yotai", legs = "Pill. Culottes +3", feet = "Plun. Poulaines +3"
	}
	sets.engaged.Hybrid.Haste30 = set_combine(sets.engaged.Hybrid,
	{
		ear1 = "Eabani Earring", ear2 = "Suppanomimi",
		hands = gear.adhemar.hands.a,
		back = gear.Toutatis.DW, legs = "Malignance Tights",
	})
	sets.engaged.Hybrid.Haste15 = set_combine(sets.engaged.Hybrid.Haste30,
	{
		body = gear.adhemar.body.b, hands = "Pill. Armlets +3"
	})
	sets.engaged.Hybrid.Haste0 = set_combine(sets.engaged.Hybrid.Haste15, {})

	sets.engaged.FullDT =
	{
		ammo = "Staunch Tathlum +1",
		head = "Malignance Chapeau", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Dedition Earring",
		body = "Pillager's Vest +3", hands = "Malignance Gloves", ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = gear.Toutatis.TP, waist = "Reiki Yotai", legs = "Malignance Tights", feet = "Plun. Poulaines +3"
	}

	sets.engaged.MEVA =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Suppanomimi",
		body = "Pillager's Vest +3", hands = "Malignance Gloves", ring1 = "Gere Ring", ring2 = "Moonlight Ring",
		back = gear.Toutatis.TP, waist = "Engraved Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.engaged.Evasion =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Balder Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Gere Ring", ring2 = "Petrov Ring",
		back = gear.Toutatis.TP, waist = "Reiki Yotai", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.engaged.Tank =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Balder Earring +1",
		body = "Malignance Tabard", hands = "Turms Mittens +1", ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = gear.Toutatis.TP, belt = "Reiki Yotai", legs = "Malignance Tights", feet = "Turms Leggings +1"
	}

	sets.engaged.Cait =
	{
		ammo = "Coiste Bodhar",
		head = "Malignance Chapeau", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Eabani Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Gere Ring", ring2 = "Epona's Ring",
		back = gear.Toutatis.TP, waist = "Reiki Yotai", legs = "Malignance Tights", feet = "Malignance Boots"
	}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(1, 2)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 002')
end

--Job Specific Trust Override
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()

				if spell_recasts[993] < spell_latency and not have_trust("Lilisette") then
					windower.chat.input('/ma "Lilisette II" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[955] < spell_latency and not have_trust("Yoran-Oran") then
					windower.chat.input('/ma "Yoran-Oran (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.chat.input('/ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.chat.input('/ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.chat.input('/ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				else
					return false
				end
			end
		end
	end
	return false
end

autows_list = {
	['Aeneas']="Rudra's Storm",['Aeolian']='Aeolian Edge',['Savage']='Savage Blade',['AccSavage']='Savage Blade',
	['AccAeneas']='Savage Blade',['ProcWeapons']='Wasp Sting'
}