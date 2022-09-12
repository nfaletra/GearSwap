function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Match', 'Normal', 'Proc')
	state.HybridMode:options('Normal', 'DT', 'Counter', 'Subtle Blow')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'DT', 'Evasion')
	state.Weapons:options('Godhands', 'Verethragna', 'Staff', 'Club', 'ProcStaff', 'Barehanded')

	state.ExtraMeleeMode = M{['description'] = 'Extra Melee Mode', 'None', 'Schere', 'Warder', 'Staff'}

	update_melee_groups()
	
	-- Additional local binds
	send_command('bind ^` input /ja "Boost" <me>')
	send_command('bind !` input /ja "Perfect Counter" <me>')
	send_command('bind ^backspace input /ja "Mantra" <me>')
	send_command('bind @` gs c cycle SkillchainMode')

	-- Job Gear
	gear.Segomo =
	{
		TP = { name = "Segomo's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dbl.Atk."+10', 'Damage taken-5%' } },
		STR_DA = { name = "Segomo's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%' } },
		INT_WSD = { name = "Segomo's Mantle", augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%' } },
		VIT_WSD = { name = "Segomo's Mantle", augments = { 'VIT+20', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%' } }
	}

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
		ammo = "Knobkierrie",
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.VIT_WSD, waist = "Moonbow Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	-- Specific weaponskill sets.
	sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS,
	{
		ammo = "Coiste Bodhar",
		head = "Adhemar Bonnet +1", neck = "Mnk. Nodowa +2", ear2 = "Schere Earring",
		body = "Mpaca's Doublet", hands = "Ryuo Tekko +1",
		back = gear.Segomo.STR_DA, legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	})

	sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS,
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Mnk. Nodowa +2",
		body = "Ken. Samue +1",
		back = gear.Segomo.VIT_WSD, legs = "Mpaca's Hose"
	})

	sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS,
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Mnk. Nodowa +2",
		body = "Mpaca's Doublet", hands = "Mpaca's Gloves",
		back = gear.Segomo.STR_DA, legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	})

	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS,
	{
		ammo = "Coiste Bodhar",
		head = "Hes. Crown +3", neck = "Fotia Gorget", ear2 = "Schere Earring",
		body = "Hes. Cyclas +3", hands = "Hes. Gloves +3", ring2 = "Regal Ring",
		back = gear.Segomo.VIT_WSD, waist = "Fotia Belt", legs = "Hes. Hose +3", feet = "Hes. Gaiters +3"
	})

	sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS,
	{
		ammo = "Voluspa Tathlum",
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget", ear2 = "Mache Earring +1",
		body = "Mpaca's Doublet", hands = "Mpaca's Gloves",
		back = gear.Segomo.TP, legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	})

	sets.precast.WS['Ascetic\'s Fury'] = set_combine(sets.precast.WS,
	{
		ammo = "Coiste Bodhar",
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget",
		body = "Mpaca's Doublet", hands = "Ryuo Tekko +1",
		back = gear.Segomo.STR_DA, waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	})

	sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS,
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Mnk. Nodowa +2",
		body = "Mpaca's Doublet", hands = "Mpaca's Gloves",
		back = gear.Segomo.VIT_WSD, legs = "Mpaca's Hose", feet = "Anch. Gaiters +3"
	})

	sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS['Tornado Kick'], {})

	sets.precast.WS['Shoulder Tackle'] = set_combine(sets.precast.WS,
	{
		ammo = "Voluspa Tathlum",
		head = "Malignance Chapeau", neck = "Sanctity Necklace", ear1 = "Crep. Earring", ear2 = "Digni. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Metamor. Ring +1", ring2 = "Etana Ring",
		back = gear.Segomo.TP, waist = "Acuity Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	})

	sets.precast.WS['Retribution'] = set_combine(sets.precast.WS,
	{
		head = "Mpaca's Cap", neck = "Mnk. Nodowa +2",
		body = "Nyame Mail", ring2 = "Regal Ring",
		back = gear.Segomo.STR_DA, waist = "Sailfi Belt +1"
	})

	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS,
	{
		ammo = "Pemphredo Tathlum",
		head = "Pixie Hairpin +1", neck = "Sanctity Necklace", ear1 = "Friomisi Earring",
		ring1 = "Metamor. Ring +1", ring2 = "Archon Ring",
		back = gear.Segomo.INT_WSD, waist = "Acuity Belt +1", legs = "Mpaca's Hose"
	})

	sets.precast.WS['Shell Crusher'] = set_combine(sets.precast.WS,
	{
		ammo = "Voluspa Tathlum",
		head = "Mpaca's Cap", neck = "Sanctity Necklace", ear1 = "Crep. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Metamor. Ring +1", ring2 = "Etana Ring",
		back = gear.Segomo.STR_DA, waist = "Acuity Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	})
	
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
		body = "Hiza. Haramaki +2", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt +1", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}

	sets.idle.DT =
	{
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Mnk. Nodowa +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Mpaca's Doublet", hands = "Nyame Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt +1", legs = "Mpaca's Hose", feet = "Nyame Sollerets"
	}

	sets.idle.Evasion =
	{
		ammo = "Staunch Tathlum +1",
		head = "Malignance Chapeau", neck = "Mnk. Nodowa +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	-- Defense sets
	sets.defense.PDT =
	{
		ammo = "Staunch Tathlum +1",
		head = "Malignance Chapeau", neck = "Mnk. Nodowa +2",ear1 = "Sherida Earring", ear2 = "Etiolation Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.defense.MDT =
	{
		ammo = "Staunch Tathlum +1",
		head = "Malignance Chapeau", neck = "Mnk. Nodowa +2",ear1 = "Sherida Earring", ear2 = "Etiolation Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}
		
	sets.defense.MEVA =
	{
		ammo = "Staunch Tathlum +1",
		head = "Malignance Chapeau", neck = "Mnk. Nodowa +2",ear1 = "Sherida Earring", ear2 = "Etiolation Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
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
		head = "Adhemar Bonnet +1", neck = "Mnk. Nodowa +2", ear1 = "Sherida Earring", ear2 = "Telos Earring",
		body = "Ken. Samue +1", hands = gear.adhemar.hands.a, ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt +1", legs = "Bhikku Hose +2", feet = "Anch. Gaiters +3"
	}
	sets.engaged.Acc = set_combine(sets.engaged, {})

	-- Hybrid sets
	sets.engaged.DT = set_combine(sets.engaged,
	{
		head = "Malignance CHapeau", ear2 = "Odnowa Earring +1",
		body = "Mpaca's Doublet", hands = "Malignance Gloves",
		feet = "Malignance Boots"
	})
	sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {})

	sets.engaged.Counter = set_combine(sets.engaged,
	{
		ammo = "Amar Cluster",
		head = "Malignance Chapeau", neck = "Bathy Choker +1", ear2 = "Cryptic Earring",
		body = "Mpaca's Doublet", hands = "Malignance Gloves", ring2 = "Defending Ring",
		legs = "Anch. Hose +3", feet = "Hes. Gaiters +3"
	})
	sets.engaged.Acc.Counter = set_combine(sets.engaged.Counter, {})

	sets.engaged['Subtle Blow'] =
	{
		ammo = "Coiste Bodhar",
		head = "Malignance Chapeau", neck = "Mnk. Nodowa +2", ear1 = "Sherida Earring", ear2 = "Odnowa Earring +1",
		body = "Mpaca's Doublet", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt +1", legs = "Mpaca's Hose", feet = "Malignance Boots"
	}
	sets.engaged['Subtle Blow'].Acc = set_combine(sets.engaged['Subtle Blow'], {})

	-- Hundred Fists/Impetus melee set mods
	sets.engaged.HF = set_combine(sets.engaged, {})
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc, {})

	-- Extra Melee Modes
	sets.Schere = { ear2 = "Schere Earring" }
	sets.Warder = { neck = "Warder's Charm +1" }
	sets.Staff =
	{
		ammo = "Aurgelmir Orb",
		head = "Malignance Chapeau", neck = "Anu Torque", ear1 = "Sherida Earring", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = gear.adhemar.hands.a, ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt +1", legs = "Tatena. Haidate +1", feet = "Mpaca's Boots"
	}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	sets.buff.Impetus = { body = "Bhikku Cyclas +2" }
	sets.buff.Footwork = { feet = "Anch. Gaiters +3" }
	sets.buff.Boost = { waist = "Ask Sash" }

	sets.FootworkWS = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {}

	-- Weapons sets
	sets.weapons.Godhands = { main = "Godhands" }
	sets.weapons.Verethragna = { main = "Verethragna" }
	sets.weapons.Club = { main = "Mafic Cudgel" }
	sets.weapons.Staff = { main = "Xoanon", sub = "Bloodrain Strap" }
	sets.weapons.ProcStaff = { main = "Chatoyant Staff", sub = "Bloodrain Strap" }
	sets.weapons.Barehanded = { main = empty }
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