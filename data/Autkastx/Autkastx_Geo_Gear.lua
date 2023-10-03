function user_job_setup()

	-- Options: Override default values
    state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal', 'DW')
	state.CastingMode:options('Normal')
    state.IdleMode:options('Normal','PDT')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'Maxentius', 'Daybreak', 'DualMaxentius', 'DualDaybreak')

	gear.Nantosuelta =
	{
		MAB = { name = "Nantosuelta's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', 'Phys. dmg. taken-10%' } },
		Pet = { name = "Nantosuelta's Cape", augments = {'MP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Pet: "Regen"+10', 'Pet: "Regen"+5' } },
		TP = { name = "Nantosuelta's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Store TP"+10', 'Damage taken-5%' } },
	}
	
	autoindi = "Haste"
	autogeo = "Frailty"
	
	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` input /ja "Full Circle" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^backspace input /ja "Entrust" <me>')
	send_command('bind !backspace input /ja "Life Cycle" <me>')
	send_command('bind @backspace input /ma "Sleep II" <t>')
	send_command('bind ^delete input /ma "Aspir III" <t>')
	send_command('bind @delete input /ma "Sleep" <t>')
	
	indi_duration = 290
	
	select_default_macro_book()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = { body = "Bagua Tunic +3" }
	sets.precast.JA['Life Cycle'] = { body = "Geo. Tunic +1", back = gear.Nantosuelta.Pet }
	sets.precast.JA['Radial Arcana'] = { feet = "Bagua Sandals +3" }
	sets.precast.JA['Mending Halation'] = { legs = "Bagua Pants +3" }
	sets.precast.JA['Full Circle'] = { head = "Azimuth Hood +2", hands = "Bagua Mitaines +3" }
	sets.precast.JA['Concentric Pulse'] = { head = "Bagua Galero +3" }
	
	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {}
	
	-- Relic hat for Blaze of Glory HP increase.
	sets.buff['Blaze of Glory'] = {}
	
	-- Fast cast sets for spells

	sets.precast.FC =
	{
		main = "Cath Palug Hammer", sub = "Genmei Shield", range = "Dunna",
		head = "Merlinic Hood", neck = "Twilight Torque", ear1 = "Loquac. Earring", ear2 = "Malignance Earring",
		body = "Agwu's Robe", hands = "Agwu's Gages", ring1 = "Kishar Ring", ring2 = "Medada's Ring",
		back = "Perimede Cape", waist = "Witful Belt", legs = "Geo. Pants +1", feet = gear.amalric.feet.a
	}

	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {})
	
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, { hands = "Bagua Mitaines +3" })

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC.Impact = set_combine(sets.precast.FC,
	{
		head = empty,
		body = "Twilight Cloak",
	})

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Ammurapi Shield" })
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Ishvara Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Shukuyu Ring", ring2 = "Rufescent Ring",
		back = "Nantosuelta's Cape", waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets",
	}

	sets.precast.WS['Seraph Strike'] =
	{
		head = "Nyame Helm", neck = "Sibyl Scarf", ear1 = "Regal Earring", ear2 = "Friomisi Earring",
		body = "Nyame Mail", hands = "Jhakri Cuffs +2", ring1 = "Metamor. Ring +1", ring2 = "Freke Ring",
		back = gear.Nantosuelta.MAB, waist = "Eschan Stone", legs = "Merlinic Shalwar", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Shining Strike'] = sets.precast.WS['Seraph Strike']
	sets.precast.WS['Flash Nova'] = sets.precast.WS['Seraph Strike']

	sets.precast.WS['Judgment'] =
	{
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Ishvara Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Shukuyu Ring", ring2 = "Rufescent Ring",
		back = gear.Nantosuelta.MAB, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Black Halo'] =
	{
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Regal Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Rufescent Ring",
		back = gear.Nantosuelta.MAB, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Realmrazer'] =
	{
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Regal Earring", ear2 = "Telos Earring",
		body = "Nyame Mail", hands = "Gazu Bracelets +1", ring1 = "Metamor. Ring +1", ring2 = "Rufescent Ring",
		back = gear.Nantosuelta.MAB, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Hexa Strike'] =
	{
		head = "Blistering Sallet +1", neck = "Fotia Gorget", ear1 = "Regal Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Gazu Bracelets +1", ring1 = "Shukuyu Ring", ring2 = "Rufescent Ring",
		back = gear.Nantosuelta.MAB, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Exudiation'] =
	{
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Ishvara Earring", ear2 = "Telos Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Freke Ring",
		back = gear.Nantosuelta.MAB, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Rock Crusher'] =
	{
		head = "Nyame Helm", neck = "Quanpur Necklace", ear1 = "Regal Earring", ear2 = "Friomisi Earring",
		body = "Nyame Mail", hands = "Jhakri Cuffs +2", ring1 = "Metamor. Ring +1", ring2 = "Freke Ring",
		back = gear.Nantosuelta.MAB, waist = "Eschan Stone", legs = "Merlinic Shalwar", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Earth Crusher'] = sets.precast.WS['Rock Crusher']

	sets.precast.WS['Shell Crusher'] =
	{
		head = "Nyame Helm", neck = "Sanctity Necklace", ear1 = "Crepuscular Earring", ear2 = "Digni. Earring",
		body = "Nyame Mail", hands = "Gazu Bracelets +1", ring1 = "Metamor. Ring +1", ring2 = "Etana Ring",
		back = gear.Nantosuelta.MAB, waist = "Eschan Stone", legs = "Agwu's Slops", feet = "Agwu's Pigaches"
	}

	sets.precast.WS['Spirit Taker'] =
	{
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Crepuscular Earring", ear2 = "Telos Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Freke Ring",
		back = gear.Nantosuelta.MAB, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Retribution'] = sets.precast.WS['Spirit Taker']
	sets.precast.WS['Shattersoul'] = sets.precast.WS['Spirit Taker']

	sets.precast.WS['Cataclysm'] =
	{
		head = "Pixie Hairpin +1", neck = "Sibyl Scarf", ear1 = "Regal Earring", ear2 = "Friomisi Earring",
		body = "Nyame Mail", hands = "Jhakri Cuffs +2", ring1 = "Archon Ring", ring2 = "Freke Ring",
		back = gear.Nantosuelta.MAB, waist = "Eschan Stone", legs = "Merlinic Shalwar", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Aeolian Edge'] =
	{
		head = "Nyame Helm", neck = "Sibyl Scarf", ear1 = "Regal Earring", ear2 = "Friomisi Earring",
		body = "Nyame Mail", hands = "Jhakri Cuffs +2", ring1 = "Metamor. Ring +1", ring2 = "Freke Ring",
		back = gear.Nantosuelta.MAB, waist = "Eschan Stone", legs = "Merlinic Shalwar", feet = "Nyame Sollerets"
	}

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = set_combine(sets.precast.FC,
	{
		ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
	})

	sets.midcast.Geomancy = set_combine(sets.midcast.FastRecast,
	{
		main = "Solstice", sub = "Genmei Shield", range = "Dunna",
		head = "Bagua Galero +3", neck = "Bagua Charm +2", ear1 = "Calamitous Earring", ear2 = "Etiolation Earring",
		body = "Vedic Coat", hands = "Geo. Mitaines +2",
		back = "Fi Follet Cape +1", waist = "Austerity Belt +1", legs = "Vanya Slops", feet = "Telchine Pigaches"
	})

	--Extra Indi duration as long as you can keep your 900 skill cap.
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy,
	{
		back = "Lifestream Cape", legs = "Bagua Pants +3", feet = "Azimuth Gaiters +2"
	})

	sets.midcast.Cure =
	{
		main = "Raetic Rod +1", sub = "Genmei Shield",
		head = "Vanya Hood", neck = "Incanter's Torque", ear1 = "Meili Earring", ear2 = "Malignance Earring",
		body = "Vedic Coat", hands = "Geo. Mitaines +2", ring1 = "Metamor. Ring +1", ring2 = "Mephitas's Ring +1",
		back = "Aurist's Cape +1", waist = "Luminary Sash", legs = "Vanya Slops", feet = "Vanya Clogs"
	}

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})

	sets.midcast.Cursna =
	{
		head = "Vanya Hood", neck = "Malison Medallion", ear1 = "Meili Earring", ear2 = "Malignance Earring",
		body = "Zendik Robe", hands = "Geo. Mitaines +2", ring1 = "Haoma's Ring", ring2 = "Haoma's Ring",
		back = "Oretania's Cape +1", waist = "Witful Belt", legs = "Geomancy Pants +1", feet = "Vanya Clogs"
	}
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})
	
	sets.midcast['Elemental Magic'] =
	{
		main = "Bunzi's Rod", sub = "Ammurapi Shield", ammo = "Ghastly Tathlum +1",
		head = "Azimuth Hood +2", neck = "Bagua Charm +2", ear1 = "Malignance Earring", ear2 = "Regal Earring",
		body = "Azimuth Coat +2", hands = "Azimuth Gloves +2", ring1 = "Medada's Ring", ring2 = "Freke Ring",
		back = gear.Nantosuelta.MAB, waist = "Eschan Stone", legs = "Azimuth Tights +2", feet = "Azimuth Gaiters +2"
	}

	sets.midcast['Dark Magic'] = set_combine(sets.midcast['Elemental Magic'],
	{
		neck = "Erra Pendant",
		ring2 = "Stikini Ring +1",
	})

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'],
	{
		head = "Pixie Hairpin +1",
		ring1 = "Archon Ring", ring2 = "Evanescence Ring",
	})
	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast['Enfeebling Magic'] =
	{
		main = "Bunzi's Rod", sub = "Ammurapi Shield",
		head = "Geomancy Galero +1", neck = "Bagua Charm +2", ear1 = "Regal Earring", ear2 = "Malignance Earring",
		body = "Geomancy Tunic +1", hands = "Agwu's Gages", ring1 = "Kishar Ring", ring2 = "Metamor. Ring +1",
		back = gear.Nantosuelta.MAB, waist = "Luminary Sash", legs = "Geomancy Pants +1", feet = "Geomancy Sandals +1"
	}

	sets.midcast.Stun = set_combine(sets.midcast['Enfeebling Magic'],
	{
		neck = "Erra Pendant",
		body = "Bagua Tunic +3", hands = "Agwu's Gages",
		waist = "Witful Belt", feet = "Agwu's Pigaches"
	})

	sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Amalric Coif +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Zendik Robe",hands="Amalric Gages +1",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}
		
	sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'],
	{
		head = empty,
		body = "Twilight Cloak", hands = "Geo. Mitaines +2", ring1 = "Stikini Ring +1",
	})

	sets.midcast.Dispel = set_combine(sets.midcast['Enfeebling Magic'],
	{
		main = "Daybreak",
		head="Amalric Coif +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Zendik Robe",hands="Amalric Gages +1",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet
	})

	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, { main = "Daybreak", sub = "Ammurapi Shield" })

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif +1",ear2="Malignance Earring",waist="Acuity Belt +1"})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif +1",ear2="Malignance Earring",waist="Acuity Belt +1"})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif +1",ear2="Malignance Earring",waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif +1",ear2="Malignance Earring",waist="Acuity Belt +1"})
	
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {range=empty,ring1="Stikini Ring +1"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {range=empty,ring1="Stikini Ring +1"})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {ring1="Stikini Ring +1"})
		
	sets.midcast['Enhancing Magic'] =
	{
		main = "Gada", sub = "Ammurapi Shield", range = "Dunna",
		head = "Telchine Cap", neck = "Incanter's Torque", ear1 = "Mimir Earring", ear2 = "Andoaa Earring",
		body = "Telchine Chas.", hands = gear.telchine.hands.enhancing, ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Fi Follet Cape +1", waist = "Embla Sash", legs = "Telchine Braconi", feet = "Telchine Pigaches"
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],
	{
		neck = "Twilight Torque", ear1 = "Lugalbanda Earring", ear2 = "Etiolation Earring",
		ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		legs = "Shedir Seraweels",
	})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'].Stoneskin,
	{
		head = "Amalric Coif +1", neck = "Twilight Torque", ear1 = "Lugalbanda Earring", ear2 = "Etiolation Earring",
		ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = "Grapevine Cape", waist = "Gishdubar Sash",
	})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
	{
		main = "Vadose Rod",
		head = "Amalric Coif +1",
		hands = "Regal Cuffs",
		waist = "Emphatikos Rope", legs = "Shedir Seraweels"
	})

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'],
	{
		head = "Befouled Crown",
		waist = "Olympus Sash", legs = "Shedir Seraweels", feet = "Regal Pumps +1"
	})

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Malignance Earring",waist="Sekhmet Corset"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Malignance Earring",waist="Sekhmet Corset"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Malignance Earring",waist="Sekhmet Corset"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Malignance Earring",waist="Sekhmet Corset"})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------
	-- Idle sets
	sets.idle =
	{
		main = "Daybreak", sub = "Genmei Shield", ammo = "Staunch Tathlum +1",
		head = "Agwu's Cap", neck = "Warder's Charm +1", ear1 = "Lugalbanda Earring", ear2 = "Etiolation Earring",
		body = "Azimuth Coat +2", hands = "Agwu's Gages", ring1 = "Stikini Ring +1", ring2 = "Defending Ring",
		back = "Lifestream Cape", waist = "Carrier's Sash", legs = "Agwu's Slops", feet = "Geo. Sandals +1"
	}

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = set_combine(sets.idle,
	{
		main = "Solstice", range = "Dunna", ammo = empty,
		head = "Azimuth Hood +2", neck = "Bagua Charm +2",
		body = "Azimuth Coat +2", hands = "Geo. Mitaines +2", ring1 = "Gelatinous Ring +1",
		back = gear.Nantosuelta.Pet, waist = "Isa Belt", feet = "Bagua Sandals +3"
	})

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Indi = set_combine(sets.idle, {})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})

	sets.Kiting = { feet = "Geo. Sandals +1" }
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged =
	{
		head = "Blistering Sallet +1", neck = "Combatant's Torque", ear1 = "Crep. Earring", ear2 = "Telos Earring",
		body = "Nyame Mail", hands = "Gazu Bracelets +1", ring1 = "Chirich Ring +1", ring2 = "Chirich Ring +1",
		back = gear.Nantosuelta.TP, waist = "Windbuffet Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.engaged.DW = set_combine(sets.engaged,
	{
		ear1 = "Suppanomimi", ear2 = "Eabani Earring",
	})

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst =
	{
		main = "Bunzi's Rod", sub = "Ammurapi Shield",
		head = "Ea Hat +1", neck = "Bagua Charm +2",
		body = "Ea Houppe. +1", ring1 = "Mujin Band", ring2 = "Metamor. Ring +1",
		legs = "Ea Slops +1", feet = "Agwu's Pigaches"
	}

	sets.buff.Sublimation = { waist = "Embla Sash" }
	sets.buff.DTSublimation = { waist = "Embla Sash" }
	
	-- Weapons sets
	sets.weapons.Maxentius = { main = "Maxentius", sub = "Genmei Shield" }
	sets.weapons.Daybreak = { main = "Daybreak", sub = "Genmei Shield" }
	sets.weapons.DualMaxentius = { main = "Maxentius", sub = "Cath Palug Hammer" }
	sets.weapons.DualDaybreak = { main = "Daybreak", sub = "Cath Palug Hammer" }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(4, 10)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 012')
end