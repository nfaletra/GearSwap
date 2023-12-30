-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	state.OffenseMode:options('Normal')
	state.RangedMode:options('Normal', 'Acc', 'Crit')
	state.WeaponskillMode:options('Match', 'Normal', 'PDL', 'Proc')
	state.CastingMode:options('Normal', 'Damage', 'Proc')
	state.IdleMode:options('Normal', 'PDT', 'Refresh')
	state.HybridMode:options('Normal', 'DT', 'MEVA')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', }
	state.Weapons:options('Default', 'Ranged', 'Crit', 'Savage', 'Evisceration', 'DualWeapons', 'DualRanged', 'DualSavage', 'DualLeadenRanged', 'DualLeadenMelee', 'DualHotShot', 'DualEvisceration', 'DualAeolian', 'None')
	state.CompensatorMode:options('Always', 'Never', '300', '1000')

	gear.RAbullet = "Chrono Bullet"
	gear.WSbullet = "Chrono Bullet"
	gear.MAbullet = "Orichalc. Bullet" --For MAB WS, do not put single-use bullets here.
	gear.QDbullet = "Orichalc. Bullet"
	options.ammo_warning_limit = 5

	gear.Camulus =
	{
		Idle = { name = "Camulus's Mantle", augments = { 'INT+20', 'Eva.+20 /Mag. Eva.+20', '"Snapshot"+10' } },
		DA = { name = "Camulus's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%' } },
		DW = { name = "Camulus's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dual Wield"+10', 'Phys. dmg. taken-10%' } },
		RA = { name = "Camulus's Mantle", augments = { 'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'Rng.Acc.+10', '"Store TP"+10', 'Mag. Evasion+15' } },
		RA_Crit = { name = "Camulus's Mantle", augments = { 'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10', 'Crit.hit rate+10', 'Phys. dmg. taken-10%' } },
		STR_WSD = { name = "Camulus's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Mag. Evasion+15' } },
		AGI_WSD = { name = "Camulus's Mantle", augments = { 'AGI+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'AGI+10', 'Weapon skill damage +10%', 'Mag. Evasion+15' }},
		AGI_WSD_Phys = { name = "Camulus's Mantle", augments = { 'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10', 'Weapon skill damage +10%', 'Mag. Evasion+15' } },
		FC = { name = "Camulus's Mantle", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', '"Fast Cast"+10' } }
	}

	gear.Rostam =
	{
		A = { name = "Rostam", augments = { 'Path: A' } },
		C = { name = "Rostam", augments = {'Path: C' } }
	}

	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c elemental quickdraw')

	send_command('bind ^backspace input /ja "Double-up" <me>')
	send_command('bind @backspace input /ja "Snake Eye" <me>')
	send_command('bind !backspace input /ja "Fold" <me>')
	send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')

	send_command('bind ^\\\\ input /ja "Random Deal" <me>')
	send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
	send_command('bind ^@!\\\\ gs c toggle LuzafRing')
	send_command('bind @f7 gs c toggle RngHelper')

	send_command('bind @pause roller roll')

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets

	-- Precast sets to enhance JAs

	sets.precast.JA['Triple Shot'] = { body = "Chasseur's Frac +2" }
	sets.precast.JA['Snake Eye'] = { legs = "Lanun Trews +3" }
	sets.precast.JA['Wild Card'] = { feet = "Lanun Bottes +3" }
	sets.precast.JA['Random Deal'] = { body = "Lanun Frac +3" }
	sets.precast.FoldDoubleBust = { hands = "Lanun Gants +3" }

	sets.precast.CorsairRoll =
	{
		main = gear.Rostam.C,
		head = "Lanun Tricorne +3", neck = "Regal Necklace", ear1 = "Etiolation Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Chasseur's Gants +3", ring1 = "Defending Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Camulus.Idle, waist = "Flume Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.LuzafRing = { ring2 = "Luzaf's Ring" }

	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, { legs = "Chas. Culottes +3" })
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, { feet = "Chass. Bottes +2" })
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, { head = "Chass. Tricorne +2" })
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, { body = "Chasseur's Frac +2" })
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, { hands = "Chasseur's Gants +3" })

	sets.precast.CorsairShot =
	{
		ammo = gear.QDbullet,
		head = "Ikenga's Hat", neck = "Iskur Gorget", ear1 = "Crep. Earring", ear2 = "Digni. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Crepuscular Ring", ring2 = "Chirich Ring +1",
		back = gear.Camulus.Ranged, waist = "K. Kachina Belt +1", legs = "Chas. Culottes +3", feet = "Malignance Boots"
	}

	sets.precast.CorsairShot.Damage =
	{
		ammo = gear.QDbullet,
		head = "Laksa. Tricorne +2", neck = "Comm. Charm +2", ear1 = "Friomisi Earring", ear2 = "Crematio Earring",
		body = "Lanun Frac +3", hands = "Carmine Fin. Ga. +1", ring1 = "Dingir Ring", ring2 = "Regal Ring",
		back = gear.Camulus.AGI_WSD, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Lanun Bottes +3"
	}

	sets.precast.CorsairShot.Proc = set_combine(sets.precast.CorsairShot.Damage,
	{
		feet = "Chass. Bottes +2"
	})

	sets.precast.CorsairShot['Light Shot'] =
	{
		ammo = gear.QDbullet,
		head = "Laksa. Tricorne +2", neck= "Comm. Charm +2", ear1 = "Crep. Earring", ear2 = "Chas. Earring +2",
		body = "Ikenga's Vest", hands = "Laksa. Gants +2", ring1 = "Stikini Ring +1", ring2 = "Regal Ring",
		back = gear.Camulus.AGI_WSD, waist = "K. Kachina Belt +1", legs = "Ikenga's Trousers", feet = "Laksa. Bottes +2"
	}

	sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {})

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	sets.precast.Step =
	{
		head = "Chass. Tricorne +2", neck = "Combatant's Torque", ear1 = "Crep. Earring", ear2 = "Mache Earring +1",
		body = "Chasseur's Frac +2", hands = "Chasseur's Gants +3", ring1 = "Regal Ring", ring2 = "Mummu Ring",
		back = gear.Camulus.DA, waist = "Kentarch Belt +1", legs = "Chas. Culottes +3", feet = "Chass. Bottes +2"
	}

	sets.Self_Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells

	sets.precast.FC =
	{
		head = "Carmine Mask +1", neck = "Orunmila's Torque", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = gear.adhemar.body.d, hands = "Leyline Gloves", ring1 = "Kishar Ring", ring2 = "Medada's Ring",
		back = gear.Camulus.FC, waist = "Flume Belt +1", legs = "Rawhide Trousers", feet = "Carmine Greaves +1"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck = "Magoraga Beads", body = "Passion Jacket" })

	sets.precast.FC.Cure = set_combine(sets.precast.FC, { ear2 = "Mendi. Earring" })

	sets.precast.RA =
	{
		ammo = gear.RAbullet,
		head = "Chass. Tricorne +2", neck = "Comm. Charm +2",
		body = "Oshosi Vest +1", hands = "Carmine Fin. Ga. +1", ring1 = "Crepuscular Ring",
		back = gear.Camulus.Idle, waist = "Impulse Belt", legs = "Adhemar Kecks +1", feet = "Meg. Jam. +2"
	}

	sets.precast.RA.Flurry =
	{
		ammo = gear.RABullet,
		head = "Cass. Tricorne +2", neck = "Comm. Charm +2",
		body = "Laksa. Frac +3", hands = "Carmine Fin. Ga. +1", ring1 = "Crepuscular Ring",
		back = gear.Camulus.Idle, waist = "Yemaya Belt", legs = "Adhemar Kecks +1", feet = "Meg. Jam. +2"
	}

	sets.precast.RA.Flurry2 =
	{
		ammo = gear.RABullet,
		head = "Chass. Tricorne +2",
		body = "Laksa. Frac +3", hands = "Carmine Fin. Ga. +1", ring1 = "Crepuscular Ring",
		back = gear.Camulus.Idle, waist = "Yemaya Belt", legs = "Adhemar Kecks +1", feet = "Pursuer's Gaiters"
	}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}
	sets.precast.WS.Acc = {}
	sets.precast.WS.Proc = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	sets.precast.WS['Requiescat'] =
	{
		ammo = gear.WSbullet,
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget", ear1 = "Telos Earring", ear2 = "Moonshade Earring",
		body = gear.adhemar.body.b, hands  = gear.adhemar.hands.b, ring1 = "Rufescent Ring", ring2 = "Epona's Ring",
		back = gear.Camulus.STR_WSD, waist = "Fotia Belt", legs = "Meg. Chausses +2", feet = gear.herculean_ta_feet
	}

	sets.precast.WS['Savage Blade'] =
	{
		ammo = gear.WSbullet,
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Ishvara Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Chasseur's Gants +3", ring1 = "Regal Ring", ring2 = "Epaminondas's Ring",
		back = gear.Camulus.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS['Savage Blade'],
	{
		body = "Ikenga's Vest", ring2 = "Sroda Ring",
	})

	sets.precast.WS['Seraph Blade'] =
	{
		ammo = gear.QDbullet,
		head = "Nyame Helm", neck = "Comm. Charm +2", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Dingir Ring",
		back = gear.Camulus.STR_WSD, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Lanun Bottes +3"
	}

	sets.precast.WS['Burning Blade'] = sets.precast.WS['Seraph Blade']

	sets.precast.WS['Evisceration'] =
	{
		ammo = gear.WSbullet,
		head = "Blistering Sallet +1", neck = "Fotia Gorget", ear1 = "Odr Earring", ear2 = "Moonshade Earring",
		body = "Meg. Cuirie +2", hands = gear.adhemar.hands.b, ring1 = "Ilabrat Ring", ring2 = "Regal Ring",
		back = gear.Camulus.DA, waist = "Fotia Belt", legs = "Zoar Subligar +1", feet = "Adhe. Gamashes +1"
	}
	sets.precast.WS['Evisceration'].PDL = set_combine(sets.precast.WS['Evisceration'],
	{
		body = "Ikenga's Vest",
		feet = "Ikenga's Clogs"
	})

	sets.precast.WS['Aeolian Edge'] =
	{
		ammo = gear.QDbullet,
		head = "Nyame Helm", neck = "Comm. Charm +2", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Dingir Ring",
		back = gear.Camulus.AGI_WSD, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Lanun Bottes +3"
	}

	sets.precast.WS['Last Stand'] =
	{
		ammo = gear.WSbullet,
		head = "Lanun Tricorne +3", neck = "Fotia Gorget", ear1 = "Ishvara Earring", ear2 = "Moonshade Earring",
		body = "Ikenga's Vest", hands = "Chasseur's Gants +3", ring1 = "Dingir Ring", ring2 = "Epaminondas's Ring",
		back = gear.Camulus.AGI_WSD_Phys, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Lanun Bottes +3"
	}
	sets.precast.WS['Last Stand'].PDL = set_combine(sets.precast.WS['Last Stand'],
	{
		head = "Ikenga's Hat",
		hands = "Ikenga's Gloves", ring2 = "Sroda Ring",
		legs = "Ikenga's Trousers", feet = "Ikenga's Clogs"
	})

	sets.precast.WS['Detonator'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Detonator'].PDL = sets.precast.WS['Last Stand'].PDL
	sets.precast.WS['Slug Shot'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Slug Shot'].PDL = sets.precast.WS['Last Stand'].PDL
	sets.precast.WS['Numbing Shot'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Numbing Shot'].PDL = sets.precast.WS['Last Stand'].PDL
	sets.precast.WS['Sniper Shot'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Sniper Shot'].PDL = sets.precast.WS['Last Stand'].PDL
	sets.precast.WS['Split Shot'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Split Shot'].PDL = sets.precast.WS['Last Stand'].PDL

	sets.precast.WS['Leaden Salute'] =
	{
		ammo = gear.MAbullet,
		head = "Pixie Hairpin +1", neck = "Comm. Charm +2", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Lanun Frac +3", hands = "Nyame Gauntlets", ring1 = "Dingir Ring", ring2 = "Archon Ring",
		back = gear.Camulus.AGI_WSD, waist = "Svelt. Gouriz +1", legs = "Nyame Flanchard", feet = "Lanun Bottes +3"
	}

	sets.precast.WS['Wildfire'] =
	{
		ammo = gear.MAbullet,
		head = "Nyame Helm", neck = "Comm. Charm +2", ear1 = "Friomisi Earring", ear2 = "Hermetic Earring",
		body = "Lanun Frac +3", hands = "Nyame Gauntlets", ring1 = "Dingir Ring", ring2 = "Medada's Ring",
		back = gear.Camulus.AGI_WSD, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Lanun Bottes +3"
	}

	sets.precast.WS['Hot Shot'] =
	{
		ammo = gear.MAbullet,
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Chasseur's Gants +3", ring1 = "Dingir Ring", ring2 = "Medada's Ring",
		cape = gear.Camulus.AGI_WSD, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Lanun Bottes +3"
	}

	--Because omen skillchains.
	sets.precast.WS['Burning Blade'] =
	{
		head = "Meghanada Visor +2", neck = "Twilight Torque", ear1 = "Telos Earring", ear2 = "Crep. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Regal Ring",
		back = "Moonlight Cape", waist = "Flume Belt +1", legs = "Meg. Chausses +2", feet = "Meg. Jam. +2"
	}

	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS['Leaden Salute'],
	{
		ammo = gear.QDbullet,
		body = "Nyame Mail", ring2 = "Metamor. Ring +1",
		back = gear.Camulus.STR_WSD,
	})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

	-- Midcast Sets
	sets.midcast.FastRecast =
	{
		head = "Carmine Mask +1", neck= "Baetyl Pendant", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = "Dread Jupon", hands = "Leyline Gloves", ring1 = "Kishar Ring", ring2 = "Lebeche Ring",
		back = "Moonlight Cape", waist = "Flume Belt +1", legs = "Rawhide Trousers", feet = "Carmine Greaves +1"
	}

	sets.Self_Healing = { waist = "Gishdubar Sash" }
	sets.Cure_Received = { waist = "Gishdubar Sash" }
	sets.Self_Refresh = { waist = "Gishdubar Sash" }
	
	sets.midcast.Utsusemi = sets.midcast.FastRecast

	-- Ranged gear
	sets.midcast.RA =
	{
		ammo = gear.RAbullet,
		head = "Ikenga's Hat", neck = "Iskur Gorget", ear1 = "Telos Earring", ear2 = "Crep. Earring",
		body = "Ikenga's Vest", hands = "Malignance Gloves", ring1 = "Crepuscular Ring", ring2 = "Ilabrat Ring",
		back = gear.Camulus.RA, waist = "Yemaya Belt", legs = "Chas. Culottes +3", feet = "Malignance Boots"
	}

	sets.midcast.RA.Acc = set_combine(sets.midcast.RA,
	{
		neck = "Comm. Charm +2",
		waist = "K. Kachina Belt +1",
	})

	sets.midcast.RA.Crit = set_combine(sets.midcast.RA,
	{
		head = "Meghanada Visor +2", ear1 = "Odr Earring", ear2 = "Chas. Earring +2",
		body = "Meg. Cuirie +2", hands = "Dingir Ring", ring1 = "Begrudging Ring",
		back = gear.Camulus.RA_Crit, waist = "K. Kachina Belt +1", legs = "Darraigner's Brais", feet = "Osh. Leggings +1"
	})

	sets.buff['Triple Shot'] =
	{
		head = "Oshosi Mask +1",
		body = "Chasseur's Frac +2", hands = "Lanun Gants +3",
		legs = "Osh. Trousers +1", feet = "Osh. Leggings +1"
	}

	-- Sets to return to when not performing an action.

	sets.DayIdle = {}
	sets.NightIdle = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle =
	{
		ammo = gear.RAbullet,
		head = "Malignance Chapeau", neck = "Warder's Charm +1", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Gelatinous Ring +1",
		back= gear.Camulus.Idle, waist = "Carrier's Sash", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.idle.PDT =
	{
		ammo = gear.RAbullet,
		head = "Malignance Chapeau", neck = "Warder's Charm +1", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Gelatinous Ring +1",
		back= gear.Camulus.Idle, waist = "Carrier's Sash", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.idle.Refresh =
	{
		ammo = gear.RAbullet,
		head = "Malignance Chapeau", neck = "Warder's Charm +1", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Gelatinous Ring +1",
		back= gear.Camulus.Idle, waist = "Carrier's Sash", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	-- Defense sets
	sets.defense.PDT =
	{
		ammo = gear.RAbullet,
		head = "Malignance Chapeau", neck = "Comm. Charm +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Shadow Ring",
		back= gear.Camulus.Idle, waist = "Carrier's Sash", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.defense.MDT =
	{
		ammo = gear.RAbullet,
		head = "Malignance Chapeau", neck = "Comm. Charm +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Shadow Ring",
		back= gear.Camulus.Idle, waist = "Carrier's Sash", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.defense.MEVA =
	{
		ammo = gear.RAbullet,
		head = "Malignance Chapeau", neck = "Comm. Charm +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Shadow Ring",
		back= gear.Camulus.Idle, waist = "Carrier's Sash", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.Kiting = { ring1 = "Shneddick Ring", legs = "Carmine Cuisses +1" }
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Weapons sets
	sets.weapons.Default = { main = gear.Rostam.A, sub = "Nusku Shield", range = "Fomalhaut" }
	sets.weapons.Ranged = { main = gear.Rostam.A, sub = "Nusku Shield", range = "Fomalhaut" }
	sets.weapons.Crit = { main = "Gleti's Knife", sub = "Nusku Shield", range = "Fomalhaut" }
	sets.weapons.Savage = { main = "Naegling", sub = "Nusku Shield", range = "Ataktos" }
	sets.weapons.Evisceration = { main = "Tauret", sub = "Nusku Shield", range = "Ataktos" }
	sets.weapons.DualWeapons = { main = gear.Rostam.A, sub = "Gleti's Knife", range = "Fomalhaut" }
	sets.weapons.DualRanged = { main = gear.Rostam.A, sub = "Kustawi +1", range = "Fomalhaut" }
	sets.weapons.DualSavage = { main = "Naegling", sub = "Gleti's Knife", range = "Ataktos" }
	sets.weapons.DualEvisceration = { main = "Tauret", sub = "Gleti's Knife", range = "Ataktos" }
	sets.weapons.DualLeadenRanged = { main = gear.Rostam.A, sub = "Kustawi +1", range = "Fomalhaut" }
	sets.weapons.DualLeadenMelee = { main = gear.Rostam.A, sub = "Tauret", range = "Fomalhaut" }
	sets.weapons.DualHotShot = { main = "Naegling", sub = "Tauret", range = "Fomalhaut" }
	sets.weapons.DualAeolian = { main = gear.Rostam.A, sub = "Tauret", range = "Ataktos" }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged =
	{
		head = "Malignance Chapeau", neck = "Combatant's Torque", ear1 = "Crep. Earring", ear2 = "Brutal Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Epona's Ring",
		back = gear.Camulus.DA, waist = "Carrier's Sash", legs = "Chas. Culottes +3", feet = "Malignance Boots"
	}
	sets.engaged.DT =
	{
		head = "Malignance Chapeau", neck = "Combatant's Torque", ear1 = "Crep. Earring", ear2 = "Brutal Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Epona's Ring",
		back = gear.Camulus.DA, waist = "Carrier's Sash", legs = "Chas. Culottes +3", feet = "Malignance Boots"
	}
	sets.engaged.MEVA =
	{
		head = "Malignance Chapeau", neck = "Warder's Charm +1", ear1 = "Telos Earring", ear2 = "Brutal Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Epona's Ring",
		back = gear.Camulus.DA, waist = "Windbuffet Belt +1", legs = "Chas. Culottes +3", feet = "Malignance Boots"
	}

	sets.engaged.DW =
	{
		head = "Malignance Chapeau", neck = "Combatant's Torque", ear1 = "Eabani Earring", ear2 = "Brutal Earring",
		body = gear.adhemar.body.b, hands = gear.adhemar.hands.a, ring1 = "Petrov Ring", ring2 = "Epona's Ring",
		back = gear.Camulus.DA, waist = "Windbuffet Belt +1", legs = "Samnuha Tights", feet = gear.herculean_ta_feet
	}
	sets.engaged.DW.Haste30 = set_combine(sets.engaged.DW,
	{
		ear2 = "Suppanomimi",
		waist = "Reiki Yotai", feet = "Taeon Boots"
	})
	sets.engaged.DW.Haste15 = set_combine(sets.engaged.DW.Haste30,
	{
		back = gear.Camulus.DW
	})
	sets.engaged.DW.Haste0 = set_combine(sets.engaged.DW.Haste15,
	{
		head = "Taeon Chapeau"
	})

	sets.engaged.DW.DT =
	{
		head = "Malignance Chapeau", neck = "Combatant's Torque", ear1 = "Eabani Earring", ear2 = "Brutal Earring",
		body = "Malignance Tabard", hands = gear.adhemar.hands.a, ring1 = "Defending Ring", ring2 = "Epona's Ring",
		back = gear.Camulus.DA, waist = "Reiki Yotai", legs = "Samnuha Tights", feet = "Malignance Boots"
	}
	sets.engaged.DW.DT.Haste30 = set_combine(sets.engaged.DW.DT,
	{
		back = gear.Camulus.DW, legs = "Chas. Culottes +3", feet = "Taeon Boots"
	})
	sets.engaged.DW.DT.Haste15 = set_combine(sets.engaged.DW.DT.Haste30,
	{
		neck = "Loricate Torque +1", ear2 = "Suppanomimi",
		legs = "Taeon Tights"
	})
	sets.engaged.DW.DT.Haste0 = set_combine(sets.engaged.DW.DT.Haste15,
	{
		head = "Taeon Chapeau",
		hands = "Taeon Gloves", ring2 = "Gelatinous Ring +1",
	})

	sets.engaged.DW.MEVA =
	{
		head = "Malignance Chapeau", neck = "Combatant's Torque", ear1 = "Eabani Earring", ear2 = "Brutal Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Epona's Ring",
		back = gear.Camulus.DA, waist = "Reiki Yotai", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	sets.engaged.DW.MEVA.Haste30 = set_combine(sets.engaged.DW.MEVA,
	{
		ear2 = "Suppanomimi",
		back = gear.Camulus.DW,
	})
	sets.engaged.DW.MEVA.Haste15 = set_combine(sets.engaged.DW.MEVA.Haste30, {}) -- Don't fucking die is the priority
	sets.engaged.DW.MEVA.Haste0 = set_combine(sets.engaged.DW.MEVA.Haste15, {}) -- Don't fucking die is the priority
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	if player.sub_job == 'NIN' then
		set_macro_page(1, 10)
	elseif player.sub_job == 'DNC' then
		set_macro_page(2, 10)
	elseif player.sub_job == 'RNG' then
		set_macro_page(3, 10)
	elseif player.sub_job == 'DRG' then
		set_macro_page(4, 10)
	else
		set_macro_page(5, 10)
	end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 007')
end

autows_list = {['Default']='Savage Blade',['Evisceration']='Evisceration',['Savage']='Savage Blade',['Ranged']='Last Stand',['DualWeapons']='Savage Blade',['DualSavageWeapons']='Savage Blade',['DualEvisceration']='Evisceration',['DualLeadenRanged']='Leaden Salute',['DualLeadenMelee']='Leaden Salute',['DualAeolian']='Aeolian Edge',['DualRanged']='Last Stand'}