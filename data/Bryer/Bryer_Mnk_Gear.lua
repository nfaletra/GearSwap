function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Match', 'Normal', 'AttackCapped', 'Proc')
	state.HybridMode:options('Normal', 'DT', 'Counter')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'DT', 'Evasion')
	state.Weapons:options('Godhands', 'Staff', 'Club', 'ProcStaff', 'ProcClub', 'ProcSword', 'ProcGreatSword', 'ProcScythe', 'ProcPolearm', 'ProcGreatKatana', 'Barehanded')

	state.ExtraMeleeMode = M{['description'] = 'Extra Melee Mode', 'None', 'Staff'}

	update_melee_groups()
	
	-- Additional local binds
	send_command('bind ^` input /ja "Boost" <me>')
	send_command('bind !` input /ja "Perfect Counter" <me>')
	send_command('bind ^backspace input /ja "Mantra" <me>')
	send_command('bind @` gs c cycle SkillchainMode')

	-- Job Gear
	gear.Segomo = {}
	gear.Segomo.TP = { name = "Segomo's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dbl.Atk."+10', 'Damage taken-5%' } }
	gear.Segomo.STR_DA = { name = "Segomo's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%' } }
	gear.Segomo.INT_WDS = { name = "Segomo's Mantle", augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%' } }

	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets

	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = { legs = "Hes. Hose +3" }
	sets.precast.JA['Boost'] = { hands = "Anchor. Gloves +3" }
	sets.precast.JA['Boost'].OutOfCombat = { hands = "Anchor. Gloves +3" }
	sets.precast.JA['Dodge'] = { feet = "Anch. Gaiters +3" }
	sets.precast.JA['Focus'] = { head = "Anchor. Crown +1" }
	sets.precast.JA['Counterstance'] = { feet = "Hes. Gaiters +3" }
	sets.precast.JA['Footwork'] = { feet = "Shukuyu Sune-Ate" }
	sets.precast.JA['Formless Strikes'] = { body = "Hes. Cyclas +3" }
	sets.precast.JA['Mantra'] = { feet = "Hes. Gaiters +3" }

	sets.precast.JA['Chi Blast'] = {}

	sets.precast.JA['Chakra'] =
	{
		head = "Genmei Kabuto", neck = "Unmoving Collar +1", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Anch. Cyclas +1", hands = "Hes. Gloves +3", ring1 = "Niqmaddu Ring", ring2 = "Regal Ring",
		legs = "Tatena. Haidate +1", feet = "Anch. Gaiters +3"
	}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = 
	{
		ammo = "Falcon Eye",
		head = "Malignance Chapeau", ear1 = "Mache Earring +1", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves",
		back = gear.Segomo.TP, legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.Flourish1 =
	{
		ammo = "Falcon Eye",
		head = "Malignance Chapeau", ear1 = "Mache Earring +1", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves",
		back = gear.Segomo.TP, legs = "Malignance Tights", feet = "Malignance Boots"
	}

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		ammo = "Sapience Orb",
		head = gear.herculean_fc_head, ear1="Loquac. Earring",
		hands = "Leyline Gloves", ring1 = "Kishar Ring",
		legs = "Limbo Trousers"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC,
	{
		body = "Passion Jacket", neck = "Magoraga Beads"
	})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = gear.adhemar.body.b, hands = gear.adhemar.hands.b, ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.STR_DA, waist = "Moonbow Belt", legs = "Mpaca's Hose", feet = gear.herculean_ta_feet
	}
	sets.precast.WS.AttackCapped = set_combine(sets.precast.WS,
	{
		ammo = "Crepuscular Pebble",
		neck = "Mnk. Nodowa +2",
		body = "Malignance Tabard"
	})

	-- Specific weaponskill sets.
	sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS,
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = gear.adhemar.body.b, hands = gear.adhemar.hands.b, ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.STR_DA, waist = "Moonbow Belt", legs = "Mpaca's Hose", feet = gear.herculean_ta_feet
	})
	sets.precast.WS["Raging Fists"].AttackCapped = set_combine(sets.precast.WS['Raging Fists'], sets.precast.WS.AttackCapped)

	sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS,
	{
		body = "Ken. Samue", hands = gear.herculean_ta_hands,
	})
	sets.precast.WS['Howling Fist'].AttackCapped = set_combine(sets.precast.WS['Howling Fist'], sets.precast.WS.AttackCapped)

	sets.precast.WS['Asuran Fists'] =
	{
		ammo = "Knobkierre",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Odr Earring",
		body = "Mpaca's Doublet", hands = "Hes. Gloves +3", ring1 = "Niqmaddu Ring", ring2 = "Regal Ring",
		back = gear.Segomo.STR_DA, waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Hes. Gaiters +3"
	}
	sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)

	sets.precast.WS["Ascetic's Fury"] =
	{
		ammo = "Knobkierre",
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = "Ken. Samue", hands = "Ryuo Tekko +1", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.STR_DA, waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}
	sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc)

	sets.precast.WS["Victory Smite"] =
	{
		ammo = "Coiste Bodhar",
		head = "Adhemar Bonnet +1", neck = "Mnk. Nodowa +2", ear1 = "Sherida Earring", ear2 = "Odr Earring",
		body = "Ken. Samue", hands = "Ryuo Tekko +1", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.STR_DA, waist = "Moonbow Belt", legs = "Mpaca's Hose", feet = gear.herculean_crit_feet
	}
	sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc)

	sets.precast.WS['Shijin Spiral'] =
	{
		ammo = "Aurgelmir Orb",
		head = "Ken. Jinpachi", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Mache Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt", legs = "Tatena. Haidate +1", feet = gear.herculean_ta_feet
	}
	sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)

	sets.precast.WS['Dragon Kick'] =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Mnk. Nodowa +2", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = "Ken. Samue", hands = "Anchor. Gloves +3", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.STR_DA, waist = "Moonbow Belt", legs = "Mpaca's Hose", feet = "Anch. Gaiters +3"
	}
	sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)

	sets.precast.WS['Tornado Kick'] =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Mnk. Nodowa +2", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = "Ken. Samue", hands = gear.herculean_ta_hands, ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.STR_DA, waist = "Moonbow Belt", legs = "Mpaca's Hose", feet = "Anch. Gaiters +3"
	}
	sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

	sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Spinning Attack'].Acc = set_combine(sets.precast.WS['Spinning Attack'], {})

	sets.precast.WS['Cataclysm'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Pixie Hairpin +1", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Archon Ring", ring2 = "Metamor. Ring +1",
		back = gear.Segomo.INT_WSD, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Cataclysm'].Acc = set_combine(sets.precast.WS['Cataclysm'], sets.precast.WSAcc)

	sets.precast.WS['Shell Crusher'] =
	{
		ammo = "Pemphredo Tathluma",
		head = "Malignance Chapeau", neck = "Fotia Gorget", ear1 = "Digni. Earring", ear2 = "Crep. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Stikini Ring +1", ring2 = "Metamor. Ring +1",
		back = gear.Segomo.INT_WSD, waist = "Fotia Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	sets.precast.WS['Shell Crusher'] = set_combine(sets.precast.WS['Shell Crusher'], sets.precast.WSAcc)
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = { ear1 = "Sherida Earring", ear2 = "Brutal Earring" }
	sets.AccMaxTP = { ear1 = "Sherida Earring", ear2 = "Brutal Earring" }
	
	-- Midcast Sets
	sets.midcast.FastRecast =
	{
		ammo="Staunch Tathlum +1",
		head=gear.herculean_fc_head, ear1 = "Loquac. Earring",
		hands = "Leyline Gloves",
		legs = "Limbo Trousers"
	}

	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = { body="Hes. Cyclas +3" }

	-- Idle sets
	sets.idle =
	{
		ammo = "Staunch Tathlum +1",
		head = "Mpaca's Cap", neck = "Mnk. Nodowa +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Mpaca's Doublet", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}

	sets.idle.DT =
	{
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Mnk. Nodowa +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Mpaca's Doublet", hands = "Nyame Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt", legs = "Mpaca's Hose", feet = "Nyame Sollerets"
	}

	sets.idle.Evasion =
	{
		ammo = "Staunch Tathlum +1",
		head = "Malignance Chapeau", neck = "Mnk. Nodowa +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.idle.Weak =
	{
		ammo = "Staunch Tathlum +1",
		head = "Malignance Chapeau", neck = "Mnk. Nodowa +2", ear1 = "Sherida Earring", ear2 = "Etiolation Earring",
		body = "Hes. Cyclas +3", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	-- Defense sets
	sets.defense.PDT =
	{
		ammo = "Staunch Tathlum +1",
		head = "Malignance Chapeau", neck = "Mnk. Nodowa +2",ear1 = "Sherida Earring", ear2 = "Etiolation Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.defense.MDT =
	{
		ammo = "Staunch Tathlum +1",
		head = "Malignance Chapeau", neck = "Mnk. Nodowa +2",ear1 = "Sherida Earring", ear2 = "Etiolation Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}
		
	sets.defense.MEVA =
	{
		ammo = "Staunch Tathlum +1",
		head = "Malignance Chapeau", neck = "Mnk. Nodowa +2",ear1 = "Sherida Earring", ear2 = "Etiolation Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.Kiting = { feet="Hermes' Sandals" }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee sets
	sets.engaged =
	{
		ammo = "Coiste Bodhar",
		head = "Ken. Jinpachi", neck = "Mnk. Nodowa +2", ear1 = "Sherida Earring", ear2 = "Schere Earring",
		body = "Mpaca's Doublet", hands = "Mpaca's Gloves", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt", legs = "Mpaca's Hose", feet = "Malignance Boots"
	}
	sets.engaged.Acc = set_combine(sets.engaged, { ear2 = "Telos Earring" })

	-- Hybrid sets
	sets.engaged.DT = set_combine(sets.engaged,
	{
		head = "Malignance Chapeau", ear2 = "Odnowa Earring +1",
		hands = "Malignance Gloves",
		legs = "Mpaca's Hose", feet = "Ken. Sune-Ate"
	})
	sets.engaged.Acc.DT = set_combine(sets.engaged.DT, { ear2 = "Telos Earring" })

	sets.engaged.Counter = set_combine(sets.engaged,
	{
		ammo = "Amar Cluster",
		ear2 = "Cryptic Earring",
		body = "Mpaca's Doublet", ring2 = "Defending Ring",
		legs = "Anch. Hose +3", feet = "Malignance Boots"
	})
	sets.engaged.Acc.Counter = set_combine(sets.engaged.Counter, {})

	-- Hundred Fists/Impetus melee set mods
	sets.engaged.HF = set_combine(sets.engaged, {})
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc, {})

	-- Extra Melee Modes
	sets.Staff =
	{
		ammo = "Aurgelmir Orb",
		head = "Malignance Chapeau", neck = "Anu Torque", ear1 = "Sherida Earring", ear2 = "Brutal Earring",
		body = "Ken. Samue", hands = gear.adhemar.hands.a, ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt", legs = "Tatena. Haidate +1", feet = "Mpaca's Boots"
	}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	sets.buff.Impetus = { ammo = "Coiste Bodhar", body="Bhikku Cyclas +1" }
	sets.buff.Footwork = {}
	sets.buff.Boost = { waist = "Ask Sash" }

	sets.FootworkWS = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {}

	-- Weapons sets
	sets.weapons.Godhands = { main = "Godhands" }
	sets.weapons.Barehanded = { main = empty }
	sets.weapons.Staff = { main = "Xoanon", sub = "Bloodrain Strap" }
	sets.weapons.ProcStaff = { main = "Chatoyant Staff", sub = "Bloodrain Strap" }
	sets.weapons.ProcClub = { main = "Mafic Cudgel" }
	sets.weapons.ProcSword = { main = "Ark Sword" }
	sets.weapons.ProcGreatSword = { main = "Lament", sub = "Bloodrain Strap" }
	sets.weapons.ProcScythe = { main = "Ark Scythe", sub = "Bloodrain Strap" }
	sets.weapons.ProcPolearm = { main = "Pitchfork +1", sub = "Bloodrain Strap" }
	sets.weapons.ProcGreatKatana = { main = "Hardwood Katana", sub = "Bloodrain Strap" }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 1)
	elseif player.sub_job == 'DRG' then
		set_macro_page(10, 1)
	elseif player.sub_job == 'DNC' then
		set_macro_page(2, 1)
	elseif player.sub_job == 'NIN' then
		set_macro_page(3, 1)
	else
		set_macro_page(1, 1)
	end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 001')
end