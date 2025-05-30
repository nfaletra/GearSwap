function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal', 'DT')
	state.WeaponskillMode:options('Match', 'PDL', 'Acc', 'Proc')
	state.AutoBuffMode:options('Off','Auto','AutoMelee')
	state.CastingMode:options('Normal','Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'Refresh')
    state.PhysicalDefenseMode:options('PDT','NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'DualSavage', 'DualSavageAcc', 'DualSeraph', 'DualSanguine', 'DualExcalibur', 'DualClubs', 'DualClubsAcc', 'DualTauret', 'DualAeolian', 'DualEnspell', 'DualProc', 'Naegling', 'Croc', 'Excalibur', 'Maxentius')
	
	gear.Sucellos =
	{
		STR_WSD = { name = "Sucellos's Cape", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Damage taken-5%' } },
		MND_WSD = { name = "Sucellos's Cape", augments = { 'MND+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'MND+10', 'Weapon skill damage +10%', 'Damage taken-5%' } },
		MAB = { name = "Sucellos's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', 'Damage taken-5%' } }
	}

		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` input /ja "Accession" <me>')
	send_command('bind ^backspace input /ja "Saboteur" <me>')
	send_command('bind !backspace input /ja "Spontaneity" <t>')
	send_command('bind @backspace input /ja "Composure" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind != input /ja "Penury" <me>')
	send_command('bind @= input /ja "Parsimony" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise" <me>')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c weapons Default;gs c set unlockweapons false')
	send_command('bind ^q gs c set weapons dualenspell;gs c set unlockweapons true')
	send_command('bind !q gs c set skipprocweapons false;gs c set weapons DualProcDaggers;gs c set weaponskillmode proc')
	
	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = { body = "Viti. Tabard +3" }
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = 
	{
		main = "Crocea Mors", sub = "Theulliac Ecu +1", ammo = "Impatiens",
		head = "Atrophy Chapeau +3", neck = "Voltsurge Torque", ear1 = "Malignance Earring", ear2 = "Lethargy Earring +1",
		body = "Viti. Tabard +3", hands = "Leyline Gloves", ring1 = "Lebeche Ring", ring2 = "Medada's Ring",
		back = "Perimede Cape", waist = "Witful Belt", legs = "Kaykaus Tights +1", feet = "Carmine Greaves +1"
	}

	sets.precast.FC.Cure = set_combine(sets.precast.FC,
	{
		main = "Sakpata's Sword",
	})

	sets.precast.FC.Impact = set_combine(sets.precast.FC,
	{
		head = empty, neck = "Voltsurge Torque",
		body = "Crepuscular Cloak", hands = "Leyline Gloves"
	})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak" })

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		ammo = "Oshasha's Treatise",
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Moonshade Earring", ear2 = "Leth. Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Shukuyu Ring", ring2 = "Epaminondas's Ring",
		back = gear.Sucellos.STR_WSD, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Leth. Houseaux +3"
	}
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {})

	sets.precast.WS['Knights of Round'] =
	{
		ammo = "Coiste Bodhar",
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Sherida Earring", ear2 = "Ishvara Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Sroda Ring", ring2 = "Epaminondas's Ring",
		back = gear.Sucellos.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Leth. Houseaux +3"
	}
	sets.precast.WS['Knights of Round'].PDL = set_combine(sets.precast.WS['Knights of Round'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Fotia Gorget",
		hands = "Malignance Gloves"
	})

	sets.precast.WS.Proc =
	{
		ammo = "Hasty Pinion +1",
		head = "Malignance Chapeau", neck = "Combatant's Torque", ear1 = "Mache Earring +1", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Ramuh Ring +1", ring2 = "Ramuh Ring +1",
		back = "Null Shawl", waist = "Olseni Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Savage Blade'] =
	{
		ammo = "Coiste Bodhar",
		head = "Viti. Chapeau +3", neck = "Rep. Plat. Medal", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Sroda Ring", ring2 = "Epaminondas's Ring",
		back = gear.Sucellos.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Leth. Houseaux +3"
	}
	sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS['Savage Blade'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Dls. Torque +2", ear1 = "Ishvara Earring",
		hands = "Malignance Gloves",
	})

	sets.precast.WS['Death Blossom'] =
	{
		ammo = "Coiste Bodhar",
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Sherida Earring", ear2 = "Regal Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Sroda Ring", ring2 = "Shukuyu Ring",
		back = gear.Sucellos.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Leth. Houseaux +3"
	}
	sets.precast.WS['Death Blossom'] = set_combine(sets.precast.WS['Death Blossom'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Dls. Torque +2",
		body = "Bunzi's Robe", hands = "Malignance Gloves", ring2 = "Metamor. Ring +1",
	})

	sets.precast.WS['Chant du Cygne'] =
	{
		ammo = "Yetshila +1",
		head = "Blistering Sallet +1", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Mache Earring +1",
		body = "Agony Jerkin +1", hands = "Nyame Gauntlets", ring1 = "Ilabrat Ring", ring2 = "Begrudging Ring",
		back = gear.Sucellos.STR_WSD, waist = "Fotia Belt", legs = "Zoar Subligar +1", feet = "Thereoid Greaves"
	}
	sets.precast.WS['Chant du Cygne'].PDL = set_combine(sets.precast.WS['Chant du Cygne'],
	{
		body = "Malignance Tabard", hands = "Malignance Gloves",
	})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS,
	{
		head = "Viti. Chapeau +3", ear2 = "Brutal Earring",
		body = "Ayanmo Corazza +2", hands = "Bunzi's Gloves", ring1 = "Epaminondas's Ring", ring2 = "Freke Ring",
		legs = "Vitiation Tights +3"
	})
	sets.precast.WS['Requiescat'].PDL = set_combine(sets.precast.WS['Requiescat'],
	{
		ammo = "Crepuscular Pebble",
		head = "Malignance Chapeau",
		body = "Bunzi's Robe", hands = "Malignance Gloves",
		legs = "Malignance Tights", feet = "Malignance Boots"
	})

	sets.precast.WS['Sanguine Blade'] =
	{
		ammo = "Sroda Tathlum",
		head = "Pixie Hairpin +1", neck = "Dls. Torque +2", ear1 = "Regal Earring", ear2 = "Malignance Earring",
		body = "Nyame Mail", hands = "Leth. Ganth. +3", ring1 = "Archon Ring", ring2 = "Epaminondas's Ring",
		back = gear.Sucellos.MND_WSD, waist = "Orpheus's Sash", legs = "Leth. Fuseau +3", feet = "Leth. Houseaux +3"
	}

	sets.precast.WS['Red Lotus Blade'] =
	{
		ammo = "Sroda Tathlum",
		head = "Leth. Chappel +3", neck = "Sibyl Scarf", ear1 = "Moonshade Earring", ear2 = "Malignance Earring",
		body = "Nyame Mail", hands = "Leth. Ganth. +3", ring1 = "Freke Ring", ring2 = "Epaminondas's Ring",
		back = gear.Sucellos.MND_WSD, waist = "Orpheus's Sash", legs = "Nyame Mail", feet = "Leth. Houseaux +3"
	}

	sets.precast.WS['Burning Blade'] = {}

	sets.precast.WS['Seraph Blade'] =
	{
		ammo = "Sroda Tathlum",
		head = "Leth. Chappel +3", neck = "Fotia Gorget", ear1 = "Moonshade Earring", ear2 = "Malignance Earring",
		body = "Nyame Mail", hands = "Leth. Ganth. +3", ring1 = "Medada's Ring", ring2 = "Epaminondas's Ring",
		back = gear.Sucellos.MND_WSD, waist = "Orpheus's Sash", legs = "Nyame Flanchard", feet = "Leth. Houseaux +3"
	}

	sets.precast.WS['Shining Blade'] = {}

	sets.precast.WS['Flat Blade'] = set_combine(sets.precast.WS,
	{
		ammo = "Pemphredo Tathlum",
		head = "Malignance Chapeau", neck = "Dls. Torque +2", ear1 = "Regal Earring", ear2 = "Malignance Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Medada's Ring", ring2 = "Metamor. Ring +1",
		back = "Aurist's Cape +1", waist = "Acuity Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	})

	sets.precast.WS['Evisceration'] =
	{
		ammo = "Yetshila +1",
		head = "Blistering Sallet +1", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Mache Earring +1",
		body = "Agony Jerkin +1", hands = "Volte Mittens", ring1 = "Ilabrat Ring", ring2 = "Begrudging Ring",
		back = gear.Sucellos.STR_WSD, waist = "Fotia Belt", legs = "Zoar Subligar +1", feet = "Thereoid Greaves"
	}
	sets.precast.WS['Evisceration'].PDL = set_combine(sets.precast.WS['Evisceration'],
	{
		body = "Malignance Tabard", hands = "Malignance Gloves",
	})

	sets.precast.WS['Aeolian Edge'] =
	{
		ammo = "Sroda Tathlum",
		head = "Leth. Chappel +3", neck = "Fotia Gorget", ear1 = "Moonshade Earring", ear2 = "Malignance Earring",
		body = "Nyame Mail", hands = "Leth. Ganth. +3", ring1 = "Medada's Ring", ring2 = "Epaminondas's Ring",
		back = gear.Sucellos.STR_WSD, waist = "Orpheus's Sash", legs = "Leth. Fuseau +3", feet = "Leth. Houseaux +3"
	}

	sets.precast.WS['Black Halo'] =
	{
		ammo = "Coiste Bodhar",
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Moonshade Earring", ear2 = "Regal Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Epaminondas's Ring",
		back = gear.Sucellos.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Leth. Houseaux +3"
	}
	sets.precast.WS['Black Halo'].PDL = set_combine(sets.precast.WS['Black Halo'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Dls. Torque +2",
		ring1 = "Sroda Ring",
	})
	sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS['Black Halo'],
	{
		ammo = "Oshasa's Treatise",
		head = "Leth. Chappel +3", neck = "Fotia Gorget",
		body = "Lethargy Sayon +3", hands = "Atrophy Gloves +3",
		waist = "Fotia Belt", legs = "Leth. Fuseau +3", feet = "Leth. Houseaux +3"
	})

	sets.precast.WS['True Strike'] = set_combine(sets.precast.WS,
	{
		neck = "Rep. Plat. Medal", ear1 = "Sherida Earring",
		waist = "Sailfi Belt +1"
	})
	sets.precast.WS['True Strike'].PDL = set_combine(sets.precast.WS['True Strike'],
	{
		ammo = "Crepuscular Pebble",
		body = "Bunzi's Robe", hands = "Malignance Gloves"
	})

	sets.precast.WS['Shining Strike'] = set_combine(sets.precast.WS,
	{
		ammo = "Sroda Tathlum",
		neck = "Dls. Torque +2", ear2 = "Malignance Earring",
		hands = "Jhakri Cuffs +2", ring1 = "Freke Ring", ring2 = "Medada's Ring",
		waist = "Eschan Stone", legs = "Leth. Fuseau +3", feet = "Leth. Houseaux +3"
	})

	sets.precast.WS['Seraph Strike'] = set_combine(sets.precast.WS,
	{
		ammo = "Sroda Tathlum",
		neck = "Dls. Torque +2", ear2 = "Malignance Earring",
		hands = "Jhakri Cuffs +2", ring1 = "Freke Ring", ring2 = "Medada's Ring",
		waist = "Eschan Stone", legs = "Leth. Fuseau +3", feet = "Leth. Houseaux +3"
	})

	sets.precast.WS['Flaming Arrow'] = set_combine(sets.precast.WS,
	{
		neck = "Sanctity Necklace", ear1 = "Friomisi Earring", ear2 = "Telos Earring",
		ring1 = "Epaminondas's Ring", ring2 = "Medada's Ring",
		waist = "Eschan Stone"
	})

	sets.precast.WS['Empyreal Arrow'] = set_combine(sets.precast.WS,
	{
		head = "Malignance Chapeau", neck = "Combatant's Torque", ear1 = "Sherida Earring", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Ilabrat Ring", ring2 = "Crepuscular Ring",
		waist = "Eschan Stone", legs = "Malignance Tights", feet = "Malignance Boots"
	})
	sets.precast.WS['Empyreal Arrow'].PDL = set_combine(sets.precast.WS['Empyreal Arrow'],
	{
		head = "Nyame Helm",
		body = "Nyame Mail",
		legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	})

	sets.TreasureHunter = set_combine(sets.TreasureHunter,
	{
		ammo = "Per. Lucky Egg",
		hands = "Volte Bracers",
		waist = "Chaac Belt", legs = "Volte Hose",
	})

	-- Midcast Sets
	-- Gear for Magic Burst mode.
	sets.MagicBurst =
	{
		main = "Bunzi's Rod", sub = "Ammurapi Shield", ammo = "Ghastly Tathlum +1",
		head = "Ea Hat +1", neck = "Sibyl Scarf", ear1 = "Malignance Earring", ear2 = "Regal Earring",
		body = "Ea Houppe. +1", hands = "Bunzi's Gloves", ring1 = "Freke Ring", ring2 = "Metamor. Ring +1",
		back = gear.Sucellos.MAB, waist = "Acuity Belt +1", legs = "Leth. Fuseau +3", feet = "Leth. Houseaux +3"
	}

	sets.midcast.FastRecast =
	{
		head = "Atrophy Chapeau +3", neck = "Voltsurge Torque", ear1 = "Malignance Earring", ear2 = "Leth. Earring +1",
		body = "Vitiation Tabard +3", hands = "Regal Cuffs", ring1 = "Mephitas's Ring +1", ring2 = "Medada's Ring",
		waist = "Witful Belt", feet = "Carmine Greaves +1"
	}

	sets.midcast.Cure =
	{
		main = "Daybreak",ammo = "Staunch Tathlum +1",
		head = "Kaykaus Mitra +1", neck = "Incanter's Torque", ear1 = "Odnowa Earring +1", ear2 = "Magnetic Earring",
		body = "Bunzi's Robe", hands = "Kaykaus Cuffs +1", ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = "Fi Follet Cape +1", waist = "Shinjutsu-No-Obi +1", legs = "Kaykaus Tights +1", feet = "Kaykaus Boots +1"
	}

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {})

		--Cureset for if it's not light weather but is light day.
	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {})

	sets.midcast.Cursna =
	{
		range = empty, ammo = "Staunch Tathlum +1",
		head = "Kaykaus Mitra +1", neck = "Debilis Medallion", ear1 = "Calamitous Earring", ear2 = "Mendi. Earring",
		body = "Viti. Tabard +3", hands = "Hieros Mittens", ring1 = "Haoma's Ring", ring2 = "Menelaus's Ring",
		back = "Oretan. Cape +1", waist = "Bishop's Sash", legs = "Vanya Slops", feet = "Vanya Clogs"
	}

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
		
	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = { neck = "Phalaina Locket", ring2 = "Kunaji Ring", waist = "Gishdubar Sash" }
	sets.Cure_Received = { neck = "Phalaina Locket", ring2 = "Kunaji Ring", waist = "Gishdubar Sash" }
	sets.Self_Refresh = { back = "Grapevine Cape", waist = "Gishdubar Sash" }

	sets.midcast['Enhancing Magic'] =
	{
		main = "Colada", sub = "Ammurapi Shield", ammo = "Staunch Tathlum +1",
		head = "Telchine Cap", neck = "Dls. Torque +2", ear1 = "Odnowa Earring +1", ear2 = "Leth. Earring +1",
		body = "Telchine Chas.", hands = "Atrophy Gloves +3", ring1 = "Defending Ring", ring2 = "Mephitas's Ring +1",
		back = "Ghostfyre Cape", waist = "Embla Sash", legs = "Telchine Braconi", feet = "Telchine Pigaches"
	}

	sets.buff.ComposureOther = set_combine(sets.midcast['Enhancing Magic'],
	{
		ear1 = "Malignance Earring",
		ring1 = "Kishar Ring", ring2 = "Medada's Ring"
	})

	-- Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	-- Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.EnhancingSkill =
	{
		main = "Pukulatmuj +1", sub = "Forfend +1",
		head = "Befouled Crown", neck = "Incanter's Torque", ear1 = "Andoaa Earring", ear2 = "Mimir Earring",
		body = "Viti. Tabard +3", hands = "Viti. Gloves +3", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Ghostfyre Cape", waist = "Olympus Sash", legs = "Atrophy Tights +2", feet = "Leth. Houseaux +3"
	}

	sets.midcast.Refresh = set_combine(sets.midcast.FastRecast,
	{
		head = "Amalric Coif +1",
		body = "Atrophy Tabard +3", hands = "Atrophy Gloves +3",
		waist = "Gishdubar Sash", legs = "Leth. Fuseau +3"
	})
	sets.midcast.Aquaveil = set_combine(sets.midcast.FastRecast,
	{
		head = "Amalric Coif +1",
		hands = "Regal Cuffs",
		waist = "Emphatikos Rope", legs = "Shedir Seraweels",
	})

	sets.midcast.BarElement = set_combine(sets.EnhancingSkill,
	{
		head = "Telchine Cap", neck = "Dls. Torque +2",
		hands = "Atrophy Gloves +3",
		waist = "Embla Sash", legs = "Shedir Seraweels"
	})

	sets.midcast.Regen =
	{
		ammo = "Sapience Orb",
		main = "Bolelabunga",
		hands = "Atrophy Gloves +3"
	}

	sets.midcast.Temper = sets.EnhancingSkill
	sets.midcast.Temper.DW = set_combine(sets.midcast.Temper, {})
	sets.midcast.Enspell = sets.EnhancingSkill
	sets.midcast.Enspell.DW = set_combine(sets.midcast.Enspell, {})
	sets.midcast.BoostStat = sets.EnhancingSkill
	sets.midcast.Stoneskin =
	{
		neck = "Nodens Gorget", ear1 = "Earthcry Earring",
		hands = "Stone Mufflers", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		waist = "Siegel Sash", legs = "Shedir Seraweels"
	}
	sets.midcast.Protect = { ring1 = "Sheltered Ring" }
	sets.midcast.Shell = { ring1 = "Sheltered Ring" }

	sets.midcast.Phalanx =
	{
		ammo = "Sapience Orb",
		main = "Sakpata's Sword", sub = "Sacro Bulwark"
	}

	-- Max MACC
	sets.midcast['Enfeebling Magic'] =
	{
		main = "Bunzi's Rod", sub = "Ammurapi Shield", ammo = "Regal Gem",
		head = "Viti. Chapeau +3", neck = "Dls. Torque +2", ear1 = "Regal Earring", ear2 = "Snotra Earring",
		body = "Atrophy Tabard +3", hands = "Leth. Ganth. +3", ring1 = "Metamor. Ring +1", ring2 = "Stikini Ring +1",
		back = "Null Shawl", waist = "Obstin. Sash", legs = "Leth. Fuseau +3", feet = "Vitiation Boots +3"
	}

	sets.midcast.Dispel = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, { main = "Daybreak" })
	sets.midcast['Frazzle II'] = set_combine(sets.midcast['Enfeebling Magic'], {})

	-- Enfeebling Skill/dMND/Potency
	sets.midcast['Frazzle III'] = set_combine(sets.midcast['Enfeebling Magic'],
	{
		range = empty, ammo = "Regal Gem",
		head = "Viti. Chapeau +3", ear1 = "Malignance Earring",
		body = "Lethargy Sayon +3", ring1 = "Stikini Ring +1",
		back = gear.Sucellos.MND_WSD
	})
	sets.midcast['Poison II'] = sets.midcast['Frazzle III']
	sets.midcast['Distract III'] = sets.midcast['Frazzle III']

	-- Potency
	sets.midcast.Slow = set_combine(sets.midcast['Enfeebling Magic'],
	{
		range = empty, ammo = "Regal Gem",
		body = "Lethargy Sayon +3",
		waist = "Luminary Sash",
		back = gear.Sucellos.MND_WSD
	})
	sets.midcast['Slow II'] = sets.midcast.Slow
	sets.midcast.Paralyze = sets.midcast.Slow
	sets.midcast['Paralyze II'] = sets.midcast.Slow
	sets.midcast.Addle = sets.midcast.Slow
	sets.midcast['Addle II'] = sets.midcast.Slow
	sets.midcast.Blind = sets.midcast.Slow
	sets.midcast['Blind II'] = sets.midcast.Slow

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'],
	{
		main = "Daybreak", range = empty, ammo = "Regal Gem",
		head = "Leth. Chappel +3",
		body = "Lethargy Sayon +3", ring1 = "Medada's Ring", ring2 = "Kishar Ring",
		feet = "Leth. Houseaux +3"
	})
	sets.midcast.Inundation = sets.midcast.Dia
	sets.midcast.Diaga = set_combine(sets.midcast.Dia, sets.TreasureHunter)

	sets.midcast.Bio = set_combine(sets.midcast['Enfeebing Magic'],
	{
		head = "Atrophy Chapeau +3", neck = "Erra Pendant", ear2 = "Mani Earring",
		body = "Shango Robe", hands = "Regal Cuffs", ring1 = "Evanescence Ring",
		back = "Perimede Cape", waist = "Acuity Belt +1",
	})

	-- Duration
	sets.midcast.Sleep = set_combine(sets.midcast['Enfeebling Magic'],
	{
		head = "Leth. Chappel +3", ear1 = "Malignance Earring",
		body = "Lethargy Sayon +3", ring1 = "Kishar Ring",
		feet = "Leth. Houseaux +3"
	})
	sets.midcast['Sleep II'] = sets.midcast.Sleep
	sets.midcast.Sleepga = sets.midcast.Sleep
	sets.midcast.Bind = sets.midcast.Sleep
	sets.midcast.Break = sets.midcast.Sleep
	sets.midcast.Gravity = sets.midcast.Sleep
	sets.midcast['Gravity II'] = sets.midcast.Sleep
	
	sets.midcast.Silence = sets.midcast.Sleep
	sets.midcast.Burn = sets.midcast.Sleep
	sets.midcast.Choke = sets.midcast.Sleep
	sets.midcast.Shock = sets.midcast.Sleep
	sets.midcast.Drown = sets.midcast.Sleep
	sets.midcast.Rasp = sets.midcast.Sleep
	sets.midcast.Frost = sets.midcast.Sleep

	sets.midcast.Impact =
	{
		main = "Bunzi's Rod", sub = "Ammurapi Shield", ammo = "Regal Gem",
		head = empty, neck = "Dls. Torque +2", ear1 = "Malignance Earring", ear2 = "Snotra Earring",
		body = "Crepuscular Cloak", hands = "Leth. Ganth. +3", ring1 = "Stikini Ring +1", ring2 = "Metamor. Ring +1",
		back = gear.Sucellos.MAB, waist = "Acuity Belt +1", legs = "Leth. Fuseau +3", feet = "Leth. Houseaux +3"
	}

	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

	sets.midcast['Elemental Magic'] =
	{
		main = "Bunzi's Rod", sub = "Ammurapi Shield", ammo = "Ghastly Tathlum +1",
		head = "Leth. Chappel +3", neck = "Sibyl Scarf", ear1 = "Malignance Earring", ear2 = "Regal Earring",
		body = "Lethargy Sayon +3", hands = "Leth. Ganth. +3", ring1 = "Freke Ring", ring2 = "Metamor. Ring +1",
		back = gear.Sucellos.MAB, waist = "Acuity Belt +1", legs = "Leth. Fuseau +3", feet = "Leth. Houseaux +3"
	}

	sets.midcast['Dark Magic'] = sets.midcast['Enfeebling Magic']

	sets.midcast.Drain =
	{
		main = "Rubicundity", sub = "Ammurapi Shield", ammo = "Regal Gem",
		head = "Pixie Hairpin +1", neck = "Erra Pendant", ear1 = "Malignance Earring", ear2 = "Digni. Earring",
		body = "Merlinic Jubbah", hands = gear.merlinic.hands.FC, ring1 = "Evanescence Ring", ring2 = "Archon Ring",
		back = gear.Sucellos.MAB, waist = "Fucho-no-obi", legs = "Merlinic Shalwar", feet = "Merlinic Crackows"
	}

	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Stun = set_combine(sets.midcast['Enfeebling Magic'], {})

	-- Sets for special buff conditions on spells.
		
	sets.buff.Saboteur = { hands = "Leth. Ganth. +3" }
	
	sets.HPDown =
	{
		head = "Pixie Hairpin +1", ear1 = "Mendicant's Earring", ear2 = "Evans Earring",
		body = "Jhakri Robe +2", hands = "Jhakri Cuffs +2", ring1 = "Stikini Ring +1", ring2 = "Mephitas's Ring +1",
		back = "Swith Cape +1", legs = "Shedir Seraweels", feet = "Jhakri Pigaches +2"
	}

	sets.HPCure =
	{
		head = "Gende. Caubeen +1", neck = "Unmoving Collar +1", ear1 = "Gifted Earring", ear2 = "Mendi. Earring",
		body = "Viti. Tabard +3", hands = "Kaykaus Cuffs +1", ring1 = "Gelatinous Ring +1", ring2 = "Meridian Ring",
		back = "Swith Cape +1", waist = "Luminary Sash", legs = "Carmine Cuisses +1", feet = "Kaykaus Boots +1"
	}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle =
	{
		main = "Sakpata's Sword", sub = "Sacro Bulwark", ammo = "Staunch Tathlum +1",
		head = "Viti. Chapeau +3", neck = "Warder's Charm +1", ear1 = "Etiolation Earring", ear2 = "Odnowa Earring +1",
		body = "Lethargy Sayon +3", hands = "Nyame Gauntlets", ring1 = "Stikini Ring +1", ring2 = "Mephitas's Ring +1",
		back = "Solemnity Cape", waist = "Carrier's Sash", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.idle.Refresh = set_combine(sets.idle, { ring2 = "Stikini Ring +1", feet = "Volte Gaiters" })

	sets.Kiting = { legs = "Carmine Cuisses +1" }

	-- Weapons sets
	--'None', 'Naegling', 'Croc', 'Excalibur', 'Maxentius', 'DualSavage', 'DualSavageAcc', 'DualSeraph', 'DualSanguine', 'DualExcalibur', 'DualClubs', 'DualClubsAcc',
	sets.weapons.Naegling = { main = "Naegling", sub = "Sacro Bulwark" }
	sets.weapons.Croc = { main = "Crocea Mors", sub = "Sacro Bulwark" }
	sets.weapons.Excalibur = { main = "Excalibur", sub = "Sacro Bulwark" }
	sets.weapons.Maxentius = { main = "Maxentius", sub = "Sacro Bulwark" }
	sets.weapons.DualSavage = { main = "Naegling", sub = "Thibron" }
	sets.weapons.DualSavageAcc = { main = "Naegling", sub = "Gleti's Knife" }
	sets.weapons.DualSeraph = { main = "Crocea Mors", sub = "Daybreak" }
	sets.weapons.DualSanguine = { main = "Crocea Mors", sub = "Bunzi's Rod" }
	sets.weapons.DualExcalibur = { main = "Excalibur", sub = "Gleti's Knife" }
	sets.weapons.DualClubs = { main = "Maxentius", sub = "Thibron" }
	sets.weapons.DualClubsAcc = { main = "Maxentius", sub = "Gleti's Knife" }
	sets.weapons.DualTauret = { main = "Tauret", sub = "Gleti's Knife" }
	sets.weapons.DualAeolian = { main = "Tauret", sub = "Thibron" }
	sets.weapons.DualEnspell = { main = "Crocea Mors", sub = "Ceremonial Dagger", range = "Ullr", ammo = "Beetle Arrow" }
	sets.weapons.DualProc = { main = "Twinned Blade", sub = "Ternion Dagger +1" }

	sets.buff.Sublimation = { waist = "Embla Sash" }
	sets.buff.DTSublimation = { waist = "Embla Sash" }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged =
	{
		ammo = "Coiste Bodhar",
		head = "Bunzi's Hat", neck = "Anu Torque", ear1 = "Sherida Earring", ear2 = "Dedition Earring",
		body = "Malignance Tabard", hands = "Bunzi's Gloves", ring1 = "Chirich Ring +1", ring2 = "Chirich Ring +1",
		back = "Null Shawl", waist = "Windbuffet Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	sets.engaged.DT = set_combine(sets.engaged,
	{
		neck = "Loricate Torque +1",
		ring2 = "Defending Ring"
	})

	sets.engaged.DW =
	{
		ammo = "Coiste Bodhar",
		head = "Bunzi's Hat", neck = "Anu Torque", ear1 = "Eabani Earring", ear2 = "Dedition Earring",
		body = "Malignance Tabard", hands = "Bunzi's Gloves", ring1 = "Chirich Ring +1", ring2 = "Chirich Ring +1",
		back = "Null Shawl", waist = "Reiki Yotai", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	sets.engaged.DW.DT = set_combine(sets.engaged.DW, { neck = "Loricate Torque +1", ring2 = "Defending Ring" })

	sets.engaged.DW.Haste30 = set_combine(sets.engaged.DW,
	{
		ear1 = "Suppanomimi",
		feet = "Taeon Boots"
	})
	sets.engaged.DW.DT.Haste30 = set_combine(sets.engaged.DW.Haste30, { neck = "Loricate Torque +1", ring2 = "Defending Ring" })

	sets.engaged.DualEnspell =
	{
		head = "Umuthi Hat", neck = "Dls. Torque +2",ear1 = "Suppanomimi", ear2 = "Digni. Earring",
		body = "Viti. Tabard +3", hands = "Aya. Manopolas +2", ring1 = "Chirich Ring +1", ring2 = "Chirich Ring +1",
		back = "Ghostfyre Cape", waist = "Orpheus's Sash", legs = "Viti. Tights +3", feet = "Malignance Boots"
	}
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	set_macro_page(3, 8)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 016')
end

autows_list = {['Naegling']='Savage Blade',['DualWeapons']='Savage Blade',['DualWeaponsAcc']='Savage Blade',['DualEvisceration']='Evisceration',['DualClubs']='Black Halo',['DualAeolian']='Aeolian Edge',['EnspellDW']='Sanguine Blade'}