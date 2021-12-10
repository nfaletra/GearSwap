function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT', 'Counter')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'DT')
	state.Weapons:options('Godhands', 'Staff', 'Club', 'ProcStaff', 'ProcClub', 'ProcSword', 'ProcGreatSword', 'ProcScythe', 'ProcPolearm', 'ProcGreatKatana', 'Barehanded')

	state.ExtraMeleeMode = M{['description'] = 'Extra Melee Mode', 'None'}

	update_melee_groups()
	
	-- Additional local binds
	send_command('bind ^` input /ja "Boost" <me>')
	send_command('bind !` input /ja "Perfect Counter" <me>')
	send_command('bind ^backspace input /ja "Mantra" <me>')
	send_command('bind @` gs c cycle SkillchainMode')

	-- Job Gear
	gear.segomo_tp = {name="Segomo's Mantle",augments={}}
	gear.segomo_wsd = {name="Segomo's Mantle",augments={}}
	
	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = { legs="Hes. Hose +3" }
	sets.precast.JA['Boost'] = { hands="Anchor. Gloves +3" }
	sets.precast.JA['Boost'].OutOfCombat = { hands="Anchor. Gloves +3" }
	sets.precast.JA['Dodge'] = { feet="Anch. Gaiters +3" }
	sets.precast.JA['Focus'] = { head="" }
	sets.precast.JA['Counterstance'] = { feet="Hes. Gaiters +3" }
	sets.precast.JA['Footwork'] = { feet="Shukuyu Sune-Ate" }
	sets.precast.JA['Formless Strikes'] = { body="Hes. Cyclas +3" }
	sets.precast.JA['Mantra'] = { feet="Hes. Gaiters +3" }

	sets.precast.JA['Chi Blast'] = {}
	
	sets.precast.JA['Chakra'] = {
		head="Genmei Kabuto",
		body="Anch. Cyclas +3",hands="Hes. Gloves +3",
		legs="Hes. Hose +3",feet="Anch. Gaiters +3"
	}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {
		ammo="Falcon Eye",
		head="Malignance Chapeau",neck="Moonbeam Nodowa",ear1="Mache Earring +1",ear2="Telos Earring",
		body="Malignance Tabard",hands="Hesychast's Gloves +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back="Segomo's Mantle",waist="Olseni Belt",legs="Hiza. Hizayoroi +2",feet="Malignance Boots"
	}
		
	sets.precast.Flourish1 = {
		ammo="Falcon Eye",
		head="Malignance Chapeau",neck="Moonbeam Nodowa",ear1="Mache Earring +1",ear2="Telos Earring",
		body="Malignance Tabard",hands="Hesychast's Gloves +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back="Segomo's Mantle",waist="Olseni Belt",legs="Mummu Kecks +2",feet="Malignance Boots"
	}


	-- Fast cast sets for spells
	sets.precast.FC = {
		ammo="Impatiens",
		head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Loquac. Earring",
		hands="Leyline Gloves",ring2="Kishar Ring",
		legs="Limbo Trousers"
	}
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		body="Passion Jacket",neck="Magoraga Beads"
	})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Knobkierre",
		head="Hes. Crown +3",neck="Mnk. Nodowa +2",ear1="Sherida Earring",ear2="Moonshade Earring",
		body="Ken. Samue",hands="Anchor. Gloves +3",ring1="Niqmaddu Ring",ring2="Epona's Ring",
		back=gear.segomo_wsd,waist="Moonbow Belt",legs="Hiza. Hizayoroi +2",feet=gear.herculean_ta_feet
	}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.
	sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
		legs="Malignance Tights",feet="Hes. Gaiters +3"
	})
	sets.precast.WS["Ascetic's Fury"] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",ear2="Odr Earring",
		body="Anch. Cyclas +3",
		feet=gear.herculean_crit_feet
	})
	sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
		head="Adhemar Bonnet +1",ear2="Odr Earring",
		body="Anch. Cyclas +3",hands="Ryuo Tekko +1",
		feet=gear.herculean_crit_feet
	})
	sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
		ear2="Odr Earring",
		legs="Malignance Tights"
	})
	sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {
		feet="Anch. Gaiters +3"
	})
	sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {
		feet="Anch. Gaiters +3"
	})
	sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
	sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
	sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
	sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc)
	sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc)
	sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
	sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
	sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

	sets.precast.WS['Cataclysm'] = {
		ammo="Ghastly Tathlum +1",
		neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
		hands="Malignance Gloves",ring1="Shiva Ring +1",
		back="Toro Cape",legs="Nahtirah Trousers"}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Sherida Earring",ear2="Brutal Earring",}
	sets.AccMaxTP = {ear1="Sherida Earring",ear2="Brutal Earring"}
	
	-- Midcast Sets
	sets.midcast.FastRecast = {ammo="Staunch Tathlum +1",
		head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Loquac. Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
		back="Moonlight Cape",waist="Moonbow Belt",legs="Limbo Trousers",feet="Hippo. Socks +1"}
		
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
		
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = { body="Hes. Cyclas +3" }

	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Sheltered Ring",
		back="Moonlight Cape",waist="Black Belt",legs="Nyame Flanchard",feet="Hippo. Socks +1"
	}

	sets.idle.Weak = {
		ammo="Staunch Tathlum +1",
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Sheltered Ring",
		back="Moonlight Cape",waist="Black Belt",legs="Nyame Flanchard",feet="Hippo. Socks +1"
	}

	sets.idle.PDT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Dark Ring",
		back="Moonlight Cape",waist="Black Belt",legs="Nyame Flanchard",feet="Hippo. Socks +1"
	}

	-- Defense sets
	sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Dark Ring",
		back="Moonlight Cape",waist="Black Belt",legs="Nyame Flanchard",feet="Malignance Boots"
	}

	sets.defense.MDT = {
		ammo="Staunch Tathlum +1",
		head="Dampening Tam",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonlight Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Hippo. Socks +1"
	}
		
	sets.defense.MEVA = {
		ammo="Staunch Tathlum +1",
		head=empty,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Respite Cloak",hands="Leyline Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
		back="Toro Cape",waist="Carrier's Sash",legs="Samnuha Tights",feet="Malignance Boots"
	}

	sets.Kiting = { feet="Hermes' Sandals" }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee sets
	sets.engaged = {
		ammo="Aurgelmir Orb",
		head="Adhemar Bonnet +1",neck="Mnk. Nodowa +2",ear1="Sherida Earring",ear2="Telos Earring",
		body="Ken. Samue",hands="Adhemar Wrist. +1",ring1="Niqmaddu Ring",ring2="Epona's Ring",
		back=gear.segomo_tp,waist="Moonbow Belt",legs="Hes. Hose +3",feet="Anch. Gaiters +3"}
	sets.engaged.Acc = set_combine(sets.engaged, {
		ammo="Falcon Eye",
		head="Malignance Chapeau",
		legs="Malignance Tights"
	})

	-- Defensive melee hybrid sets
	sets.engaged.PDT = set_combine(sets.engaged, {
		ammo="Staunch Tathlum",
		head="Malignance Chapeau",
		ring2="Defending Ring",
		legs="Malignance Tights",
	})
	sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {})

	-- Hundred Fists/Impetus melee set mods
	sets.engaged.HF = set_combine(sets.engaged, {})
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc, {})

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	sets.buff.Impetus = { body="Bhikku Cyclas +1" }
	sets.buff.Footwork = {}
	sets.buff.Boost = {}

	sets.FootworkWS = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {}

	-- Weapons sets
	sets.weapons.Godhands = { main="Godhands" }
	sets.weapons.Barehanded = {main=empty}
	sets.weapons.Staff = { main="Malignance Pole",sub="Pole Grip" }
	sets.weapons.ProcStaff = { main="Chatoyant Staff" }
	sets.weapons.ProcClub = { main="Mafic Cudgel" }
	sets.weapons.ProcSword = { main="Ark Sword",sub=empty }
	sets.weapons.ProcGreatSword = { main="Lament",sub=empty }
	sets.weapons.ProcScythe = { main="Ark Scythe",sub=empty }
	sets.weapons.ProcPolearm = { main="Pitchfork +1",sub=empty }
	sets.weapons.ProcGreatKatana = { main="Hardwood Katana",sub=empty }
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