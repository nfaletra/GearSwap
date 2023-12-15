-- Setup vars that are user-dependent.
function user_job_setup()
	state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal', 'Hybrid', 'MEVA')
	state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'Proc')
	state.RangedMode:options('Normal', 'Acc')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal')
	state.Weapons:options('Dojikiri', 'Shining One', 'Sword', 'ProcWeapon')
	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind !backspace input /ja "Third Eye" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !@^` gs c cycle Stance')
	send_command('bind ^q gs c weapons Bow;gs c update')

	gear.Smertrios =
	{
		TP = { name = "Smertrios's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Store TP"+10', 'Phys. dmg. taken-10%' } },
		WSD = { name = "Smertrios's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%' } },
	}

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Meditate = { head = "Wakido Kabuto +2", hands = "Sakonji Kote +3", back = gear.Smertrios.TP }
	sets.precast.JA['Warding Circle'] = { head = "Wakido Kabuto +2" }
	sets.precast.JA['Blade Bash'] = { hands = "Sakonji Kote +3" }
	sets.precast.JA['Sekkanoki'] = { hands = "Kasuga Kote +3" }
	sets.precast.JA['Sengikori'] = { feet = "Kas. Sune-Ate +2" }

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		ammo = "Sapience Orb",
		neck = "Orunmila's Torque", ear1 = "Etiolation Earring", ear2 = "Loquac. Earring",
		body = "Sacro Breastplate", hands = "Leyline Gloves", ring1 = "Lebeche Ring", ring2 = "Medada's Ring",
		legs = "Arjuna Breeches"
	}

	-- Ranged snapshot gear
	sets.precast.RA = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		ammo = "Knobkierrie",
		head = "Mpaca's Cap", neck = "Sam. Nodowa +2", ear1 = "Moonshade Earring", ear2 = "Kasuga Earring +1",
		body = "Sakonji Domaru +3", hands = "Kasuga Kote +3", ring1 = "Epaminondas's Ring", ring2 = "Regal Ring",
		back = gear.Smertrios.WSD, waist = "Sailfi Belt +1", legs = "Wakido Haidate +3", feet = "Nyame Sollerets"
	}

	sets.precast.WS.Proc =
	{
		ammo = "Hasty Pinion +1",
		head = "Flam. Zucchetto +2", neck = "Moonbeam Nodowa", ear1 = "Telos Earring", ear2 = "Mache Earring +1",
		body = "Sacro Breastplate", hands = "Flam. Manopolas +2", ring1 = "Ramuh Ring +1", ring2 = "Ramuh Ring +1",
		back = gear.Smertrios.TP, waist = "Olseni Belt", legs = "Volte Hose", feet = "Flam. Gambieras +2"
	}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS,
	{
		head = "Nyame Helm", ear1 = "Lugra Earring +1"
	})

	sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Tachi: Ageha'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Mpaca's Cap", neck = "Sanctity Necklace", ear1 = "Digni. Earring", ear2 = "Crep. Earring",
		body = "Mpaca's Doublet", hands = "Mpaca's Gloves", ring1 = "Medada's Ring",ring2 = "Metamor. Ring +1",
		back = gear.Smertrios.WSD, waist = "Eschan Stone", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Tachi: Hobaku'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Mpaca's Cap", neck = "Sanctity Necklace", ear1 = "Digni. Earring", ear2 = "Crep. Earring",
		body = "Mpaca's Doublet", hands = "Mpaca's Gloves", ring1 = "Medada's Ring",ring2 = "Metamor. Ring +1",
		back = gear.Smertrios.WSD, waist = "Eschan Stone", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Tachi: Jinpu'] =
	{
		ammo = "Knobkierrie",
		head = "Nyame Helm", neck = "Sam. Nodowa +2", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Medada's Ring", ring2 = "Epaminondas's Ring",
		back = gear.Smertrios.WSD, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Tachi: Goten'] = set_combine(sets.precast.WS['Tachi: Jinpu'], {})
	sets.precast.WS['Tachi: Kagero'] = set_combine(sets.precast.WS['Tachi: Jinpu'], {})
	sets.precast.WS['Tachi: Koki'] = set_combine(sets.precast.WS['Tachi: Jinpu'], {})

	sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS,
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear2 = "Schere Earring",
		body = "Mpaca's Doublet", hands = "Mpaca's Gloves", ring1 = "Niqmaddu Ring",
		waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	})

	sets.precast.WS['Apex Arrow'] =
	{
		head = "Ynglinga Sallet", neck = "Fotia Gorget", ear1 = "Clearview Earring", ear2 = "Moonshade Earring",
		body = "Kyujutsugi", hands = "Buremte Gloves", ring1 = "Ilabrat Ring", ring2 = "Regal Ring",
		back = gear.Smertrios.WSD, waist = "Fotia Belt", legs = "Wakido Haidate +3", feet = "Waki. Sune-Ate +1"
	}

	sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Thrud Earring",ear2="Lugra Earring +1"}
	sets.AccMaxTP = {ear1="Telos Earring",ear2="Mache Earring +1"}
	sets.AccDayMaxTPWSEars = {ear1="Telos Earring",ear2="Mache Earring +1"}
	sets.DayMaxTPWSEars = {ear1="Thrud Earring",ear2="Brutal Earring"}
	sets.AccDayWSEars = {ear1="Telos Earring",ear2="Mache Earring +1"}
	sets.DayWSEars = {ear1="Thrud Earring",ear2="Moonshade Earring"}

	-- Midcast Sets
	sets.midcast.FastRecast =
	{
		head="Loess Barbuta +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Tartarus Platemail",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
		back="Moonlight Cape",waist="Tempus Fugit",legs="Wakido Haidate +3",feet="Amm Greaves"
	}

	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

	-- Ranged gear
	sets.midcast.RA =
	{
		head = "Flam. Zucchetto +2", neck = "Combatant's Torque", ear1 = "Clearview Earring", ear2 = "Neritic Earring",
		body = "Kyujutsugi", hands = "Buremte Gloves", ring1 = "Ilabrat Ring", ring2 = "Regal Ring",
		back = gear.Smertrios.TP, waist = "Carrier's Sash", legs = "Wakido Haidate +3", feet = "Waki. Sune-Ate +1"
	}

	sets.midcast.RA.Acc =
	{
		head = "Flam. Zucchetto +2", neck = "Combatant's Torque",ear1="Clearview Earring",ear2="Neritic Earring",
		body = "Kyujutsugi", hands = "Buremte Gloves", ring1 = "Ilabrat Ring", ring2 = "Regal Ring",
		back = gear.Smertrios.TP, waist = "Carrier's Sash", legs = "Wakido Haidate +3", feet = "Waki. Sune-Ate +1"
	}


	-- Sets to return to when not performing an action.

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.Kiting = { ring1 = "Shneddick Ring" }

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {}

	sets.idle =
	{
		ammo = "Staunch Tathlum +1",
		head = "Wakido Kabuto +2", neck = "Sam. Nodowa +2", ear1 = "Infused Earring", ear2 = "Odnowa Earring +1",
		body = "Sacro Breastplate", hands = "Nyame Gauntlets", ring1 = "Shadow Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Smertrios.TP, waist = "Flume Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Defense sets
	sets.defense.PDT = {}

	sets.defense.MDT = {}

	sets.defense.MEVA = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	-- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
	sets.engaged =
	{
		ammo = "Coiste Bodhar",
		head = "Kasuga Kabuto +2", neck = "Sam. Nodowa +2", ear1 = "Schere Earring", ear2 = "Kasuga Earring +1",
		body = "Kasuga Domaru +2", hands = "Tatena. Gote +1", ring1 = "Niqmaddu Ring", ring2 = "Chirich Ring +1",
		back = gear.Smertrios.TP, waist = "Sweordfaetels +1", legs = "Kasuga Haidate +2", feet = "Ryuo Sune-Ate +1"
	}
	
	sets.engaged.Hybrid =
	{
		ammo = "Coiste Bodhar",
		head = "Kasuga Kabuto +2", neck = "Sam. Nodowa +2", ear1 = "Schere Earring", ear2 = "Kasuga Earring +1",
		body = "Kasuga Domaru +2", hands = "Tatena. Gote +1", ring1 = "Niqmaddu Ring", ring2 = "Chirich Ring +1",
		back = gear.Smertrios.TP, waist = "Sweordfaetels +1", legs = "Kasuga Haidate +2" , feet = "Ryuo Sune-Ate +1"
	}

	sets.engaged.MEVA =
	{
		ammo = "Staunch Tathlum +1",
		helm = "Kasuga Kabuto +2", neck = "Sam. Nodowa +2", ear1 = "Schere Earring", ear2 = "Kasuga Earring +1",
		body = "Kasuga Domaru +2", hands = "Nyame Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Chirich Ring +1",
		back = gear.Smertrios.TP, waist = "Sweordfaetels +1", legs = "Kasuga Haidate +2", feet = "Nyame Sollerets",
	}

	-- Weapons sets
	sets.weapons.Dojikiri = { main = "Dojikiri Yasutsuna", sub = "Utu Grip" }
	sets.weapons['Shining One'] = { main = "Shining One", sub = "Utu Grip" }
	sets.weapons.Sword = { main = "Twinned Blade", sub = empty }
	sets.weapons.ProcWeapon = { main = "Soboro Sukehiro", sub = "Utu Grip" }
	
	-- Buff sets
	sets.Cure_Received = {hands="Buremte Gloves",waist="Gishdubar Sash",legs="Flamma Dirs +2"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = { neck = "Vim Torque +1" }
	sets.buff.Hasso = {}
	sets.buff['Third Eye'] = {} --legs="Sakonji Haidate +3"
	sets.buff.Sekkanoki = { hands = "Kasuga Kote +3" }
	sets.buff.Sengikori = { feet = "Kas. Sune-Ate +2" }
	sets.buff['Meikyo Shisui'] = {feet="Sak. Sune-Ate +3"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(1, 4)
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[980] < spell_latency and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
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

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 008')
end