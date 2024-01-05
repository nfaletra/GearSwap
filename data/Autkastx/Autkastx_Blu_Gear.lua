function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Acc')
	state.HybridMode:options('Normal', 'DT')
	state.WeaponskillMode:options('Match', 'Normal', 'Acc')
	state.CastingMode:options('Normal', 'SIRD', 'FullMacc')
	state.IdleMode:options('Normal', 'Evasion')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'Naegling', 'NaeglingAcc', 'Maxentius', 'MaxentiusAcc', 'Magic')

	state.ExtraMeleeMode = M{ ['description'] = 'Extra Melee Mode', 'None'}

	gear.Rosmerta =
	{
		TP = { name = "Rosmerta's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%' } },
		WSD = { name = "Rosmerta's Cape", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%' } },
		Magic = { name = "Rosmerta's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'Magic Damage +5', '"Mag.Atk.Bns."+10', 'Mag. Evasion+15' } },
		Evasion = { name = "Rosmerta's Cape", augments = { 'AGI+20', 'Eva.+20 /Mag. Eva.+20', '"Fast Cast"+10', 'Evasion+15' } },
		Cure = { name = "Rosmerta's Cape", augments = { 'MND+20', 'Eva.+20 /Mag. Eva.+20', '"Cure" potency +10%', 'Damage taken-5%' } },
	}

	autows = 'Expiacion'

	-- Additional local binds
	send_command('bind ^` input /ja "Chain Affinity" <me>')
	send_command('bind @` input /ja "Efflux" <me>')
	send_command('bind !` input /ja "Burst Affinity" <me>')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	send_command('bind !backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Mighty Guard" <me>')
	send_command('bind @backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Carcharian Verve" <me>')
	send_command('bind ^backspace input /ja "Unbridled Learning" <me>;wait 1;input /ma "Cruel Joke" <t>')
	send_command('bind @f10 gs c toggle LearningMode')
	send_command('bind ^@!` gs c cycle MagicBurstMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !@^f7 gs c toggle AutoWSMode')
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons Almace;gs c update')
	send_command('bind !q gs c weapons HybridWeapons;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.buff['Burst Affinity'] = { feet = "Hashi. Basmak +2" }
	sets.buff['Chain Affinity'] = { head = "Hashishin Kavuk +2", feet = "Assim. Charuqs +2" }
	sets.buff.Convergence = { head = "Luh. Keffiyeh +3" }
	sets.buff.Diffusion = { feet = "Luhlaza Charuqs +3" }
	sets.buff.Enchainment = {}
	sets.buff.Efflux = { back = gear.Rosmerta.WSD, legs = "Hashishin Tayt +2" }
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	sets.HPDown = {}
	sets.HPCure = {}

	sets.Enmity =
	{
		ammo = "Sapience Orb",
		body = "Emet Harness +1", neck = "Unmoving Collar +1", ring1 = "Eihwaz Ring",
		legs = "Zoar Subligar",
	}

	sets.precast.JA['Provoke'] = sets.Enmity
	sets.precast.JA['Vallation'] = sets.Enmity

	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = { hands = "Luh. Bazubands +3" }

	-- Waltz set (chr and vit)
	sets.precast.Waltz =
	{
		ammo = "Staunch Tathlum +1",
		head="Carmine Mask +1", neck="Unmoving Collar +1",
		back="Moonlight Cape"
	}

	sets.Self_Waltz = { body="Passion Jacket" }

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step =
	{
		head = "Malignance Chapeau", neck = "Mirage Stole +2", ear1 = "Regal Earring", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves",
		back = gear.Rosmerta.TP, legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.Flourish1 =
	{
		head = "Malignance Chapeau",neck = "Mirage Stole +2", ear1 = "Regal Earring", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Cornflower Cape", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	-- Fast cast sets for spells

	sets.precast.FC =
	{
		ammo = "Sapience Orb",
		head = "Carmine Mask +1", neck = "Baetyl Pendant", ear1 = "Loquac. Earring", ear2 = "Etiolation Earring",
		body = gear.adhemar.body.d, hands = "Leyline Gloves", ring1 = "Kishar Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Rosmerta.Evasion, waist = "Witful Belt", legs = "Aya. Cosciales +2", feet = "Carmine Greaves +1"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { body = "Passion Jacket" })

	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, { body = "Hashishin Mintan +3", legs = "Nyame Flanchard" })

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		ammo = "Oshasha's Treatise",
		head = "Hashi. Kavuk +2", neck = "Fotia Gorget", ear1 = "Ishvara Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Epona's Ring", ring2 = "Ilabrat Ring",
		back = gear.Rosmerta.WSD, waist = "Fotia Belt", legs = "Luhlaza Shalwar +3", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS,
	{
		neck = "Mirage Stole +2",
		ring1 = "Epaminondas's Ring", ring2 = "Rufescent Ring",
		waist = "Sailfi Belt +1",
	})
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS['Expiacion'], {})
	sets.precast.WS['Judgement'] = set_combine(sets.precast.WS['Expiacion'], {})

	sets.precast.WS['Chant du Cygne'] =
	{
		ammo = "Aurgelmir Orb",
		head = "Adhemar Bonnet +1", neck = "Mirage Stole +2", ear1 = "Mache Earring +1", ear2 = "Odr Earring",
		body = "Gleti's Cuirass", hands = gear.adhemar.hands.b, ring1 = "Epona's Ring", ring2 = "Ilabrat Ring",
		back = gear.Rosmerta.TP, waist = "Fotia Belt", legs = "Zoar Subligar +1", feet = "Adhe. Gamashes +1"
	}
	sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS['Chant du Cygne'], {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] =
	{
		ammo = "Oshasha's Treatise",
		head = "Luh. Keffiyeh +3", neck = "Fotia Gorget", ear1 = "Regal Earring", ear2 = "Brutal Earring",
		body = "Luhlaza Jubbah +3", hands = gear.adhemar.hands.b, ring1 = "Epona's Ring", ring2 = "Rufescent Ring",
		back = gear.Rosmerta.Magic, waist = "Fotia Belt", legs = "Luhlaza Shalwar +3", feet = "Luhlaza Charuqs +3"
	}

	sets.precast.WS['Realmrazer'] =
	{
		ammo = "Coiste Bodhar",
		head = "Luh. Keffiyeh +3", neck = "Fotia Gorget", ear1 = "Regal Earring", ear2 = "Telos Earring",
		body = "Hashishin Mintan +3", hands = "Hashi. Bazu. +2", ring1 = "Metamor. Ring +1", ring2 = "Rufescent Ring",
		back = gear.Rosmerta.WSD, waist = "Fotia Belt", legs = "Hashishin Tayt +2", feet = "Hashi. Basmak +2"
	}

	sets.precast.WS['Black Halo'] =
	{
		ammo = "Oshasha's Treatise",
		head = "Nyame Helm", neck = "Mirage Stole +2", ear1 = "Regal Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Rufescent Ring",
		back = gear.Rosmerta.WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Flash Nova'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Hashishin Kavuk +2", neck = "Baetyl Pendant", ear1 = "Regal Earring", ear2 = "Friomisi Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Shiva Ring +1",
		back = gear.Rosmerta.WSD, waist = "Sacro Cord", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Sanguine Blade'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Pixie Hairpin +1", neck = "Baetyl Pendant", ear1 = "Regal Earring", ear2 = "Friomisi Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Archon Ring", ring2 = "Shiva Ring +1",
		back = gear.Rosmerta.Magic, waist = "Sacro Cord", legs = "Luhlaza Shalwar +3", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Seraph Blade'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Nyame Helm", neck = "Baetyl Pendant", ear1 = "Regal Earring", ear2 = "Friomisi Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Shiva Ring +1",
		back = gear.Rosmerta.Magic, waist = "Sacro Cord", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = { ear2 = "Brutal Earring" }
	sets.AccMaxTP = { ear2 = "Telos Earring" }

	-- Midcast Sets
	sets.midcast.FastRecast =
	{
		ammo = "Pemphredo Tathlum",
		head = "Carmine Mask +1", neck = "Mirage Stole +2", ear1 = "Regal Earring", ear2 = "Digni. Earring",
		body = "Luhlaza Jubbah +3", hands = "Hashi. Bazu. +2", ring1 = "Kishar Ring", ring2 = "Metamor. Ring +1",
		back = gear.Rosmerta.Evasion, waist = "Witful Belt", legs = "Assim. Shalwar +2", feet = "Luhlaza Charuqs +3"
	}

	sets.midcast['Blue Magic'] = {}

	-- Physical Spells --
	sets.midcast['Blue Magic'].Physical =
	{
		ammo = "Aurgelmir Orb",
		head = "Luh. Keffiyeh +3", neck = "Mirage Stole +2", ear1 = "Odnowa Earring +1", ear2 = "Telos Earring",
		body = "Assim. Jubbah +2", hands = gear.adhemar.hands.b, ring1 = "Ifrit Ring +1", ring2 = "Shukuyu Ring",
		back = gear.Rosmerta.WSD, waist = "Sailfi Belt +1", legs = "Gleti's Breeches", feet = "Luhlaza Charuqs +3"
	}
	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Phsyical, {})
	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {})

	-- Magical Spells --
	sets.midcast['Blue Magic'].Magical =
	{
		ammo = "Ghastly Tathlum +1",
		head = "Hashishin Kavuk +3", neck = "Sibyl Scarf", ear1 = "Regal Earring", ear2 = "Friomisi Earring",
		body = "Hashishin Mintan +3", hands = "Hashi. Bazu. +2", ring1 = "Metamor. Ring +1", ring2 = "Medada's Ring",
		back = gear.Rosmerta.Magic, waist = "Sacro Cord", legs = "Luhlaza Shalwar +3", feet = "Hashi. Basmak +2"
	}

	sets.midcast['Blue Magic']['Tenebral Crush'] = set_combine(sets.midcast['Blue Magic'].Magical,
	{
		head = "Pixie Hairpin +1",
		body = "Amalric Doublet +1", ring2 = "Archon Ring",
	})

	sets.midcast['Blue Magic'].Magical.SIRD =
	{
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Twilight Torque", ear1 = "Magnetic Earring",
		body = "Nyame Mail", hands = "Rawhide Gloves", ring1 = "Defending Ring", ring2 = "Gelatinous Ring +1",
		back = "Fi Follet Cape +1", waist = "Rumination Sash", legs = "Hashishin Tayt +2", feet = "Hashi. Basmak +2"
	}

	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, { ring2 = "Stikini Ring +1" })
	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].MagicAccuracy =
	{
		ammo = "Pemphredo Tathlum",
		head = "Hashishin Kavuk +3", neck = "Mirage Stole +2", ear1 = "Digni. Earring", ear2 = "Hashi. Earring +1",
		body = "Hashishin Mintan +3", hands = "Hashi. Bazu. +2", ring1 = "Metamor. Ring +1", ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1", waist = "Acuity Belt +1", legs = "Hashishin Tayt +2", feet = "Hashi. Basmak +2"
	}

	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
	{
		head = empty,
		body = "Cohort Cloak +1", hands = "Regal Cuffs", ring1 = "Kishar Ring"
	})

	sets.midcast['Dark Magic'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

	sets.midcast['Elemental Magic'] = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})

	sets.midcast.Helix = sets.midcast['Elemental Magic']

	sets.element.Dark = { head = "Pixie Hairpin +1", ring2 = "Archon Ring" }
	sets.element.Light = { head = "Assim. Keffiyeh +2", hands = "Hashi. Bazu. +2" }

	sets.midcast.Cure =
	{
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Loricate Torque +1", ear1 = "Regal Earring", ear2 = "Mendi. Earring",
		body = "Vrikodara Jupon", hands = "Telchine Gloves", ring1 = "Naji's Loop", ring2 = "Menelaus's Ring",
		back = gear.Rosmerta.Cure, waist = "Luminary Sash", legs = "Nyame Flanchard", feet = "Medium's Sabots"
	}

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure,
	{
		neck = "Debilis Medallion",
		ring1 = "Haoma's Ring", ring2 = "Haoma's Ring",
		waist = "Witful Belt"
	})

	-- Breath Spells --
	sets.midcast['Blue Magic'].Breath =
	{
		ammo = "Mavi Tathlum",
		head = "Luh. Keffiyeh +3", neck = "Mirage Stole +2", ear1 = "Regal Earring", ear2 = "Digni. Earring",
		body = "Assim. Jubbah +2", hands = "Luh. Bazubands +3", ring1 = "Kunaji Ring", ring2 = "Meridian Ring",
		back = "Cornflower Cape", legs = "Hashishin Tayt +2", feet = "Luhlaza Charuqs +3"
	}

	-- Physical Added Effect Spells most notably "Stun" spells --
	sets.midcast['Blue Magic'].Stun =
	{
		ammo = "Pemphredo Tathlum",
		head = "Carmine Mask +1", neck = "Mirage Stole +2", ear1 = "Regal Earring", ear2 = "Digni. Earring",
		body = "Luhlaza Jubbah +3", hands = "Leyline Gloves", ring1 = "Metamor. Ring +1", ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1", waist = "Sacro Cord", legs = "Luhlaza Shalwar +3", feet = "Luhlaza Charuqs +3"
	}

	-- Other Specific Spells --
	sets.midcast['Blue Magic'].Healing =
	{
		ammo = "Pemphredo Tathlum",
		head = "Nyame Helm", neck = "Phalaina Locket", ear1 = "Mendicant's Earring", ear2 = "Regal Earring",
		body = "Vrikodara Jupon", hands = "Telchine Gloves", ring1 = "Mephitas's Ring +1", ring2 = "Stikini Ring +1",
		back = gear.Rosmerta.Cure, waist = "Luminary Sash", legs = "Hashishin Tayt +2", feet = "Medium's Sabots"
	}

	sets.midcast['Blue Magic'].AoEHealing = set_combine(sets.midcast['Blue Magic'].Healing,
	{
		ring2 = "Kunaji Ring",
		waist = "Gishdubar Sash", legs = "Telchine Braconi"
	})
	
	sets.midcast['Blue Magic'].SkillBasedBuff =
	{
		ammo = "Pemphredo Tathlum",
		head = "Luh. Keffiyeh +3", neck = "Mirage Stole +2", ear1 = "Loquac. Earring", ear2 = "Etiolation Earring",
		body = "Assim. Jubbah +2", hands = "Rawhide Gloves", ring1 = "Kishar Ring", ring2 = "Stikini Ring +1",
		back = "Cornflower Cape", waist = "Witful Belt", legs = "Hashishin Tayt +2", feet = "Luhlaza Charuqs +3"
	}

	sets.midcast['Blue Magic'].Buff =
	{
		ammo = "Pemphredo Tathlum",
		head = "Telchine Cap", neck = "Twilight Torque", ear1 = "Mendicant's Earring", ear2 = "Magnetic Earring",
		body = "Amalric Doublet +1", hands = "Shrieker's Cuffs", ring1 = "Mephitas's Ring +1", ring2 = "Defending Ring",
		back = "Fi Follet Cape +1", waist = "Flume Belt +1", legs = "Nyame Flanchard", feet = "Carmine Greaves +1"
	}

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff,
	{
		head = "Amalric Coif +1",
		waist = "Gishdubar Sash"
	})

	sets.midcast['Blue Magic']['Occultation'] = set_combine(sets.midcast['Blue Magic'].SkillBasedBuff,
	{
		ammo = "Sapience Orb",
		neck = "Incanter's Torque",
		hands = "Hashishin Bazubands +2", ring1 = "Mephitas's Ring +1",
		feet = "Carmine Greaves +1"
	})

	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast['Blue Magic'].Buff,
	{
		head = "Telchine Cap", neck = "Incanter's Torque", ear1 = "Andoaa Earring",
		body = "Telchine Chas.", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Fi Follet Cape +1", legs = "Carmine Cuisses +1"
	})

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], { head = "Amalric Coif +1" })
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], { waist = "Siegel Sash" })

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], { head = "Carmine Mask +1", legs = "Shedir Seraweels" })

	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], { head = "Carmine Mask +1" })

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
	{
		head = "Amalric Coif +1",
		hands = "Regal Cuffs",
		waist = "Emphatikos Rope", legs = "Shedir Seraweels"
	})

	-- Sets to return to when not performing an action.

	sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = { hands = "Assim. Bazu. +2" }

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle =
	{
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Warder's Charm +1", ear1 = "Eabani Earring", ear2 = "Etiolation Earring",
		body = "Hashishin Mintan +3", hands = "Nyame Gauntlets", ring1 = "Stikini Ring +1", ring2 = "Defending Ring",
		back = gear.Rosmerta.TP, waist = "Flume Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.idle.Evasion =
	{
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Bathy Choker +1", ear1 = "Infused Earring", ear2 = "Eabani Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Stikini Ring +1", ring2 = "Defending Ring",
		back = gear.Rosmerta.Evasion, waist = "Kasiri Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.Kiting = { ring1 = "Shneddick Ring", legs = "Carmine Cuisses +1" }

	-- Extra Melee sets.  Apply these on top of melee sets.
	sets.Knockback = {}
	sets.MP = { waist = "Flume Belt +1", ear1 = "Suppanomimi", ear2 = "Ethereal Earring" }
    sets.MP_Knockback = {}
	sets.SuppaBrutal = {}
	sets.DWEarrings = {}
	sets.DWMax = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Weapons sets
	sets.weapons.Naegling = { main = "Naegling", sub = "Thibron" }
	sets.weapons.NaeglingAcc = { main = "Naegling", sub = "Zantetsuken" }
	sets.weapons.Maxentius = { main = "Maxentius", sub = "Thibron" }
	sets.weapons.MaxentiusAcc = { main = "Maxentius", sub = "Zantetsuken" }
	sets.weapons.Magic = { main = "Bunzi's Rod", sub = "Maxentius" }

	-- Engaged sets

	sets.engaged =
	{
		ammo = "Coiste Bodhar",
		head = "Adhemar Bonnet +1", neck = "Mirage Stole +2", ear1 = "Brutal Earring", ear2 = "Suppanomimi",
		body = gear.adhemar.body.b, hands = gear.adhemar.hands.a, ring1 = "Epona's Ring", ring2 = "Hetairoi Ring",
		back = gear.Rosmerta.TP, waist = "Windbuffet Belt +1", legs = "Samnuha Tights", feet = gear.herculean_ta_feet
	}
	sets.engaged.Acc = set_combine(sets.engaged, {})

	sets.engaged.DT =
	{
		ammo = "Coiste Bodhar",
		head = "Malignance Chapeau", neck = "Mirage Stole +2", ear1 = "Eabani Earring", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Epona's Ring", ring2 = "Defending Ring",
		back = gear.Rosmerta.TP, waist = "Reiki Yotai", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {})

	sets.Self_Healing = { waist = "Gishdubar Sash" }
	sets.Cure_Received = { waist = "Gishdubar Sash" }
	sets.Self_Refresh = { waist = "Gishdubar Sash" }
	sets.Phalanx_Received = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(6, 2)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 011')
end

autows_list = {['Tizbron']='Expiacion',['Tizalmace']='Expiacion',['Almace']='Chant Du Cygne',['MeleeClubs']='Realmrazer',
     ['HybridWeapons']='Sanguine Blade',['Naegbron']='Savage Blade',['Naegmace']='Savage Blade'}