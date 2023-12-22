function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal')
	state.WeaponskillMode:options('Match', 'Normal', 'PDL', 'Proc')
	state.HybridMode:options('Normal', 'Hybrid', 'Counter', 'Subtle Blow')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'DT', 'Evasion', 'Refresh')
	state.Weapons:options('Godhands', 'Verethragna', 'Spharai', 'Karambit', 'Varga', 'Staff', 'Club', 'ProcStaff', 'Barehanded')

	state.ExtraMeleeMode = M{['description'] = 'Extra Melee Mode', 'None', 'Warder', 'Staff'}

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
		VIT_WSD = { name = "Segomo's Mantle", augments = { 'VIT+20', 'Accuracy+20 Attack+20', 'VIT+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%' } },
		Counter = { name = "Segomo's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dbl.Atk."+10', 'System: 1 ID: 640 Val: 4' } },
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
	sets.precast.JA['Focus'] = { head = "Anch. Crown +3" }
	sets.precast.JA['Counterstance'] = { feet = "Hes. Gaiters +3" }
	sets.precast.JA['Footwork'] = { feet = "Shukuyu Sune-Ate" }
	sets.precast.JA['Formless Strikes'] = { body = "Hes. Cyclas +3" }
	sets.precast.JA['Mantra'] = { feet = "Hes. Gaiters +3" }

	sets.precast.JA['Chi Blast'] = {}

	sets.precast.JA['Chakra'] =
	{
		head = "Genmei Kabuto", neck = "Unmoving Collar +1", ear1 = "Tuisto Earring", ear2 = "Handler's Earring +1",
		body = "Anch. Cyclas +2", hands = "Hes. Gloves +3", ring1 = "Niqmaddu Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Segomo.VIT_WSD, legs = "Tatena. Haidate +1", feet = "Bhikku Gaiters +3"
	}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = 
	{
		head = "Malignance Chapeau", ear1 = "Mache Earring +1", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves",
		back = gear.Segomo.TP, legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.Flourish1 =
	{
		head = "Malignance Chapeau", ear1 = "Mache Earring +1", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves",
		back = gear.Segomo.TP, legs = "Malignance Tights", feet = "Malignance Boots"
	}

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		ammo = "Sapience Orb",
		head = gear.herculean_fc_head, neck = "Orunmila's Torque", ear1 = "Enchantr. Earring +1", ear2 = "Loquac. Earring",
		body = gear.adhemar.body.d, hands = "Leyline Gloves", ring1 = "Rahab Ring", ring2 = "Medada's Ring",
		legs = "Limbo Trousers"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC,
	{
		neck = "Magoraga Beads"
	})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		ammo = "Knobkierrie",
		head = "Hes. Crown +3", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Anchor. Gloves +3", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.VIT_WSD, waist = "Moonbow Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	precast.WS.PDL = set_combine(sets.precast.WS,
	{
		ammo = "Crepuscular Pebble",
		neck = "Mnk. Nodowa +2",
		ring2 = "Sroda Ring"
	})

	-- Specific weaponskill sets.
	sets.precast.WS['Victory Smite'] =
	{
		ammo = "Coise Bodhar",
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Odr Earring",
		body = "Ken. Samue +1", hands = "Ryuo Tekko +1", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.STR_DA, waist = "Moonbow Belt +1", legs = "Mpaca's Hose", feet = gear.herculean_crit_feet
	}
	sets.precast.WS['Victory Smite'].PDL = set_combine(sets.precast['Victory Smite'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Mnk. Nodowa +2",
		ring2 = "Sroda Ring"
	})

	sets.precast.WS['Ascetic\'s Fury'] = sets.precast.WS['Victory Smite']
	sets.precast.WS['Ascetic\'s Fury'].PDL = sets.precast.WS['Victory Smite'].PDL

	sets.precast.WS['Raging Fists'] =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = gear.adhemar.body.b, hands = gear.adhemar.hands.b, ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.STR_DA, waist = "Moonbow Belt +1", legs = "Mpaca's Hose", feet = gear.herculean_ta_feet
	}
	sets.precast.WS['Raging Fists'].PDL = set_combine(sets.precast.WS['Raging Fists'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Mnk. Nodowa +2",
		ring2 = "Sroda Ring"
	})

	sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS['Raging Fists'],
	{
		head = "Adhemar Bonnet +1", ear2 = "Schere Earring",
	})
	sets.precast.WS['Spinning Attack'].PDL = set_combine(sets.precast.WS['Spinning Attack'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Mnk. Nodowa +2",
		ring2 = "Sroda Ring"
	})

	sets.precast.WS['Shijin Spiral'] =
	{
		ammo = "Aurgelmir Orb",
		head = "Ken. Jinpachi +1", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Mache Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt +1", legs = "Mpaca's Hose", feet = gear.herculean_ta_feet
	}
	sets.precast.WS['Shijin Spiral'].PDL = set_combine(sets.precast.WS['Shijin Spiral'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Mnk. Nodowa +2",
		ring2 = "Sroda Ring"
	})

	sets.precast.WS['Howling Fist'] =
	{
		ammo = "Knobkierrie",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Moonshade Earring", ear2 = "Schere Earring",
		body = "Tatena. Harama. +1", hands = gear.herculean_ta_hands, ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.STR_DA, waist = "Moonbow Belt +1", legs = "Mpaca's Hose", feet = gear.herculean_ta_feet
	}
	sets.precast.WS['Howling Fist'].PDL = set_combine(sets.precast.WS['Howling Fist'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Mnk. Nodowa +2",
		ring2 = "Sroda Ring"
	})

	sets.precast.WS['Tornado Kick'] =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Mnk. Nodowa +2", ear1 = "Moonshade Earring", ear2 = "Schere Earring",
		body = "Tatena. Harama. +1", hands = gear.herculean_ta_hands, ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.STR_DA, waist = "Moonbow Belt +1", legs = "Mpaca's Hose", feet = "Anch. Gaiters +3"
	}
	sets.precast.WS['Tornado Kick'].PDL = set_combine(sets.precasts.WS['Tornado Kick'],
	{
		ammo = "Crepuscular Pebble",
		ring2 = "Sroda Ring"
	})

	sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS['Tornado Kick'], {})
	sets.precast.WS['Dragon Kick'].PDL = set_combine(sets.precast.WS['Tornado Kick'].PDL, {})

	sets.precast.WS['Final Heaven'] =
	{
		ammo = "Knobkierrie",
		head = "Hes. Crown +3", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Ishvara Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Regal Ring",
		back = gear.Segomo.VIT_WSD, waist = "Moonbow Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Final Heaven'].PDL = set_combine(sets.precast.WS['Final Heaven'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Mnk. Nodowa +2",
		ring2 = "Sroda Ring"
	})

	sets.precast.WS['Asuran Fists'] =
	{
		ammo = "Knobkierrie",
		head = "Hes. Crown +3", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Ishvara Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Regal Ring",
		back = gear.Segomo.VIT_WSD, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Asuran Fists'].PDL = set_combine(sets.precast.WS['Asuran Fists'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Mnk. Nodowa +2",
		ring2 = "Sroda Ring"
	})

	sets.precast.WS['Shoulder Tackle'] =
	{
		ammo = "Voluspa Tathlum",
		head = "Malignance Chapeau", neck = "Moonlight Necklace", ear1 = "Crep. Earring", ear2 = "Hermetic Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Metamor. Ring +1", ring2 = "Stikini Ring +1",
		back = gear.Segomo.INT_WSD, waist = "Acuity Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Retribution'] =
	{
		ammo = "Knobkierrie",
		head = "Mpaca's Cap", neck = "Mnk. Nodowa +2", ear1 = "Sherida Earring", ear2 = "Ishvara Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Regal Ring",
		back = gear.Segomo.VIT_WSD, waist = "Moonbow Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Retribution'].PDL = set_combine(sets.precast.WS['Retribution'],
	{
		ammo = "Crepuscular Pebble",
		ring2 = "Sroda Ring"
	})

	sets.precast.WS['Cataclysm'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Pixie Hairpin +1", neck = "Sibyl Scarf", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Archon Ring",
		back = gear.Segomo.INT_WSD, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Shell Crusher'] =
	{
		ammo = "Voluspa Tathlum",
		head = "Malignance Chapeau", neck = "Moonlight Necklace", ear1 = "Crep. Earring", ear2 = "Hermetic Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Metamor. Ring +1", ring2 = "Stikini Ring +1",
		back = gear.Segomo.INT_WSD, waist = "Acuity Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = { ear2 = "Brutal Earring" }
	sets.AccMaxTP = { ear2 = "Brutal Earring" }
	
	-- Midcast Sets
	sets.midcast.FastRecast =
	{
		ammo = "Staunch Tathlum +1",
		head = gear.herculean_fc_head, ear1 = "Loquac. Earring",
		body = gear.adhemar.body.d, hands = "Leyline Gloves",
		legs = "Limbo Trousers"
	}

	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = { body = "Hes. Cyclas +3" }

	-- Idle sets
	sets.idle =
	{
		ammo = "Staunch Tathlum +1",
		head = "Malignance Chapeau", neck = "Bathy Choker +1", ear1 = "Infused Earring", ear2 = "Odnowa Earring +1",
		body = "Hiza. Haramaki +2", hands = "Malignance Gloves", ring1 = "Chirich Ring +1", ring2 = "Defending Ring",
		back = "Moonlight Cape", waist = "Moonbow Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.idle.DT = sets.idle

	sets.idle.Evasion =
	{
		ammo = "Staunch Tathlum +1",
		head = "Malignance Chapeau", neck = "Mnk. Nodowa +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.idle.Refresh = set_combine(sets.idle,
	{
		ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1"
	})

	-- Defense sets
	sets.defense.PDT =
	{
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Warder's Charm +1",ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = "Moonlight Cape", waist = "Engraved Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.defense.MDT =
	{
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Warder's Charm +1",ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = "Moonlight Cape", waist = "Engraved Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
		
	sets.defense.MEVA =
	{
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Warder's Charm +1",ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = "Moonlight Cape", waist = "Engraved Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.Kiting = { ring1 = "Shneddick Ring" }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	sets.Godhands = { ear2 = "Mache Earring +1" }

	-- Normal melee sets
	sets.engaged =
	{
		ammo = "Coiste Bodhar",
		head = "Adhemar Bonnet +1", neck = "Mnk. Nodowa +2", ear1 = "Sherida Earring", ear2 = "Schere Earring",
		body = "Mpaca's Doublet", hands = gear.adhemar.hands.a, ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt +1", legs = "Bhikku Hose +3", feet = "Anch. Gaiters +3"
	}
	sets.engaged.Godhands = set_combine(sets.engaged, sets.Godhands)
	sets.engaged.Impetus = set_combine(sets.engaged,
	{
		body = "Bhikku Cyclas +3"
	})
	sets.engaged.Impetus.Godhands = set_combine(sets.engaged.Impetus, sets.Godhands)

	-- Hybrid sets
	sets.engaged.Hybrid = set_combine(sets.engaged,
	{
		head = "Bhikku Crown +2",
		hands = "Mpaca's Gloves",
		feet = "Mpaca's Boots"
	})
	sets.engaged.Hybrid.Godhands = set_combinet(sets.engaged.Hybrid, sets.Godhands)
	sets.engaged.Hybrid.Impetus = set_combine(sets.engaged.Hybrid,
	{
		legs = "Bhikku Hose +3",
	})
	sets.engaged.Hybrid.Impetus.Godhands = set_combine(sets.engaged.Hybrid.Impetus, sets.Godhands)

	sets.engaged.Counter =
	{
		ammo = "Coiste Bodhar",
		head = "Bhikku Crown +2", neck = "Bathy Choker +1", ear1 = "Sherida Earring", ear2 = "Bhikku Earring +1",
		body = "Mpaca's Doublet", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = gear.Segomo.Counter, waist = "Moonbow Belt +1", legs = "Bhikku Hose +3", feet = "Bhikku Gaiters +3"
	}

	sets.engaged['Subtle Blow'] =
	{
		ammo = "Coiste Bodhar",
		head = "Malignance Chapeau", neck = "Mnk. Nodowa +2", ear1 = "Sherida Earring", ear2 = "Odnowa Earring +1",
		body = "Mpaca's Doublet", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt +1", legs = "Mpaca's Hose", feet = "Malignance Boots"
	}
	sets.engaged['Subtle Blow'].Impetus = set_combine(sets.engaged['Subtle Blow'],
	{
		body = "Bhikku Cyclas +3",
	})

	-- Extra Melee Modes
	sets.Warder = { neck = "Warder's Charm +1" }
	sets.Staff =
	{
		neck = "Anu Torque",
		legs = "Mpaca's Hose",
	}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	sets.buff.ImpetusWS = { ear2 = "Schere Earring", body = "Bhikku Cyclas +3" }
	sets.buff.Footwork = { feet = "Anch. Gaiters +3" }
	sets.buff.Boost = { waist = "Ask Sash" }

	sets.buff.Counterstance =
	{
		ammo = "Staunch Tathlum +1",
		head = "Bhikku Crown +2", neck = "Twilight Torque", ear1 = "Sherida Earring", ear2 = "Telos Earring",
		body = "Mpaca's Doublet", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Segomo.TP, waist = "Moonbow Belt +1", legs = "Anch. Hose +3", feet = "Hes. Gaiters +3"
	}

	sets.FootworkWS = { feet = "Anch. Gaiters +3" }
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {}

	-- Weapons sets
	sets.weapons.Godhands = { main = "Godhands" }
	sets.weapons.Verethragna = { main = "Verethragna" }
	sets.weapons.Spharai = { main = "Spharai" }
	sets.weapons.Karambit = { main = "Karambit" }
	sets.weapons.Varga = { main = "Varga Purnikawa" }
	sets.weapons.Club = { main = "Mafic Cudgel" }
	sets.weapons.Staff = { main = "Xoanon", sub = "Bloodrain Strap" }
	sets.weapons.ProcStaff = { main = "Ram Staff", sub = "Bloodrain Strap" }
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