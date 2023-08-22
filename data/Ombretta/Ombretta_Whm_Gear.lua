-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_job_setup()
	--include('AutoHeals.lua')

	state.OffenseMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal','Resistant', 'SIRD', 'DT')
	state.IdleMode:options('Normal', 'DT', 'MEVA')
	state.HybridMode:options('Normal', 'Dual Wield')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'Maxentius', 'Daybreak', 'DualMaxentius', 'DualDaybreak')
	state.WeaponskillMode:options('Normal')

	state.AutoCureMode:options('Off', 'Party', 'Ally')
	state.AllianceCureMode:options('Off', 'Top', 'Bottom', 'All')

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
	sets.weapons.Maxentius = { main = "Maxentius", sub = "Genmei Shield" }
	sets.weapons.Daybreak = { main = "Daybreak", sub = "Genmei Shield" }
	sets.weapons.DualMaxentius = { main = "Maxentius", sub = "C. Palug Hammer" }
	sets.weapons.DualDaybreak = { main = "Daybreak", sub = "C. Palug Hammer" }
	
	sets.buff.Sublimation = { waist = "Embla Sash" }
	sets.buff.DTSublimation = { waist = "Embla Sash" }

	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		main = "C. Palug Hammer", sub = "Chanter's Shield", ammo = "Impatiens",
		head = "Ebers Cap +2", neck = "Clr. Torque +2", ear1 = "Loquac. Earring", ear2 = "Malignance Earring",
		body = "Inyanga Jubbah +2", hands = "Gende. Gages +1", ring1 = "Kishar Ring", ring2 = "Lebeche Ring",
		back = "Perimede Cape", waist = "Witful Belt", legs = "Aya. Cosciales +2", feet = "Regal Pumps +1"
	}
		
	sets.precast.FC.DT = sets.precast.FC

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, { legs = "Ebers Pant. +3" })

	sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'],
	{
		main = "Queller Rod", sub = "Sors Shield",
		ear1 = "Mendi. Earring",
	})

	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, { head = empty, body = "Twilight Cloak" })

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
		ammo = "Pemphredo Tathlum",
		head = "Nyame Helm", neck = "Clr. Torque +2", ear1 = "Ishvara earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Rufescent Ring",
		back = "Alaunus's Cape", waist = "Luminary Sash", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS,
	{
		head = "Piety Cap +3", neck = "Fotia Gorget", ear1 = "Telos Earring",
		body = "Piety Bliaut +3", hands = "Piety Mitts +3", ring1 = "Petrov Ring",
		back = "Alaunus's Cape", waist = "Fotia Belt", legs = "Piety Pantaln. +3", feet = "Piety Duckbills +3"
	})

	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS,
	{
		ammo = "Oshasha's Treatise",
		head = "Piety Cap +3", neck = "Fotia Gorget", ear1 = "Telos Earring", ear2 = "Regal Earring",
		body = "Piety Bliaut +3", hands = "Piety Mitts +3", ring2 = "Rufescent Ring",
		waist = "Fotia Belt", legs = "Piety Pantaln. +3", feet = "Piety Duckbills +3"
	})

	sets.precast.WS['Mystic Boon'] = set_combine(sets.precast.WS,
	{
		ear1 = "Regal Earring"
	})

	sets.precast.WS['Seraph Strike'] = set_combine(sets.precast.WS,
	{
		ammo = "Ghastly Tathlum +1",
		ear1 = "Regal Earring"
	})

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
	sets.MagicBurst = { neck="Mizu. Kubikazari" }

	sets.midcast.FastRecast = sets.precast.FC

	-- Cure sets
	sets.midcast['Full Cure'] = sets.midcast.FastRecast

	sets.midcast.Cure =
	{
		main = "Raetic Rod +1", sub = "Thuellaic Ecu +1", ammo = "Pemphredo Tathlum",
		head = "Kaykaus Mitra +1", neck = "Clr. Torque +2", ear1 = "Glorious Earring", ear2 = "Magnetic Earring",
		body = "Theo. Bliaut +3", hands = "Theophany Mitts +3", ring1 = "Mephitas's Ring +1", ring2 = "Defending Ring",
		back = "Alaunus's Cape", waist = "Luminary Sash", legs = "Ebers Pant. +3", feet = "Kaykaus Boots +1"
	}
	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, { waist = "Hachirin-no-obi" })
	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, { waist = "Hachirin-no-obi" })
		
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure, { body = "Ebers Bliaut +2" })
	sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.CureSolace, sets.midcast.LightWeatherCure, {})
	sets.midcast.LightDayCureSolace = set_combine(sets.midcast.CureSolace, sets.midcast.LightDayCure, {})

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, { back = "Twilight Cape" })
	sets.midcast.LightWeatherCuraga = set_combine(sets.midcast.Curaga, { waist = "Hachirin-no-obi" })
	sets.midcast.LightDayCuraga = set_combine(sets.midcast.Curaga, { waist = "Hachirin-no-obi" })

	sets.midcast.Cure.DT = set_combine(sets.midcast.Cure, {})

	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure =
	{
		ammo = "Pemphredo Tathlum",
		head = "Kaykaus Mitra +1", neck = "Clr. Torque +2", ear1 = "Glorious Earring", ear2 = "Magnetic Earring",
		body = "Theo. Bliaut +3", hands = "Theophany Mitts +3", ring1 = "Mephitas's Ring +1", ring2 = "Defending Ring",
		back = "Alaunus's Cape", waist = "Luminary Sash", legs = "Ebers Pant. +3", feet = "Kaykaus Boots +1"
	}

	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, sets.midcast.CureSolace, {})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, sets.midcast.LightWeatherCure, {})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, sets.midcast.LightWeatherCureSolace, {})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, sets.midcast.LightDayCureSolace, {})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, sets.midcast.LightDayCure, {})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, sets.midcast.LightWeatherCuraga, {})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, sets.midcast.LightDayCuraga, {})

	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, { neck = "Clr. Torque +2" })

	-- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] =
	{
		main = "Gada", sub = "Ammurapi Shield", ammo = "Pemphredo Tathlum",
		head = "Telchine Cap", neck = "Incanter's Torque", ear1 = "Andoaa Earring",
		body = "Telchine Chas.", hands = "Telchine Gloves", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Mending Cape", waist = "Embla Sash", legs = "Telchine Braconi", feet = "Theo. Duckbills +3"
	}

	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'].Duration,
	{
		main = "Beneficus",
		head = "Ebers Cap +2",
		body = "Ebers Bliaut +2", hands = "Ebers Mitts +2",
		legs = "Piety Pantaln. +3", feet = "Ebers Duckbills +2"
	})

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],
	{
		main = "Bolelabunga",
		head = "Inyanga Tiara +2", ear2 = "Gifted Earring",
		body = "Piety Bliaut +3", hands = "Ebers Mitts +2", ring1 = "Mephitas's Ring +1",
		legs = "Th. Pant. +3", feet = "Bunzi's Sabots"
	})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],
	{
		ear1 = "Earthcry Earring",
		waist = "Siegel Sash", legs = "Shedir Seraweels"
	})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
	{
		head = "Chironic Hat", ear2 = "Gifted Earring",
		hands = "Regal Cuffs", ring1 = "Mephitas's Ring +1",
		waist = "Emphatikos Rope", legs = "Shedir Seraweels"
	})

	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], { feet = "Ebers Duckbills +2" })

	sets.midcast.Cursna =
	{
		main = "Gada", sub = "Thuellaic Ecu +1",
		head = "Vanya Hood", neck = "Malison Medallion", ear1 = "Meili Earring", ear2 = "Ebers Earring",
		body = "Ebers Bliaut +2", hands = "Fanatic Gloves", ring1 = "Haoma's Ring", ring2 = "Haoma's Ring",
		back = "Alaunus's Cape", legs = "Th. Pant. +3", feet = "Vanya Clogs"
	}

	sets.midcast.StatusRemoval =
	{
		head = "Ebers Cap +2",
	}

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast['Elemental Magic'] =
	{
		main = "Daybreak", sub = "Ammurapi Shield", ammo = "Pemphredo Tathlum",
		head = empty, neck = "Mizu. Kubikazari", ear1 = "Regal Earring", ear2 = "Malignance Earring",
		body = "Cohort Cloak +1", hands = "Bunzi's Gloves", ring1 = "Metamor. Ring +1", ring2 = "Freke Ring",
		legs = "Bunzi's Pants", feet = "Bunzi's Sabots"
	}
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Elemental Magic'],
	{
		body = "Inyanga Jubbah +2",
		waist = "Luminary Sash"
	})

	sets.midcast.Holy = set_combine(sets.midcast['Divine Magic'], { feet = "Piety Duckbills +3" })

	sets.midcast.Banish = set_combine(sets.midcast['Divine Magic'], { head = "Ipoca Beret", neck = "Jokushu Chain" })

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
		main = "Daybreak", sub = "Genmei Shield", ammo = "Homiliary",
		head = "Inyanga Tiara +2", neck = "Twilight Torque", ear1 = "Etiolation Earring", ear2 = "Eabani Earring",
		body = "Ebers Bliaut +2", hands = "Inyan. Dastanas +2", ring1 = "Inyanga Ring", ring2 = "Defending Ring",
		back = "Solemnity Cape", waist = "Carrier's Sash", legs = "Inyanga Shalwar +2", feet = "Inyan. Crackows +2"
	}

	sets.idle.DT =
	{
		main = "Malignance Pole", sub = "Umbra Strap", ammo = "Homiliary",
		head = "Nyame Helm", neck = "Twilight Torque", ear1 = "Etiolation Earring", ear2 = "Genmei Earring",
		body = "Ebers Bliaut +2", hands = "Inyan. Dastanas +2", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Solemnity Cape", waist = "Carrier's Sash", legs = "Inyanga Shalwar +2", feet = "Nyame Sollerets"
	}

	sets.idle.MEVA =
	{
		main = "Daybreak", sub = "Genmei Shield", ammo = "Homiliary",
		head = "Bunzi's Hat", neck = "Warder's Charm +1", ear1 = "Etiolation Earring", ear2 = "Eabani Earring",
		body = "Ebers Bliaut +2", hands = "Inyan. Dastanas +2", ring1 = "Inyanga Ring", ring2 = "Defending Ring",
		back = "Solemnity Cape", waist = "Carrier's Sash", legs = "Bunzi's Pants", feet = "Inyan. Crackows +2"
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
		ammo = "Oshasha's Treatise",
		head = "Aya. Zucchetto +2", neck = "Combatant's Torque", ear1 = "Telos Earring" , ear2 = "Brutal Earring",
		body = "Ayanmo Corazza +2", hands = "Bunzi's Gloves", ring1 = "Petrov Ring", ring2 = "Hetairoi Ring",
		back = "Alaunus's Cape", waist = "Windbuffet Belt +1", legs = "Aya. Cosciales +2", feet = "Aya. Gambieras +2"
	}
	sets.engaged.Acc = set_combine(sets.engaged, {})

	sets.engaged['Dual Wield'] = set_combine(sets.engaged, { ear1 = "Suppanomimi", ear2 = "Eabani Earring" })
	sets.engaged['Dual Wield'].Acc = set_combine(sets.engaged.DW, {})

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Divine Caress'] = { hands = "Ebers Mitts +2", back = "Mending Cape" }

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