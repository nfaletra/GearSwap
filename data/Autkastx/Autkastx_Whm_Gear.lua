-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_job_setup()
	state.OffenseMode:options('Normal')
	state.CastingMode:options('Normal','Resistant', 'SIRD', 'DT')
	state.IdleMode:options('Normal')
	state.HybridMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'Maxentius', 'Daybreak', 'DualYagrush', 'DualMaxentius', 'DualDaybreak')
	state.WeaponskillMode:options('Match', 'Normal', 'Proc')

	info.CastSpeed = 0.2

	gear.Alaunus =
	{
		TP = { name = "Alaunus's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Store TP"+10', 'Damage taken-5%' } },
		Healing = { name = "Alaunus's Cape", augments = { 'MND+20', 'Eva.+20 /Mag. Eva.+20', 'Enmity-10', 'Damage taken-5%' } },
	}

	-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurorastorm" <me>')
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

	-- Bottom alliance - Windows Key + FKey
	send_command('bind @f1 gs c smartcure a20')
	send_command('bind @f2 gs c smartcure a21')
	send_command('bind @f3 gs c smartcure a22')
	send_command('bind @f4 gs c smartcure a23')
	send_command('bind @f5 gs c smartcure a24')
	send_command('bind @f6 gs c smartcure a25')

	-- Curaga bind - Ctrl + Windows Key + FKey
	send_command('bind ^@f1 input /ma "Curaga III" <p0>')
	send_command('bind ^@f2 input /ma "Curaga III" <p1>')
	send_command('bind ^@f3 input /ma "Curaga III" <p2>')
	send_command('bind ^@f4 input /ma "Curaga III" <p3>')
	send_command('bind ^@f5 input /ma "Curaga III" <p4>')
	send_command('bind ^@f6 input /ma "Curaga III" <p5>')

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Maxentius = { main = "Maxentius", sub = "Genmei Shield" }
	sets.weapons.Daybreak = { main = "Daybreak", sub = "Genmei Shield" }
	sets.weapons.DualYagrush = { main = "Yagrush", sub = "C. Palug Hammer" }
	sets.weapons.DualMaxentius = { main = "Maxentius", sub = "C. Palug Hammer" }
	sets.weapons.DualDaybreak = { main = "Daybreak", sub = "C. Palug Hammer" }
	
	sets.buff.Sublimation = { waist = "Embla Sash" }
	sets.buff.DTSublimation = { waist = "Embla Sash" }

	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		main = "C. Palug Hammer", sub = "Chanter's Shield", ammo = "Impatiens",
		head = "Ebers Cap +3", neck = "Clr. Torque +2", ear1 = "Etiolation Earring", ear2 = "Malignance Earring",
		body = "Inyanga Jubbah +2", hands = "Gende. Gages +1", ring1 = "Medada's Ring", ring2 = "Lebeche Ring",
		back = "Perimede Cape", waist = "Witful Belt", legs = "Aya. Cosciales +2", feet = "Regal Pumps +1"
	}
		
	sets.precast.FC.DT = sets.precast.FC

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {})

	sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {})

	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, { head = empty, body = "Crepuscular Cloak" })

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak" })

	-- Precast sets to enhance JAs
	sets.precast.JA.Benediction = { body = "Piety Bliaut +3" }
	sets.precast.JA.Devotion = { head = "Piety Cap +3" }

	-- Waltz set (chr and vit)
	sets.precast.Waltz = { body = "Piety Bliaut +3" }

	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		ammo = "Oshasha's Treatise",
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Ishvara Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Epaminondas's Ring",
		back = gear.Alaunus.TP, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Black Halo'] =
	{
		ammo = "Oshasha's Treatise",
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Regal Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Epaminondas's Ring",
		back = gear.Alaunus.TP, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Hexa Strike'] =
	{
		ammo = "Oshasha's Treatise",
		head = "Blistering Sallet +1", neck = "Fotia Gorget", ear1 = "Telos Earring", ear2 = "Mache Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Shukuyu Ring", ring2 = "Begrudging Ring",
		back = gear.Alaunus.TP, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Realmrazer'] =
	{
		ammo = "Oshasha's Treatise",
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Telos Earring", ear2 = "Mache Earring +1",
		body = "Nyame Mail", hands = "Bunzi's Gloves", ring1 = "Metamor. Ring +1", ring2 = "Rufescent Ring",
		back = gear.Alaunus.TP, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Mystic Boon'] =
	{
		ammo = "Oshasha's Treatise",
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Regal Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Epaminondas's Ring",
		back = gear.Alaunus.TP, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Seraph Strike'] =
	{
		ammo = "Oshasha's Treatise",
		head = "Nyame Helm", neck = "Saevus Pendant +1", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Epaminondas's Ring",
		back = gear.Alaunus.TP, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Seraph Strike'], {})

	sets.MaxTP = { ear1="Telos Earring", ear2="Brutal Earring" }

	-- Midcast Sets

	sets.Kiting = { feet = "Herald's Gaiters" }
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
	sets.MagicBurst = {}

	sets.midcast.FastRecast = set_combine(sets.precast.FC,
	{
		ammo = "Pemphredo Tathlum",
		head = "Vanya Hood", ear1 = "Magnetic Earring", ear2 = "Calamitous Earring",
		ring1 = "Mephitas's Ring +1", ring2 = "Defending Ring",
		back = "Fi Follet Cape +1", feet = "Kaykaus Boots +1"
	})

	-- Cure sets
	sets.midcast['Full Cure'] = sets.midcast.FastRecast

	sets.midcast.Cure =
	{
		main = "Raetic Rod +1", sub = "Thuellaic Ecu +1", ammo = "Pemphredo Tathlum",
		head = "Kaykaus Mitra +1", neck = "Clr. Torque +2", ear1 = "Glorious Earring", ear2 = "Magnetic Earring",
		body = "Theo. Bliaut +3", hands = "Theophany Mitts +3", ring1 = "Mephitas's Ring +1", ring2 = "Defending Ring",
		back = gear.Alaunus.Healing, waist = "Shinjutsu-no-Obi +1", legs = "Ebers Pant. +3", feet = "Kaykaus Boots +1"
	}
	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, { waist = "Hachirin-no-obi" })
	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, { waist = "Hachirin-no-obi" })
		
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure, { body = "Ebers Bliaut +3" })
	sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.CureSolace, sets.midcast.LightWeatherCure, {})
	sets.midcast.LightDayCureSolace = set_combine(sets.midcast.CureSolace, sets.midcast.LightDayCure, {})

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
	sets.midcast.LightWeatherCuraga = set_combine(sets.midcast.Curaga, { back = "Twilight Cape", waist = "Hachirin-no-obi" })
	sets.midcast.LightDayCuraga = set_combine(sets.midcast.Curaga, { back = "Twilight Cape", waist = "Hachirin-no-obi" })

	sets.midcast.Cure.DT = set_combine(sets.midcast.Cure, {})

	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure =
	{
		ammo = "Pemphredo Tathlum",
		head = "Kaykaus Mitra +1", neck = "Clr. Torque +2", ear1 = "Glorious Earring", ear2 = "Magnetic Earring",
		body = "Theo. Bliaut +3", hands = "Theophany Mitts +3", ring1 = "Mephitas's Ring +1", ring2 = "Defending Ring",
		back = gear.Alaunus.Healing, waist = "Shinjutsu-no-Obi +1", legs = "Ebers Pant. +3", feet = "Kaykaus Boots +1"
	}

	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, sets.midcast.CureSolace, {})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, sets.midcast.LightWeatherCure, {})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, sets.midcast.LightWeatherCureSolace, {})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, sets.midcast.LightDayCureSolace, {})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, sets.midcast.LightDayCure, {})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, sets.midcast.LightWeatherCuraga, {})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, sets.midcast.LightDayCuraga, {})

	-- 471 skill - ML17 : 480 skill with light arts
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast,
	{
		main = "Gada", sub = "Ammurapi Shield",
		head = "Telchine Cap",
		body = "Telchine Chas.", hands = gear.telchine.hands.enhancing,
		waist = "Embla Sash", legs = "Telchine Braconi", feet = "Theo. Duckbills +3"
	})

	-- 491 skill - ML17 : 500 skill with light arts
	sets.midcast.BoostStat = set_combine(sets.midcast['Enhancing Magic'],
	{
		neck = "Incanter's Torque", ear2 = "Mimir Earring",
	})

	-- 502 skill - ML17
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],
	{
		main = "Beneficus",
		head = "Ebers Cap +3", neck = "Incanter's Torque", ear2 = "Andoaa Earring",
		body = "Ebers Bliaut +3", hands = "Ebers Mitts +3",
		back = gear.Alaunus.Healing, legs = "Piety Pantaln. +3", feet = "Ebers Duckbills +3"
	})

	-- 486 skill - ML17
	sets.midcast.BarStatus = set_combine(sets.midcast['Enhancing Magic'],
	{
		neck = "Sroda Necklace", ear1 = "Mimir Earring", ear2 = "Andoaa Earring"
	})

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],
	{
		main = "Bolelabunga",
		head = "Inyanga Tiara +2",
		body = "Piety Bliaut +3", hands = "Ebers Mitts +3",
		legs = "Th. Pant. +3", feet = "Bunzi's Sabots"
	})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],
	{
		ear1 = "Earthcry Earring",
		waist = "Siegel Sash", legs = "Shedir Seraweels"
	})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
	{
		main = "Vadose Rod",
		head = "Chironic Hat",
		hands = "Regal Cuffs",
		waist = "Emphatikos Rope", legs = "Shedir Seraweels"
	})

	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], { feet = "Ebers Duckbills +3" })

	sets.midcast.Cursna = set_combine(sets.midcast.FastRecast,
	{
		main = "Yagrush", sub = "Thuellaic Ecu +1",
		neck = "Debilis Medallion", ear1 = "Meili Earring", ear2 = "Ebers Earring +1",
		body = "Ebers Bliaut +3", hands = "Fanatic Gloves", ring1 = "Menelaus's Ring", ring2 = "Haoma's Ring",
		back = gear.Alaunus.Healing, waist = "Bishop's Sash", legs = "Th. Pant. +3", feet = "Vanya Clogs"
	})

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast,
	{
		main = "Yagrush",
		hands = "Ebers Mitts +3",
		back = "Mending Cape", legs = "Ebers Pant. +3"
	})

	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, { neck = "Clr. Torque +2" })

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast['Elemental Magic'] =
	{
		main = "Bunzi's Rod", sub = "Ammurapi Shield", ammo = "Pemphredo Tathlum",
		head = empty, neck = "Baetyl Pendant", ear1 = "Regal Earring", ear2 = "Malignance Earring",
		body = "Cohort Cloak +1", hands = "Bunzi's Gloves", ring1 = "Metamor. Ring +1", ring2 = "Freke Ring",
		back = "Aurist's Cape +1", waist = "Sacro Cord", legs = "Bunzi's Pants", feet = "Bunzi's Sabots"
	}
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	
	sets.midcast.Holy =
	{
		main = "Daybreak", sub = "Ammurapi Shield", ammo = "Ghastly Tathlum +1",
		head = empty, neck = "Saevus Pendant +1", ear1 = "Regal Earring", ear2 = "Malignance Earring",
		body = "Cohort Cloak +1", hands = "Bunzi's Gloves", ring1 = "Freke Ring", ring2 = "Metamor. Ring +1",
		back = "Aurist's Cape +1", waist = "Eschan Stone", legs = "Bunzi's Pants", feet = "Bunzi's Sabots"
	}
	sets.midcast.Banish = set_combine(sets.midcast.Holy,
	{
		head = "Ipoca Beret", neck = "Jokushu Chain",
		body = "Theo. Bliaut +3"
	})

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
		main = "Bunzi's Rod", sub = "Ammurapi Shield", ammo = "Pemphredo Tathlum",
		head = "Theophany Cap +3", neck = "Erra Pendant", ear1 = "Regal Earring", ear2 = "Ebers Earring +1",
		body = "Theo. Bliaut +3", hands = "Theophany Mitts +3", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1", waist = "Obstin. Sash", legs = "Inyanga Shalwar +2", feet = "Theo. Duckbills +3"
	}

	sets.midcast.Paralyze = set_combine(sets.midcast['Enfeebling Magic'],
	{
		ammo = "Hydrocera",
		neck = "Clr. Torque +2", ring2 = "Metamor. Ring +1",
	})
	sets.midcast.Slow = sets.midcast.Paralyze

	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, { main = "Daybreak" })

	sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'], { head = empty, body = "Crepuscular Cloak" })
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = sets.midcast['Enfeebling Magic']
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = sets.midcast['Enfeebling Magic']

	sets.midcast.Repose =
	{
		main = "Yagrush", sub = "Ammurapi Shield", ammo = "Hydrocera",
		head = "Theophany Cap +3", neck = "Jokushu Chain", ear1 = "Regal Earring", ear2 = "Ebers Earring +1",
		body = "Theo. Bliaut +3", hands = "Piety Mitts +3", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1", waist = "Obstin. Sash", legs = "Th. Pant. +3", feet = "Theo. Duckbills +3"
	}
	sets.midcast.Flash = sets.midcast.Repose

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = -- With +3 Empy, this set is 10% over DT Cap (54% total). When that happens, swap neck for Warder's Charm and another 5% can still be swapped out.
	{
		main = "Mpaca's Staff", sub = "Umbra Strap", ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Warder's Charm +1", ear1 = "Etiolation Earring", ear2 = "Eabani Earring",
		body = "Ebers Bliaut +3", hands = "Ebers Mitts +3", ring1 = "Stikini Ring +1", ring2 = "Shadow Ring",
		back = "Solemnity Cape", waist = "Carrier's Sash", legs = "Ebers Pant. +3", feet = "Ebers Duckbills +3"
	}

	-- Resting sets
	sets.resting = set_combine(sets.idle, {})

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Basic set for if no TP weapon is defined.
	sets.engaged =
	{
		ammo = "Amar Cluster",
		head = "Bunzi's Hat", neck = "Combatant's Torque", ear1 = "Telos Earring" , ear2 = "Crep. Earring",
		body = "Ayanmo Corazza +2", hands = "Bunzi's Gloves", ring1 = "Chirich Ring +1", ring2 = "Chirich Ring +1",
		back = gear.Alaunus.TP, waist = "Cornelia's Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.engaged.DW = set_combine(sets.engaged, { ear1 = "Suppanomimi", ear2 = "Eabani Earring" })

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Divine Caress'] = { hands = "Ebers Mitts +3", back = "Mending Cape" }

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	sets.buff.Sleep = set_combine(sets.buff.Sleep, { main = "Lorg Mor" })

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(3, 6)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 003')
end

autows_list = { ['DualWeapons'] = 'Realmrazer', ['MeleeWeapons'] = 'Realmrazer'}