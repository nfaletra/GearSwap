function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal', 'DT')
	state.WeaponskillMode:options('Match', 'PDL', 'Proc')
	state.AutoBuffMode:options('Off','Auto','AutoMelee')
	state.CastingMode:options('Normal','Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'Refresh')
    state.PhysicalDefenseMode:options('PDT','NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'Naegling', 'Croc', 'DualNaegling', 'DualNaeglingAcc', 'DualCroc', 'DualExcalibur', 'DualLightDamage', 'DualClubs', 'DualTauret', 'DualAeolian', 'EnspellOnly', 'EnspellDW', 'DualProc')
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = "Toro Cape"
	gear.obi_low_nuke_waist = "Sekhmet Corset"

	gear.obi_high_nuke_back = "Toro Cape"
	gear.obi_high_nuke_waist = "Refoccilation Stone"

	gear.Sucellos =
	{
		STP = { name = "Sucellos's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Store TP"+10', 'Damage taken-5%' } },
		WSD_STR = { name = "Sucellos's Cape", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Damage taken-5%' } }
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
	send_command('bind ^q gs c set weapons enspellonly;gs c set unlockweapons true')
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
		main = "Crocea Mors", sub = "Theullaic Ecu +1", ammo = "Impatiens",
		head = "Atrophy Chapeau +2", neck = "Sanctity Necklace", ear1 = "Malignance Earring", ear2 = "Lethargy Earring +1",
		body = "Viti. Tabard +3", hands = "Leyline Gloves", ring1 = "Lebeche Ring", ring2 = "Medada's Ring",
		back = "Perimede Cape", waist = "Witful Belt", legs = "Kaykaus Tights +1", feet = "Carmine Greaves +1"
	}

	sets.precast.FC.Cure = set_combine(sets.precast.FC,
	{
		main = "Sakpata's Sword",
	})

	sets.precast.FC.Impact = set_combine(sets.precast.FC,
	{
		head = empty, neck = "Orunmila's Torque",
		body = "Crepuscular Cloak", hands = "Leyline Gloves"
	})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak" })

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		ammo = "Coiste Bodhar",
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Moonshade Earring", ear2 = "Leth. Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Shukuyu Ring", ring2 = "Epaminondas's Ring",
		back = gear.Sucellos.WSD_STR, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {})

	sets.precast.WS['Knights of Round'] = set_combine(sets.precast.WS,
	{
		neck = "Rep. Plat. Medal", ear1 = "Ishvara Earring",
		waist = "Sailfi Belt +1"
	})
	sets.precast.WS['Knights of Round'].PDL = set_combine(sets.precast.WS['Knights of Round'],
	{
		ammo = "Crepuscular Pebble",
		body = "Bunzi's Robe", hands = "Malignance Gloves"
	})

	sets.precast.WS.Proc =
	{
		ammo = "Hasty Pinion +1",
		head = "Malignance Chapeau", neck = "Combatant's Torque", ear1 = "Mache Earring +1", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Ramuh Ring +1", ring2 = "Ramuh Ring +1",
		back = gear.Sucellos.STP, waist = "Olseni Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,
	{
		neck = "Rep. Plat. Medal",
		waist = "Sailfi Belt +1"
	})
	sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS['Savage Blade'],
	{
		ammo = "Crepuscular Pebble",
		body = "Bunzi's Robe", hands = "Malignance Gloves",
	})

	sets.precast.WS['Death Blossom'] = set_combine(sets.precast.WS,
	{
		neck = "Rep. Plat. Medal", ear1 = "Ishvara Earring",
		waist = "Sailfi Belt +1"
	})
	sets.precast.WS['Death Blossom'] = set_combine(sets.precast.WS['Death Blossom'],
	{
		ammo = "Crepuscular Pebble",
		body = "Bunzi's Robe", hands = "Malignance Gloves"
	})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS,
	{
		ammo = "Yetshila +1",
		head = "Blistering Sallet +1", ear1 = "Sherida Earring",
		body = "Lethargy Sayon +3", hands = "Malignance Gloves", ring1 = "Ilabrat Ring", ring2 = "Begrudging Ring",
		legs = "Zoar Subligar +1", feet = "Thereoid Greaves"
	})
	sets.precast.WS['Chant du Cygne'].PDL = set_combine(sets.precast.WS['Chant du Cygne'],
	{
		ammo = "Crepuscular Pebble",
		body = "Bunzi's Robe", hands = "Malignance Gloves",
		legs = "Malignance Tights", feet = "Malignance Boots"
	})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS,
	{
		head = "Viti. Chapeau +3", ear2 = "Brutal Earring",
		body = "Ayanmo Corazza +2", hands = "Bunzi's Hands", ring1 = "Rufescent Ring", ring2 = "Freke Ring",
		legs = "Vitiation Tights +3"
	})
	sets.precast.WS['Requiescat'].PDL = set_combine(sets.precast.WS['Requiescat'],
	{
		ammo = "Crepuscular Pebble",
		head = "Malignance Chapeau",
		body = "Bunzi's Robe", hands = "Malignance Gloves",
		legs = "Malignance Tights", feet = "Malignance Boots"
	})

	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS,
	{
		ammo = "Sroda Tathlum",
		head = "Pixie Hairpin +1", neck = "Sibyl Scarf", ear1 = "Regal Earring", ear2 = "Malignance Earring",
		hands = "Jhakri Cuffs +2", ring1 = "Archon Ring", ring2 = "Medada's Ring",
		waist = "Eschan Stone", legs = "Leth. Fuseau +3", feet = "Leth. Houseaux +3"
	})

	sets.precast.WS['Red Lotus Blade'] = set_combine(sets.precast.WS,
	{
		ammo = "Sroda Tathlum",
		neck = "Sibyl Scarf", ear1 = "Friomisi Earring", ear2 = "Crematio Earring",
		ring1 = "Freke Ring", ring2 = "Medada's Ring",
		waist = "Eschan Stone", legs = "Leth. Fuseau +3", feet = "Leth. Houseaux +3"
	})

	sets.precast.WS['Burning Blade'] = {}

	sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS,
	{
		ammo = "Sroda Tathlum",
		neck = "Dls. Torque +2", ear2 = "Moonshade Earring",
		hands = "Jhakri Cuffs +2", ring1 = "Freke Ring", ring2 = "Medada's Ring",
		waist = "Eschan Stone", legs = "Leth. Fuseau +3", feet = "Leth. Houseaux +3"
	})

	sets.precast.WS['Shining Blade'] = {}

	sets.precast.WS['Flat Blade'] = set_combine(sets.precast.WS,
	{
		ammo = "Pemphredo Tathlum",
		head = "Malignance Chapeau", neck = "Dls. Torque +2", ear1 = "Regal Earring", ear2 = "Malignance Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Rufescent Ring", ring2 = "Metamor. Ring +1",
		back = "Aurist's Cape +1", waist = "Acuity Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS,
	{
		ammo = "Yetshila +1",
		head = "Blistering Sallet +1", ear1 = "Sherida Earring +1",
		body = "Lethargy Sayon +3", hands = "Malignance Gloves", ring1 = "Ilabrat Ring", ring2 = "Begrudging Ring",
		legs = "Zoar Subligar +1", feet = "Thereoid Greaves"
	})
	sets.precast.WS['Evisceration'].PDL = set_combine(sets.precast.WS['Evisceration'],
	{
		ammo = "Crepuscular Pebble",
		body = "Malignance Tabard", hands = "Malignance Gloves",
		legs = "Malignance Tights", feet = "Malignance Boots"
	})

	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS,
	{
		ammo = "Sroda Tathlum",
		neck = "Sibyl Scarf", ear2 = "Malignance Earring",
		hands = "Jhakri Cuffs +2", ring1 = "Freke Ring", ring2 = "Medada's Ring",
		waist = "Eschan Stone", legs = "Leth. Fuseau +3", feet = "Leth. Houseaux +3"
	})

	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS,
	{
		neck = "Dls. Torque +2",
		waist = "Sailfi Belt +1", feet = "Leth. Houseaux +3"
	})
	sets.precast.WS['Black Halo'].PDL = set_combine(sets.precast.WS['Black Halo'],
	{
		ammo = "Crepuscular Pebble",
		body = "Bunzi's Robe", hands = "Malignance Gloves",
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
		ring1 = "Rufescent Ring", ring2 = "Medada's Ring",
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

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Midcast Sets
	-- Gear for Magic Burst mode.
	sets.MagicBurst =
	{
		head = "Ea Hat +1", neck = "Mizu. Kubikazari",
		body = "Ea Houppe. +1", ring1 = "Mujin Band",
		legs = "Leth. Fuseau +3", feet = "Bunzi's Sabots"
	}

	sets.midcast.FastRecast =
	{
		head = "Atrophy Chapeau +2", neck = "Sanctity Necklace", ear1 = "Malignance Earring", ear2 = "Leth. Earring +1",
		body = "Vitiation Tabard +3", hands = "Regal Cuffs", ring1 = "Mephitas's Ring +1", ring2 = "Medada's Ring",
		waist = "Witful Belt", feet = "Carmine Greaves +1"
	}

	sets.midcast.Cure =
	{
		main = "Daybreak", sub = "Sors Shield", ammo = "Staunch Tathlum +1",
		head = "Kaykaus Mitra +1", neck = "Incanter's Torque", ear1 = "Meili Earring", ear2 = "Mendi. Earring",
		body = "Kaykaus Bliaut +1", hands = "Kaykaus Cuffs +1", ring1 = "Lebeche Ring", ring2 = "Mephitas's Ring +1",
		back = "Tempered Cape +1", waist = "Luminary Sash", legs = "Kaykaus Tights +1", feet = "Kaykaus Boots +1"
	}

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {})

		--Cureset for if it's not light weather but is light day.
	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {})

	sets.midcast.Cursna = {main=gear.grioavolr_fc_staff,sub="Curatio Grip",range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck="Debilis Medallion",ear1="Meili Earring",ear2="Mendi. Earring",
		body="Viti. Tabard +3",hands="Hieros Mittens",ring1="Haoma's Ring",ring2="Menelaus's Ring",
		back="Oretan. Cape +1",waist="Witful Belt",legs="Carmine Cuisses +1",feet="Vanya Clogs"}

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})
		
	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = {neck="Phalaina Locket",ear1="Etiolation Earring",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}

	sets.midcast['Enhancing Magic'] =
	{
		main = "Colada", sub = "Ammurapi Shield", ammo = "Staunch Tathlum +1",
		head = "Telchine Cap", neck = "Dls. Torque +2", ear1 = "Ondowa Earring +1", ear2 = "Leth. Earring +1",
		body = "Telchine Chas.", hands = "Atrophy Gloves +2", ring1 = "Defending Ring", ring2 = "Mephitas's Ring +1",
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

	sets.midcast.Refresh =
	{
		head = "Amalric Coif +1",
		body = "Atrophy Tabard +3", hands = "Atrophy Gloves +2",
		waist = "Gishdubar Sash", legs = "Leth. Fuseau +3"
	}
	sets.midcast.Aquaveil =
	{
		head = "Amalric Coif +1", neck = "Loricate Torque +1", ear1 = "Eabani Earring", ear2 = "Sanare Earring",
		body = "Rosette Jawshan +1", hands = "Regal Cuffs", ring1 = "Defending Ring", ring2 = "Freke Ring",
		waist = "Emphatikos Rope", legs = "Shedir Seraweels", feet = "Amalric Nails +1"
	}

	sets.midcast.BarElement = set_combine(sets.EnhancingSkill,
	{
		head = "Telchine Cap", neck = "Dls. Torque +2",
		hands = "Atrophy Gloves +2",
		waist = "Embla Sash", legs = "Shedir Seraweels"
	})

	sets.midcast.Regen =
	{
		ammo = "Sapience Orb",
		main = "Bolelabunga",
		hands = "Atrophy Gloves +2"
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
	
	sets.midcast['Enfeebling Magic'] =
	{
		main = "Bunzi's Rod", sub = "Ammurapi Shield", ammo = "Regal Gem",
		head = "Atrophy Chapeau +2", neck = "Dls. Torque +2", ear1 = "Regal Earring", ear2 = "Snotra Earring",
		body = "Atrophy Tabard +3", hands = "Leth. Ganth. +3", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1", waist = "Acuity Belt +1", legs = "Leth. Fuseau +3", feet = "Leth. Houseaux +3"
	}
	
	sets.midcast['Frazzle II'] = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast['Frazzle III'] = set_combine(sets.midcast['Enfeebling Magic'],
	{
		head = "Viti. Chapeau +3", neck = "Incantor's Torque", ear1 = "Enfeebling Earring", ear2 = "Vor Earring",
		back = "Ghostfyre Cape", waist = "Rumination Sash", legs = "Psycloth Lappas", feet = "Vitiation Boots +3"
	})
	sets.midcast['Poison II'] = sets.midcast['Frazzle III']
	sets.midcast['Distract III'] = sets.midcast['Frazzle III']

	sets.midcast.Slow = set_combine(sets.midcast['Enfeebling Magic'],
	{
		main = "Daybreak",
		head = "Viti. Chapeau +3",
		body = "Lethargy Sayon +3", ring2 = "Metamor. Ring +1",
		waist = "Obstin. Sash", feet = "Vitiation Boots +3"
	})
	sets.midcast['Slow II'] = sets.midcast.Slow
	sets.midcast.Paralyze = sets.midcast.Slow
	sets.midcast['Paralyze II'] = sets.midcast.Slow
	sets.midcast.Addle = sets.midcast.Slow
	sets.midcast['Addle II'] = sets.midcast.Slow

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'],
	{
		head = "Leth. Chappel +3",
		body = "Lethargy Sayon +3", hands = "Regal Cuffs", ring1 = "Stikini Ring +1", ring2 = "Kishar Ring",
		waist = "Obstin. Sash",
	})
	sets.midcast.Bio = sets.midcast.Dia
	sets.midcast.Inundation = sets.midcast.Dia
	sets.midcast.Diaga = set_combine(sets.midcast.Dia, sets.TreasureHunter)

	sets.midcast.Sleep = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast['Sleep II'] = sets.midcast.Sleep
	sets.midcast.Sleepga = sets.midcast.Sleep
	sets.midcast.Bind = sets.midcast.Sleep
	sets.midcast.Break = sets.midcast.Sleep
	sets.midcast.Dispel = sets.midcast.Sleep
	sets.midcast.Dispelga = set_combine(sets.midcast.Sleep, { main = "Daybreak" })
	sets.midcast.Gravity = sets.midcast.Sleep
	sets.midcast['Gravity II'] = sets.midcast.Sleep
	sets.midcast.Blind = sets.midcast.Sleep
	sets.midcast['Blind II'] = sets.midcast.Sleep
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
		body = "Crepuscular Cloak", hands = "Leth. Ganth. +", ring1 = "Stikini Ring +1", ring2 = "Metamor. Ring +1",
		back = "Aurist's Cape +1", waist = "Acuity Belt +1", legs = "Leth. Fuseau +3", feet = "Leth. Houseaux +3"
	}

	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

	sets.midcast['Elemental Magic'] =
	{
		main = "Bunzi's Rod", sub = "Ammurapi Shield", ammo = "Pemphredo Tathlum",
		head = "Leth. Chappel +3", neck = "Dls. Torque +2", ear1 = "Malignance Earring", ear2 = "Regal Earring",
		body = "Amalric Doublet +1", hands = "Amalric Gages +1", ring1 = "Freke Ring", ring2 = "Medada's Ring",
		waist = "Sacro Cord", legs = "Amalric Slops +1", feet = "Leth. Houseaux +3"
	}

	sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi Shield",range="Kaja Bow",ammo=empty,
		head="Amalric Coif +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Atrophy Tabard +3",hands="Leth. Gantherots +1",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Luminary Sash",legs="Psycloth Lappas",feet="Amalric Nails +1"}

    sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",range="Kaja Bow",ammo=empty,
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
        body=gear.merlinic_nuke_body,hands=gear.chironic_enfeeble_hands,ring1="Evanescence Ring",ring2="Archon Ring",
        back=gear.nuke_jse_back,waist="Fucho-no-obi",legs="Chironic Hose",feet=gear.merlinic_aspir_feet}

	sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = {main="Daybreak",sub="Ammurapi Shield",range="Kaja Bow",ammo=empty,
		head="Atrophy Chapeau +2",neck="Dls. Torque +2",ear1="Regal Earring",ear2="Malignance Earring",
		body="Zendik Robe",hands="Volte Gloves",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Sailfi Belt +1",legs="Chironic Hose",feet=gear.merlinic_aspir_feet}
		
	sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",range="Kaja Bow",ammo=empty,
		head="Atrophy Chapeau +2",neck="Dls. Torque +2",ear1="Regal Earring",ear2="Malignance Earring",
		body="Atrophy Tabard +3",hands="Volte Gloves",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.merlinic_aspir_feet}

	-- Sets for special buff conditions on spells.
		
	sets.buff.Saboteur = {hands="Leth. Gantherots +1"}
	
	sets.HPDown =
	{
		head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",legs="Shedir Seraweels",feet="Jhakri Pigaches +2"
	}

	sets.HPCure =
	{
		main="Daybreak",sub="Sors Shield",range=empty,ammo="Hasty Pinion +1",
		head="Gende. Caubeen +1",neck="Unmoving Collar +1",ear1="Gifted Earring",ear2="Mendi. Earring",
		body="Viti. Tabard +3",hands = "Kaykaus Cuffs +1",ring1="Gelatinous Ring +1",ring2="Meridian Ring",
		back="Moonlight Cape",waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Kaykaus Boots +1"
	}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle =
	{
		main = "Daybreak", sub = "Sacro Bulwark", ammo = "Staunch Tathlum +1",
		head = "Viti. Chapeau +3", neck = "Warder's Charm +1", ear1 = "Etiolation Earring", ear2 = "Odnowa Earring +1",
		body = "Lethargy Sayon +3", hands = "Nyame Gauntlets", ring1 = "Stikini Ring +1", ring2 = "Mephitas's Ring +1",
		back = gear.Sucellos.STP, waist = "Carrier's Sash", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.idle.Refresh = set_combine(sets.idle, { ammo = "Homiliary", ring2 = "Stikini Ring +1", feet = "Volte Gaiters" })

	sets.Kiting = { legs = "Carmine Cuisses +1" }

	-- Weapons sets
	--state.Weapons:options('None','Naegling','DualNaegling','DualExcalibur','DualLightDamage','DualClubs','DualTauret','DualAeolian','EnspellOnly','EnspellDW')
	sets.weapons.Naegling = { main = "Naegling", sub = "Sacro Bulwark" }
	sets.weapons.Croc = { main = "Crocea Mors", sub = "Sacro Bulawark" }
	sets.weapons.DualNaegling = { main = "Naegling", sub = "Thibron" }
	sets.weapons.DualNaeglingAcc = { main = "Naegling", sub = "Ternion Dagger +1" }
	sets.weapons.DualCroc = { main = "Crocea Mors", sub = "Ternion Dagger +1" }
	sets.weapons.DualExcalibur = { main = "Excalibur", sub = "Ternion Dagger +1" }
	sets.weapons.DualLightDamage = { main = "Crocea Mors", sub = "Daybreak" }
	sets.weapons.DualClubs = { main = "Maxentius", sub = "Thibron" }
	sets.weapons.DualTauret = { main = "Tauret", sub = "Gleti's Knife" }
	sets.weapons.DualAeolian = { main = "Tauret", sub = "Daybreak" }
	sets.weapons.EnspellOnly = { main = "Crocea Mors", sub = "Aern Dagger", range = "Kaja Bow", ammo = "Beetle Arrow" }
	sets.weapons.EnspellDW = { main = "Blurred Knife +1", sub = "Atoyac", range = "Kaja Bow", ammo = "Beetle Arrow" }
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
		head = "Malignance Chapeau", neck = "Anu Torque", ear1 = "Sherida Earring", ear2 = "Brutal Earring",
		body = "Malignance Tabard", hands = "Bunzi's Gloves", ring1 = "Ilabrat Ring", ring2 = "Hetairoi Ring",
		back = gear.Sucellos.STP, waist = "Windbuffet Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.engaged.DT = set_combine(sets.engaged, {})

	sets.engaged.DW =
	{
		ammo = "Coiste Bodhar",
		head = "Malignance Chapeau", neck = "Anu Torque", ear1 = "Sherida Earring", ear2 = "Eabani Earring",
		body = "Malignance Tabard", hands = "Bunzi's Gloves", ring1 = "Ilabrat Ring", ring2 = "Hetairoi Ring",
		back = gear.Sucellos.STP, waist = "Reiki Yotai", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	sets.engaged.DW.DT = set_combine(sets.engaged.DW, { ring2 = "Defending Ring" })

	sets.engaged.DW.Haste30 = set_combine(sets.engaged.DW,
	{
		head = "Bunzi's Hat", ear1 = "Suppanomimi",
		feet = "Taeon Boots"
	})
	sets.engaged.DW.DT.Haste30 = set_combine(sets.engaged.DW.Haste30, { neck = "Loricate Torque +1", ring2 = "Defending Ring" })

	sets.engaged.EnspellOnly = {
		head="Malignance Chapeau",neck="Dls. Torque +2",ear1="Suppanomimi",ear2="Digni. Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Metamor. Ring +1",ring2="Ramuh Ring +1",
		back="Ghostfyre Cape",waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Malignance Boots"}
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