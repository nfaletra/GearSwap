-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	state.OffenseMode:options('Normal', 'Acc')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'Proc')
	state.CastingMode:options('Normal', 'Fodder', 'Proc')
	state.IdleMode:options('Normal', 'PDT', 'Refresh')
	state.HybridMode:options('Normal', 'DT')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}
	state.Weapons:options('Default', 'Ranged', 'Savage', 'Evisceration', 'DualWeapons', 'DualSavageWeapons', 'DualEvisceration', 'DualLeadenRanged', 'DualLeadenMelee', 'DualAeolian', 'DualLeadenMeleeAcc', 'DualRanged', 'DualProcWeapons', 'None')
	state.CompensatorMode:options('Never', '300', '1000', 'Always')

	gear.RAbullet = "Decimating Bullet"
	gear.WSbullet = "Decimating Bullet"
	gear.MAbullet = "Orichalc. Bullet" --For MAB WS, do not put single-use bullets here.
	gear.QDbullet = "Orichalc. Bullet"
	options.ammo_warning_limit = 5

	gear.camulus_range_tp = {name="Camulus's Mantle",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}}
	gear.camulus_snapshot = {name="Camulus's Mantle",augments={'"Snapshot"+10',}}
	gear.camulus_melee_tp = { name = "Camulus's Mantle", augments = {'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%' }}
	gear.camulus_wsd = {name="Camulus's Mantle",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	gear.camulus_leaden = { name = "Camulus's Mantle", augments = {'AGI+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'AGI+5', 'Weapon skill damage +10%', 'Mag. Evasion+15' }}
	gear.camulus_savage = {name="Camulus's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

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

	sets.precast.JA['Triple Shot'] = { body = "Chasseur's Frac +1" }
	sets.precast.JA['Snake Eye'] = { legs = "Lanun Trews +1" }
	sets.precast.JA['Wild Card'] = { feet = "Lanun Bottes +3" }
	sets.precast.JA['Random Deal'] = { body = "Lanun Frac +1" }
	sets.precast.FoldDoubleBust = { hands = "Lanun Gants +1" }

	sets.precast.CorsairRoll =
	{
		head = "Lanun Tricorne +1", neck = "Regal Necklace", ear1 = "Etiolation Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Chasseur's Gants +1", ring1 = "Defending Ring", ring2 = "Gelatinous Ring +1",
		back = gear.camulus_melee_tp, waist = "Flume Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.LuzafRing = { ring2 = "Luzaf's Ring" }

	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, { legs = "Chas. Culottes +1" })
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, { feet = "Chass. Bottes +1" })
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, { head = "Chass. Tricorne +1" })
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, { body = "Chasseur's Frac +1" })
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, { hands = "Chasseur's Gants +1" })

	sets.precast.CorsairShot =
	{
		ammo = gear.QDbullet,
		head = "Malignance Chapeau", neck = "Iskur Gorget", ear1 = "Dedition Earring", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Dingir Ring", ring2 = "Regal Ring",
		back = gear.camulus_leaden, waist = "Sweordfaetels", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.CorsairShot.Damage =
	{
		ammo = gear.QDbullet,
		head = "Nyame Helm", neck = "Comm. Charm +2", ear1 = "Friomisi Earring", ear2 = "Crematio Earring",
		body = "Lanun Frac +1", hands = "Carmine Fin. Ga. +1", ring1 = "Dingir Ring", ring2 = "Fenrir Ring +1",
		back = gear.camulus_leaden, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Lanun Bottes +2"
	}

	sets.precast.CorsairShot.Proc = set_combine(sets.precast.CorsairShot.Damage,
	{
		feet = "Chass. Bottes +1"
	})

	sets.precast.CorsairShot['Light Shot'] =
	{
		ammo = gear.QDbullet,
		head = "Laksa. Tricorne +1", neck= "Comm. Charm +2", ear1 = "Digni. Earring", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Laksa. Gants +1", ring1 = "Metamor. Ring +1", ring2 = "Regal Ring",
		back = gear.camulus_leaden, waist = "Eschan Stone", legs = "Malignance Tights", feet = "Laksa. Bottes +2"
	}

	sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {})

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	sets.Self_Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells

	sets.precast.FC =
	{
		head = "Carmine Mask +1", neck = "Baetyl Pendant", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = "Dread Jupon", hands = "Leyline Gloves", ring1 = "Kishar Ring", ring2 = "Lebeche Ring",
		back = "Moonlight Cape", waist = "Flume Belt +1", legs = "Rawhide Trousers", feet = "Carmine Greaves +1"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck = "Magoraga Beads", body = "Passion Jacket" })

	sets.precast.FC.Cure = set_combine(sets.precast.FC, { ear2 = "Mendi. Earring" })

	sets.precast.RA =
	{
		ammo = gear.RAbullet,
		head = "Chass. Tricorne +1",
		body  = "Oshosi Vest +1", hands = "Lanun Gants +1",
		back = gear.camulus_snapshot, waist = "Impulse Belt", legs = "Adhemar Kecks +1", feet = "Meg. Jam. +2"
	}

	sets.precast.RA.Flurry = set_combine(sets.precast.RA, { body = "Laksa. Frac +1" })
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry, { hands = "Carmine Fin. Ga. +1", feet = "Pursuer's Gaiters" })

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}
	sets.precast.WS.Acc = {}
	sets.precast.WS.Proc = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	sets.precast.WS['Requiescat'] =
	{
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget", ear1 = "Telos Earring", ear2 = "Moonshade Earring",
		body = "Adhemar Jacket +1", hands  = "Meg. Gloves +2", ring1 = "Regal Ring", ring2 = "Rufescent Ring",
		back = gear.camulus_savage, waist = "Fotia Belt", legs = "Meg. Chausses +2", feet = gear.herculean_ta_feet
	}

	sets.precast.WS['Evisceration'] =
	{
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget", ear1 = "Odr Earring", ear2 = "Moonshade Earring",
		body = "Mummu Jacket +2", hands = "Mummu Wrists +2", ring1 = "Regal Ring", ring2 = "Mummu Ring",
		back = gear.camulus_melee_tp, waist = "Fotia Belt", legs = "Samnuha Tights", feet = "Mummu Gamash. +2"
	}

	sets.precast.WS['Savage Blade'] =
	{
		head = "Nyame Helm", neck = "Comm. Charm +2", ear1 = "Ishvara Earring", ear2 = "Moonshade Earring",
		body = "Laksa. Frac +1", hands = "Meg. Gloves +2", ring1 = "Regal Ring", ring2 = "Rufescent Ring",
		back = gear.camulus_savage, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet="Lanun Bottes +3"
	}

	sets.precast.WS['Last Stand'] =
	{
		ammo = gear.WSbullet,
		head = "Lanun Tricorne +1", neck = "Fotia Gorget", ear1 = "Ishvara Earring", ear2 = "Moonshade Earring",
		body = "Meg. Cuirie +2", hands = "Meg. Gloves +2", ring1 = "Regal Ring", ring2 = "Dingir Ring",
		back = gear.camulus_wsd, waist = "Fotia Belt", legs = "Meg. Chausses +2", feet = "Lanun Bottes +3"
	}

	sets.precast.WS['Detonator'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Slug Shot'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Numbing Shot'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Sniper Shot'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Split Shot'] = sets.precast.WS['Last Stand']

	sets.precast.WS['Leaden Salute'] =
	{
		ammo = gear.MAbullet,
		head = "Pixie Hairpin +1", neck = "Comm. Charm +2", ear1 = "Friomisi Earring",ear2="Moonshade Earring",
		body = "Lanun Frac +1", hands = "Carmine Fin. Ga. +1", ring1 = "Regal Ring", ring2 = "Dingir Ring",
		back = gear.camulus_leaden, waist = "Anrin Obi", legs = "Nyame Flanchard", feet = "Lanun Bottes +3"
	}

	sets.precast.WS['Aeolian Edge'] =
	{
		head = "Nyame Helm", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Laksa. Frac +1", hands = "Carmine Fin. Ga. +1", ring1 = "Metamor. Ring +1", ring2 = "Dingir Ring",
		back = gear.camulus_leaden, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Lanun Bottes +3"
	}

	sets.precast.WS['Wildfire'] =
	{
		ammo = gear.MAbullet,
		head = "Nyame Helm", neck = "Comm. Charm +2", ear1 = "Friomisi Earring", ear2 = "Crematio Earring",
		body = "Lanun Frac +1", hands = "Carmine Fin. Ga. +1", ring1 = "Regal Ring", ring2 = "Dingir Ring",
		back = gear.camulus_wsd, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Lanun Bottes +3"
	}

	sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']

		--Because omen skillchains.
	sets.precast.WS['Burning Blade'] =
	{
		head = "Meghanada Visor +2", neck = "Loricate Torque +1", ear1 = "Genmei Earring", ear2 = "Sanare Earring",
		body = "Meg. Cuirie +2", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Dark Ring",
		back = "Moonlight Cape", waist = "Flume Belt +1", legs = "Meg. Chausses +2", feet = "Meg. Jam. +2"
	}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

	-- Midcast Sets
	sets.midcast.FastRecast =
	{
		head = "Carmine Mask +1", neck= " Baetyl Pendant", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = "Dread Jupon", hands = "Leyline Gloves", ring1 = "Kishar Ring", ring2 = "Lebeche Ring",
		back = "Moonlight Cape", waist = "Flume Belt +1", legs = "Rawhide Trousers", feet = "Carmine Greaves +1"
	}

	-- Specific spells
	sets.midcast.Cure =
	{
		head = "Carmine Mask +1", neck = "Phalaina Locket", ear1 = "Enchntr. Earring +1", ear2 = "Mendi. Earring",
		body = "Dread Jupon", hands = "Leyline Gloves", ring1 = "Janniston Ring", ring2 = "Lebeche Ring",
		back = "Solemnity Cape", waist = "Flume Belt +1", legs = "Carmine Cuisses +1", feet = "Carmine Greaves +1"
	}

	sets.Self_Healing = { neck = "Phalaina Locket", hands = "Buremte Gloves", ring2 = "Kunaji Ring", waist = "Gishdubar Sash" }
	sets.Cure_Received = { neck = "Phalaina Locket", hands = "Buremte Gloves", ring2 = "Kunaji Ring", waist = "Gishdubar Sash" }
	sets.Self_Refresh = { waist = "Gishdubar Sash" }
	
	sets.midcast.Utsusemi = sets.midcast.FastRecast

	-- Ranged gear
	sets.midcast.RA =
	{
		ammo = gear.RAbullet,
		head = "Ikenga's Hat", neck = "Iskur Gorget", ear1 = "Enervating Earring", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Ilabrat Ring", ring2 = "Dingir Ring",
		back = gear.camulus_range_tp, waist = "Impulse Belt", legs = "Ikenga's Trousers", feet = "Malignance Boots"
	}

	sets.buff['Triple Shot'] = { body = "Chasseur's Frac +1" }

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
		head = "Malignance Chapeau", neck = "Comm. Charm +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Gelatinous Ring +1",
		back= gear.camulus_snapshot, waist = "Carrier's Sash", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.idle.PDT =
	{
		ammo = gear.RAbullet,
		head = "Malignance Chapeau", neck = "Comm. Charm +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Gelatinous Ring +1",
		back= gear.camulus_snapshot, waist = "Carrier's Sash", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.idle.Refresh =
	{
		ammo = gear.RAbullet,
		head = "Malignance Chapeau", neck = "Comm. Charm +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Gelatinous Ring +1",
		back= gear.camulus_snapshot, waist = "Carrier's Sash", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	-- Defense sets
	sets.defense.PDT =
	{
		ammo = gear.RAbullet,
		head = "Malignance Chapeau", neck = "Comm. Charm +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Shadow Ring",
		back= gear.camulus_snapshot, waist = "Carrier's Sash", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.defense.MDT =
	{
		ammo = gear.RAbullet,
		head = "Malignance Chapeau", neck = "Comm. Charm +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Shadow Ring",
		back= gear.camulus_snapshot, waist = "Carrier's Sash", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.defense.MEVA =
	{
		ammo = gear.RAbullet,
		head = "Malignance Chapeau", neck = "Comm. Charm +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Shadow Ring",
		back= gear.camulus_snapshot, waist = "Carrier's Sash", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.Kiting = { legs = "Carmine Cuisses +1" }
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.DWMax = { ear1 = "Dudgeon Earring", ear2 = "Heartseeker Earring", body = "Adhemar Jacket +1", hands = "Floral Gauntlets", waist = "Reiki Yotai"}

	-- Weapons sets
	sets.weapons.Default = { main = "Tauret", sub = "Nusku Shield", range = "Molybdosis" }
	sets.weapons.Ranged = { main = "Rostam", sub = "Nusku Shield", range = "Molybdosis" }
	sets.weapons.Savage = { main = "Naegling", sub = "Nusku Shield", range = "Ataktos" }
	sets.weapons.Evisceration = { main = "Tauret", sub = "Nusku Shield", range = "Ataktos" }
	sets.weapons.DualWeapons = { main = "Tauret", sub = "Gleti's Knife", range = "Molybdosis" }
	sets.weapons.DualSavageWeapons = { main = "Naegling", sub = "Gleti's Knife", range = "Ataktos" }
	sets.weapons.DualEvisceration = { main = "Tauret", sub = "Gleti's Knife", range = "Ataktos" }
	sets.weapons.DualLeadenRanged = { main ="Rostam", sub = "Kustawi +1", range = "Molybdosis" }
	sets.weapons.DualLeadenMelee = { main = "Naegling", sub = "Tauret", range = "Molybdosis" }
	sets.weapons.DualAeolian = { main = "Rostam", sub = "Tauret", range = "Ataktos" }
	sets.weapons.DualLeadenMeleeAcc = { main = "Naegling", sub = "Gleti's Knife", range = "Molybdosis" }
	sets.weapons.DualRanged = { main = "Rostam", sub = "Kustawi +1", range = "Molybdosis" }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged =
	{
		head = "Adhemar Bonnet +1", neck = "Iskur Gorget", ear1 = "Telos Earring", ear2 = "Brutal Earring",
		body = "Meg. Cuirie +2", hands = "Adhemar Wrist. +1", ring1 = "Petrov Ring", ring2 = "Epona's Ring",
		back = gear.camulus_melee_tp, waist = "Windbuffet Belt +1", legs = "Samnuha Tights", feet = gear.herculean_ta_feet
	}

	sets.engaged.Acc =
	{
		head = "Adhemar Bonnet +1", neck = "Iskur Gorget", ear1 = "Telos Earring", ear2 = "Brutal Earring",
		body = "Meg. Cuirie +2", hands = "Adhemar Wrist. +1", ring1 = "Petrov Ring", ring2 = "Epona's Ring",
		back = gear.camulus_melee_tp, waist = "Windbuffet Belt +1", legs = "Samnuha Tights", feet = gear.herculean_ta_feet
	}

	sets.engaged.DT =
	{
		head = "Malignance Chapeau", neck = "Iskur Gorget", ear1 = "Telos Earring", ear2 = "Brutal Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Petrov Ring", ring2 = "Epona's Ring",
		back = gear.camulus_melee_tp, waist = "Windbuffet Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.engaged.Acc.DT =
	{
		head = "Malignance Chapeau", neck = "Iskur Gorget", ear1 = "Telos Earring", ear2 = "Brutal Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Petrov Ring", ring2 = "Epona's Ring",
		back = gear.camulus_melee_tp, waist = "Windbuffet Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.engaged.DW =
	{
		head = "Adhemar Bonnet +1", neck = "Iskur Gorget", ear1 = "Suppanomimi", ear2 = "Telos Earring",
		body = "Adhemar Jacket +1", hands = "Adhemar Wrist. +1", ring1 = "Petrov Ring", ring2 = "Epona's Ring",
		back = gear.camulus_melee_tp, waist = "Windbuffet Belt +1", legs = "Samnuha Tights", feet = gear.herculean_ta_feet
	}

	sets.engaged.DW.Acc =
	{
		head = "Adhemar Bonnet +1", neck = "Iskur Gorget", ear1 = "Suppanomimi", ear2 = "Telos Earring",
		body = "Adhemar Jacket +1", hands = "Adhemar Wrist. +1", ring1 = "Petrov Ring", ring2 = "Epona's Ring",
		back = gear.camulus_melee_tp, waist = "Windbuffet Belt +1", legs = "Samnuha Tights", feet = gear.herculean_ta_feet
	}

	sets.engaged.DW.DT =
	{
		head = "Malignance Chapeau", neck = "Iskur Gorget", ear1 = "Suppanomimi", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Petrov Ring", ring2 = "Epona's Ring",
		back = gear.camulus_melee_tp, waist = "Windbuffet Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.engaged.DW.DT =
	{
		head = "Malignance Chapeau", neck = "Iskur Gorget", ear1 = "Suppanomimi", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Petrov Ring", ring2 = "Epona's Ring",
		back = gear.camulus_melee_tp, waist = "Windbuffet Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}
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