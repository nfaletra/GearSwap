-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_job_setup()
	--include('AutoHeals.lua')

	state.OffenseMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal','Resistant', 'SIRD', 'DT')
	state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'DualWeapons', 'MeleeWeapons')
	state.WeaponskillMode:options('Normal')

	gear.obi_cure_waist = "Austerity Belt +1"
	gear.obi_cure_back = "Alaunus's Cape"

	gear.obi_nuke_waist = "Sekhmet Corset"
	gear.obi_high_nuke_waist = "Yamabuki-no-Obi"
	gear.obi_nuke_back = "Toro Cape"

	-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

	-- Smartcure binds
	-- Party - Ctrl + FKey
	send_command('bind ^f1 gs c smartcure p0')
	send_command('bind ^f2 gs c smartcure p1')
	send_command('bind ^f3 gs c smartcure p2')
	send_command('bind ^f4 gs c smartcure p3')
	send_command('bind ^f5 gs c smartcure p4')
	send_command('bind ^f6 gs c smartcure p5')

	-- Top alliance - Alt + FKey
	send_command('bind !f1 gs c smartcure a10')
	send_command('bind !f2 gs c smartcure a11')
	send_command('bind !f3 gs c smartcure a12')
	send_command('bind !f4 gs c smartcure a13')
	send_command('bind !f5 gs c smartcure a14')
	send_command('bind !f6 gs c smartcure a15')

	-- Bottom alliance - WindowsKey + FKey
	send_command('bind @f1 gs c smartcure a20')
	send_command('bind @f2 gs c smartcure a21')
	send_command('bind @f3 gs c smartcure a22')
	send_command('bind @f4 gs c smartcure a23')
	send_command('bind @f5 gs c smartcure a24')
	send_command('bind @f6 gs c smartcure a25')

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.MeleeWeapons = { main = "Maxentius", sub = "Ammurapi Shield" }
	sets.weapons.DualWeapons = { main = "Maxentius", sub = "C. Palug Hammer" }
	
	sets.buff.Sublimation = { waist = "Embla Sash" }
	sets.buff.DTSublimation = { waist = "Embla Sash" }
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		main = "C. Palug Hammer", sub = "Chanter's Shield", ammo = "Impatiens",
		head = "Vanya Hood", neck = "Cleric's Torque", ear1 = "Loquac. Earring", ear2 = "Malignance Earring",
		body = "Inyanga Jubbah +2", hands = "Gende. Gages +1", ring1 = "Kishar Ring", ring2 = "Lebeche Ring",
		back = "Perimede Cape", waist = "Witful Belt", legs = "Aya. Cosciales +2", feet = "Regal Pumps +1"
	}
		
	sets.precast.FC.DT =
	{
		main = "C. Palug Hammer", sub = "Chanter's Shield", ammo = "Impatiens",
		head = "Bunzi's Hat", neck = "Cleric's Torque", ear1 = "Loquac. Earring", ear2 = "Malignance Earring",
		body = "Inyanga Jubbah +2", hands = "Gende. Gages +1", ring1 = "Kishar Ring", ring2 = "Lebeche Ring",
		back = "Perimede Cape", waist = "Witful Belt", legs = "Aya. Cosciales +2", feet = "Regal Pumps +1"
	}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, { legs="Ebers Pant. +1" })

	sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'],
	{
		main = "Queller Rod", sub = "Sors Shield",
		ear1="Mendi. Earring",
	})

	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, { head = empty, body = "Twilight Cloak" })

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak" })

	-- Precast sets to enhance JAs
	sets.precast.JA.Benediction = { body = "Piety Bliaut +3" }

	-- Waltz set (chr and vit)
	sets.precast.Waltz = { body = "Piety Bliaut +3" }

	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		ammo = "Pemphredo Tathlum",
		head = "Nyame Helm", neck = "Cleric's Torque", ear1 = "Ishvara earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Ilabrat Ring",
		back = "Alaunus's Cape", waist = "Luminary Sash", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS,
	{
		neck = "Fotia Gorget", ear1 = "Telos Earring",
		body = "Piety Bliaut +3", hands = "Piety Mitts +3", ring1 = "Petrov Ring",
		back = "Alaunus's Cape", waist = "Fotia Belt", feet = "Piety Duckbills +3"
	})

	sets.MaxTP = { ear1="Telos Earring", ear2="Brutal Earring" }

	-- Midcast Sets

	sets.Kiting = {}
	sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}

	-- Conserve Mp set for spells that don't need anything else, for set_combine.
	sets.ConserveMP = {}

	sets.midcast.Teleport = sets.ConserveMP

	-- Gear for Magic Burst mode.
	sets.MagicBurst = { neck="Mizu. Kubikazari" }

	sets.midcast.FastRecast = sets.precast.FC

	-- Cure sets

	sets.midcast['Full Cure'] = sets.midcast.FastRecast

	sets.midcast.Cure =
	{
		main = "Chatoyant Staff", sub = "Bugard Strap +1", ammo = "Pemphredo Tathlum",
		head = "Ebers Cap +1", neck = "Cleric's Torque", ear1 = "Nourish. Earring +1", ear2 = "Mendi. Earring",
		body = "Theo. Bliaut +3", hands = "Theophany Mitts +3", ring1 = "Janniston Ring", ring2 = "Lebeche Ring",
		back = "Alaunus's Cape", waist = "Hachirin-no-Obi", legs = "Ebers Pant. +1", feet = "Vanya Clogs"
	}
	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, { waist = "Hachirin-no-Obi", back = "Twilight Cape" })
	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, { waist = "Hachirin-no-Obi", back = "Twilight Cape" })
		
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure, { body = "Ebers Bliaut +1" })
	sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.CureSolace, { waist = "Hachirin-no-Obi", back = "Twilight Cape" })
	sets.midcast.LightDayCureSolace = set_combine(sets.midcast.CureSolace, { waist = "Hachirin-no-Obi", back = "Twilight Cape" })

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
	sets.midcast.LightWeatherCuraga = set_combine(sets.midcast.Curaga, { waist = "Hachirin-no-Obi", back = "Twilight Cape" })
	sets.midcast.LightDayCuraga = set_combine(sets.midcast.Curaga, { waist = "Hachirin-no-Obi", back = "Twilight Cape" })

	sets.midcast.Cure.DT = set_combine(sets.midcast.Cure, {})

	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure =
	{
		ammo = "Pemphredo Tathlum",
		head = "Ebers Cap +1", neck = "Cleric's Torque", ear1 = "Nourish. Earring +1", ear2 = "Mendi. Earring",
		body = "Ebers Bliaut +1", hands = "Theophany Mitts +3", ring1 = "Janniston Ring", ring2 = "Lebeche Ring",
		back = "Alaunus's Cape", waist = "Hachirin-no-Obi", legs = "Ebers Pant. +1", feet = "Vanya Clogs"
	}

	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, { body = "Ebers Bliaut +1" })
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, { waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, { body = "Ebers Bliaut +1", waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, { body = "Ebers Bliaut +1", waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, { waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, { waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, { waist = "Hachirin-no-Obi" })

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, { body = "Ebers Bliaut +1" })
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, { body = "Ebers Bliaut +1", waist = "Hachirin-no-Obi" })
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, { body = "Ebers Bliaut +1", waist = "Hachirin-no-Obi" })
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})
	
	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, { body = "Ebers Bliaut +1" })
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, { body = "Ebers Bliaut +1", waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, { body = "Ebers Bliaut +1", waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })

	sets.midcast.Cursna =
	{
		main = "Gada", sub = "Thuellaic Ecu +1",
		head = "Vanya Hood", neck = "Malison Medal",
		body = "Ebers Bliaut +1", hands = "Fanatic Gloves", ring1 = "Haoma's Ring", ring2 = "Haoma's Ring",
		back = "Alaunus's Cape", legs = "Th. Pant. +3",
	}

	sets.midcast.StatusRemoval =
	{
		head = "Ebers Cap +1",
	}

	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, { neck="Cleric's Torque" })

	-- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] =
	{
		main = "Gada", sub = "Ammurapi Shield",
		head = "Befouled Crown",
		body = "Telchine Chas.", hands = "Inyan. Dastanas +2",
		back = "Perimede Cape", waist = "Olympus Sash", legs = "Clr. Pantaln. +2", feet = "Theo. Duckbills +3"
	}

	sets.midcast['Enhancing Magic'].Duration = set_combine(sets.midcast['Enhancing Magic'],
	{
		waist = "Embla Sash",
	})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'].Duration, { waist = "Siegel Sash" })
	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'].Duration, {})
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'].Duration, { head = "Chrionic Hat" })
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'].Duration,
	{
		main = "Bolelabunga",
		head = "Inyanga Tiara +2",
		body = "Piety Bliaut +3",
		legs = "Th. Pant. +3"
	})

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'].Duration, {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'].Duration, {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'].Duration, {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'].Duration, {})

	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'].Duration,
	{
		main = "Beneficus",
		head = "Ebers Cap +1",
		body = "Ebers Bliaut +1",
	})

	sets.midcast['Elemental Magic'] =
	{
		main = "Daybreak", sub = "Ammurapi Shield", ammo = "Pemphredo Tathlum",
		ear1 = "Regal Earring", ear2 = "Malignance Earring",
		ring1 = "Metamor. Ring +1"
	}
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Elemental Magic'],
	{
		body = "Inyanga Jubbah +2",
		waist = "Luminary Sash"
	})
		
	sets.midcast.Holy = set_combine(sets.midcast['Divine Magic'], {})

	sets.midcast['Dark Magic'] =
	{
		main = "Daybreak", sub = "Ammurapi Shield", ammo = "Pemphredo Tathlum",
		head = "Bunzi's Hat", neck = "Erra Pendant", ear1 = "Regal Earring", ear2 = "Malignance Earring",
		body = "Inyanga Jubbah +2", hands = "Theophany Mitts +3", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1", waist = "Acuity Belt +1", legs = "Inyanga Shalwar +2", feet = "Theo. Duckbills +3"
	}

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {})
	sets.midcast.Drain.Resistant = set_combine(sets.midcast.Drain, {})

	sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast['Enfeebling Magic'] =
	{
		main = "Daybreak", sub = "Ammurapi Shield", ammo = "Pemphredo Tathlum",
		head = "Theophany Cap +3", neck = "Erra Pendant", ear1 = "Regal Earring", ear2 = "Malignance Earring",
		body = "Theo. Bliaut +3", hands = "Theophany Mitts +3", ring1 = "Kishar Ring", ring2 = "Stikini Ring +1",
		waist = "Luminary Sash", legs="Inyanga Shalwar +2", feet = "Theo. Duckbills +3"
	}
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})

	sets.midcast.Stun = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {})
		
	sets.midcast.Dispel = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {})

	sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'], { head = empty, body = "Twilight Cloak" })
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = sets.midcast['Enfeebling Magic']
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = sets.midcast['Enfeebling Magic']

	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], { waist = "Acuity Belt +1" })
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, { waist = "Acuity Belt +1" })

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], { back = "Alaunus's Cape" })
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, { back = "Alaunus's Cape" })

	-- Sets to return to when not performing an action.

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle =
	{
		main = "Mpaca's Staff", sub = "Umbra Strap", ammo = "Homiliary",
		head = "Inyanga Tiara +2", neck = "Twilight Torque", ear1 = "Etiolation Earring", ear2 = "Eabani Earring",
		body = "Theo. Bliaut +3", hands = "Inyan. Dastanas +2", ring1 = "Inyanga Ring", ring2 = "Defending Ring",
		back = "Alaunus's Cape", waist = "Carrier's Sash", legs = "Inyanga Shalwar +2", feet = "Inyan. Crackows +2"
	}

	sets.idle.PDT = set_combine(sets.idle, { ammo = "Staunch Tathlum" })
	sets.idle.MDT = set_combine(sets.idle.PDT, {})

	-- Resting sets
	sets.resting = set_combine(sets.idle, { main = "Chatoyant Staff" })

	-- Defense sets - TODO: Update these. Don't use them yet.
	sets.defense.PDT =
	{
		main = "Mafic Cudgel", sub = "Genmei Shield", ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Loricate Torque +1", ear1 = "Etiolation Earring", ear2 = "Ethereal Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = "Shadow Mantle", waist = "Carrier's Sash", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.defense.MDT =
	{
		main = "Daybreak", sub = "Ammurapi Shield", ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Warder's Charm +1", ear1 = "Etiolation Earring", ear2 = "Ethereal Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Shadow Ring", ring2 = "Archon Ring",
		back = "Moonlight Cape", waist = "Carrier's Sash", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.defense.MEVA =
	{
		main = "Daybreak", sub = "Ammurapi Shield", ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Warder's Charm +1", ear1 = "Etiolation Earring", ear2 = "Eabani Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Purity Ring", ring2 = "Vengeful Ring",
		back = "Aurist's Cape +1", waist = "Carrier's Sash", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Basic set for if no TP weapon is defined.
	sets.engaged = 
	{
		ammo = "Amar Cluster",
		head = "Aya. Zucchetto +2", neck = "Lissome Necklace", ear1 = "Telos Earring" , ear2 = "Brutal Earring",
		body = "Ayanmo Corazza +2", hands = "Bunzi's Gloves", ring1 = "Petrov Ring", ring2 = "Ilabrat Ring",
		back = "Alaunus's Cape", waist = "Windbuffet Belt +1", legs = "Aya. Cosciales +2", feet = "Aya. Gambieras +2"
	}
	sets.engaged.Acc = set_combine(sets.engaged, { ear2 = "Mache Earring +1" })

	sets.engaged.DW = set_combine(sets.engaged, { ear1 = "Suppanomimi", ear2 = "Eabani Earring" })
	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {})

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Divine Caress'] = { hands = "Ebers Mitts +1", back = "Mending Cape" }

	sets.HPDown =
	{
		head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Zendik Robe",hands="Hieros Mittens",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",waist="Carrier's Sash",legs="Shedir Seraweels",feet=""
	}

	sets.HPCure =
	{
		main="Queller Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Nyame Helm",neck="Nodens Gorget",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Kunaji Ring",ring2="Meridian Ring",
		back="Alaunus's Cape",waist="Eschan Stone",legs="Ebers Pant. +1",feet="Kaykaus Boots"
	}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(3, 6)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 003')
end

autows_list = { ['DualWeapons'] = 'Realmrazer', ['MeleeWeapons'] = 'Realmrazer'}