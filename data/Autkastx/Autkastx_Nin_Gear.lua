-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	state.OffenseMode:options('Normal', 'Tank', 'H2H', 'GKT')
	state.HybridMode:options('Normal', 'DT', 'Evasion', 'Proc')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Match', 'Normal', 'PDL', 'Proc')
	state.CastingMode:options('Normal', 'Proc', 'Resistant')
	state.IdleMode:options('Normal', 'Evasion')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Naegling', 'NaeglingAcc', 'Kikoku', 'HeishiPhys', 'HeishiMag', 'Magic', 'Tauret', 'GKT', 'Karambit', 'Tank', 'ProcDagger', 'ProcSword', 'ProcGreatSword', 'ProcScythe', 'ProcPolearm', 'ProcGreatKatana', 'ProcKatana', 'ProcClub', 'ProcStaff')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None' }

	gear.Andartia =
	{
		DA = { name = "Andartia's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%' } },
		STR_WSD = { name = "Andartia's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%' } },
		MAB = { name = "Andartia's Mantle", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10' } },
		FC = { name = "Andartia's Mantle", augments = { 'HP+60','Eva.+20 /Mag. Eva.+20', '"Fast Cast"+10', 'Phys. dmg. taken-10%' } },
		Enmity = { name = "Andartia's Mantle", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10', 'Mag. Evasion+15' } }
	}

	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !` gs c cycle Stance')
	send_command('bind ^r gs c weapons Default;gs c reset WeaponskillMode;gs c reset CastingMode;gs c update')
	send_command('bind ^f gs c weapons ProcDagger;gs c set WeaponskillMode Proc;gs c update')
	send_command('bind !backspace input /item "Forbidden Key" <t>')

	utsusemi_cancel_delay = .3
	utsusemi_ni_cancel_delay = .06

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	sets.Enmity =
	{
		ammo = "Date Shuriken",
		head = "Dampening Tam", neck = "Unmoving Collar +1", ear1 = "Cryptic Earring", ear2 = "Trux Earring",
		body = "Emet Harness +1", hands = "Kurys Gloves", ring1 = "Vengeful Ring", ring2 = "Supershear Ring",
		back = gear.Andartia.DA, waist = "Trance Belt", legs = "Zoar Subligar +1", feet = "Mochi. Kyahan +3"
	}

	-- Precast sets to enhance JAs
	sets.precast.JA['Mijin Gakure'] = { legs = "Mochi. Hakama +3" }
	sets.precast.JA['Yonin'] = { head = "Mochi. Hatsuburi +3", legs = "Hattori Hakama +2" }
	sets.precast.JA['Innin'] = { head = "Mochi. Hatsuburi +3" }
	sets.precast.JA['Provoke'] = sets.Enmity

	-- Buff sets
	sets.buff['Futae'] = { hands = "Hattori Tekko +1" }

	-- Waltz set (chr and vit)
	sets.precast.Waltz =
	{
	}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Set for acc on steps, since Yonin drops acc a fair bit
	sets.precast.Step =
	{
	}

	sets.precast.Flourish1 = {}

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		ammo = "Sapience Orb",
		head = gear.herculean_fc_head, neck = "Orunmila's Torque", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = gear.adhemar.body.d, hands = "Leyline Gloves", ring1 = "Kishar Ring", ring2 = "Medada's Ring",
		back = gear.Andartia.FC, waist = "Flume Belt +1"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC,
	{
		neck = "Magoraga Beads",
		body = "Mochi. Chainmail +3",
	})
	sets.precast.FC.Shadows = set_combine(sets.precast.FC.Utsusemi, {})

	-- Snapshot for ranged
	sets.precast.RA = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Rep. Plat. Medal", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Hattori Kyahan +3"
	}

	sets.precast.WS.Proc =
	{
		ammo = "Staunch Tathlum +1",
		head = "Mummu Bonnet +2", neck = "Combatant's Torque", ear1 = "Mache Earring +1", ear2 = "Telos Earring",
		body = "Mummu Jacket +2", hands = "Mummu Wrists +2", ring1 = "Etana Ring", ring2 = "Rufescent Ring",
		back = gear.Andartia.DA, waist = "Engraved Belt", legs = "Mummu Kecks +2", feet = "Malignance Boots"
	}

	sets.precast.WS['Blade: Metsu'] =
	{
		ammo = "Coiste Bodhar",
		head = "Nyame Helm", neck = "Ninja Nodowa +2", ear1 = "Lugra Earring +1", ear2 = "Odr Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Hattori Kyahan +3"
	}
	sets.precast.WS['Blade: Metsu'].PDL = set_combine(sets.precast.WS['Blade: Metsu'],
	{
		ammo = "Crepuscular Pebble",
		head = "Hachiya Hatsu. +3", ear2 = "Hattori Earring +1",
		ring1 = "Sroda Ring", ring2 = "Epaminondas's Ring",
		waist = "Kentarch Belt +1", legs = "Mpaca's Hose",
	})

	sets.precast.WS['Blade: Shun'] =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Moonshade Earring", ear2 = "Hattori Earring +1",
		body = "Malignance Tabard", hands = gear.adhemar.hands.a, ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.DA, waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Hattori Kyahan +3"
	}
	sets.precast.WS['Blade: Shun'].PDL = set_combine(sets.precast.WS['Blade: Shun'],
	{
		ammo = "Crepuscular Pebble",
		head = "Ken. Jinpachi +1", neck = "Ninja Nodowa +2", ear1 = "Lugra Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves",
	})

	sets.precast.WS['Blade: Ten'] =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Rep. Plat. Medal", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Hattori Kyahan +3"
	}
	sets.precast.WS['Blade: Ten'].PDL = set_combine(sets.precast.WS['Blade: Ten'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Ninja Nodowa +2", ear1 = "Moonshade Earring", ear2 = "Hattori Earring +1",
		ring1 = "Sroda Ring", ring2 = "Epaminondas's Ring",
	})

	sets.precast.WS['Blade: Kamu'] =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Ninja Nodowa +2", ear1 = "Lugra Earring +1", ear2 = "Hattori Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.STR_WSD, waist = "Sailfi Belt +1", legs = "Mpaca's Hose", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Blade: Kamu'].PDL = set_combine(sets.precast.WS['Blade: Kamu'],
	{
		ammo = "Crepuscular Pebble",
		ring2 = "Sroda Ring"
	})

	sets.precast.WS['Blade: Hi'] =
	{
		ammo = "Yetshila +1",
		head = "Hachiya Hatsu. +3", neck = "Ninja Nodowa +2", ear1 = "Lugra Earring +1", ear2 = "Odr Earring",
		body = "Hattori Ningi +2", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.STR_WSD, waist = "Svelt. Gouriz +1", legs = "Nyame Flanchard", feet = "Hattori Kyahan +3"
	}
	sets.precast.WS['Blade: Hi'].PDL = set_combine(sets.precast.WS['Blade: Hi'],
	{
		body = "Nyame Mail", ring1 = "Sroda Ring", ring2 = "Epaminondas's Ring",
		legs = "Mpaca's Hose",
	})

	sets.precast.WS['Blade: Ku'] =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Brutal Earring",
		body = "Nyame Mail", hands = "Mochizuki Tekko +3", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.DA, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Hattori Kyahan +3"
	}
	sets.precast.WS['Blade: Ku'].PDL = set_combine(sets.precast.WS['Blade: Ku'],
	{
		ear2 = "Hattori Earring +1",
		hands = "Malignance Gloves", ring2 = "Sroda Ring",
		legs = "Mpaca's Hose",
	})

	sets.precast.WS['Blade: Chi'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Mochi. Hatsuburi +3", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Epaminondas's Ring",
		back = gear.Andartia.STR_WSD, waist = "Orpheus's Sash", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Blade: To'] = sets.precast.WS['Blade: Chi']
	sets.precast.WS['Blade: Teki'] = sets.precast.WS['Blade: Chi']

	sets.precast.WS['Blade: Ei'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Pixie Hairpin +1", neck = "Sibyl Scarf", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Archon Ring", ring2 = "Epaminondas's Ring",
		back = gear.Andartia.MAB, waist = "Orpheus's Sash", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Blade: Yu'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Mochi. Hatsuburi +3", neck = "Sibyl Scarf", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Medada's Ring",
		back =gear.Andartia.MAB, waist = "Orpheus's Sash", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Blade: Jin'] =
	{
		ammo = "Yetshila +1",
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Odr Earring",
		body = "Ken. Samue +1", hands = "Ryuo Tekko +1", ring1 = "Ilabrat Ring", ring2 = "Regal Ring",
		back = gear.Andartia.DA, waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Blade: Rin'] =
	{
		ammo = "Yetshila +1",
		head = "Hachiya Hatsu. +3", neck = "Ninja Nodowa +2", ear1 = "Lugra Earring +1", ear2 = "Odr Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.STR_WSD, waist = "Sailfi Belt +1", legs = "Mochi. Hakama +3", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Blade: Retsu'] =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Ninja Nodowa +2", ear1 = "Crep. Earring", ear2 = "Digni. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Etana Ring", ring2 = "Regal Ring",
		back = gear.Andartia.STR_WSD, waist = "Eschan Stone", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Savage Blade'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Mpaca's Cap", neck = "Rep. Plat. Medal", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Beithir Ring",
		back = gear.Andartia.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Hattori Kyahan +3"
	}
	sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS['Savage Blade'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Ninja Nodowa +2", ear1 = "Moonshade Earring", ear2 = "Hattori Earring +1",
		ring2 = "Sroda Ring", ring2 = "Epaminondas's Ring",
	})

	sets.precast.WS['Sanguine Blade'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Pixie Hairpin +1", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Archon Ring", ring2 = "Medada's Ring",
		back = gear.Andartia.MAB, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Red Lotus Blade'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Mochi. Hatsuburi +3", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Medada's Ring",
		back = gear.Andartia.MAB, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Burning Blade'] = {}

	sets.precast.WS['Seraph Blade'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Mochi. Hatsuburi +3", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Medada's Ring",
		back =gear.Andartia.MAB, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Shining Blade'] = {}

	sets.precast.WS['Flat Blade'] =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Ninja Nodowa +2", ear1 = "Crep. Earring", ear2 = "Digni. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Etana Ring", ring2 = "Medada's Ring",
		back = gear.Andartia.STR_WSD, waist = "Eschan Stone", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Vorpal Blade'] =
	{
		ammo = "Yetshila +1",
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Odr Earring",
		body = "Ken. Samue +1", hands = "Ryuo Tekko +1", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.DA, waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Evisceration'] =
	{
		ammo = "Yetshila +1",
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Odr Earring",
		body = "Ken. Samue +1", hands = "Ryuo Tekko +1", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.DA, waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Aeolian Edge'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Mochi. Hatsuburi +3", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Medada's Ring",
		back = gear.Andartia.MAB, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Asuran Fists'] =
	{
		ammo = "Voluspa Tathlum",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Telos Earring",
		body = "Mochi. Chainmail +3", hands = "Mochizuki Tekko +3", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.STR_WSD, waist = "Fotia Belt", legs = "Mochi. Hakama +3", feet = "Mochi. Kyahan +3"
	}
	sets.precast.WS['Asuran Fists'].PDL = set_combine(sets.precast.WS['Asuran Fists'],
	{
		head = "Malignance Chapeau",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring2 = "Sroda Ring",
		legs = "Malignance Tights", feet = "Malignance Boots"
	})

	sets.precast.WS['Raging Fists'] =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Mpaca's Doublet", hands = "Mochizuki Tekko +3", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.DA, waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Mochi. Kyahan +3"
	}
	sets.precast.WS['Raging Fists'].PDL = set_combine(sets.precast.WS['Raging Fists'],
	{
		ammo = "Crepuscular Pebble",
		body = "Ken. Samue +1", hands = gear.adhemar.hands.b, ring2 = "Sroda Ring",
		feet = "Mpaca's Boots"
	})

	sets.precast.WS['Combo'] =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Mpaca's Doublet", hands = "Mochizuki Tekko +3", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.DA, waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Mochi. Kyahan +3"
	}
	sets.precast.WS['Combo'].PDL = set_combine(sets.precast.WS['Combo'],
	{
		ammo = "Crepuscular Pebble",
		body = "Ken. Samue +1", hands = gear.adhemar.hands.b, ring2 = "Sroda Ring",
		feet = "Mpaca's Boots"
	})

	sets.precast.WS['Shoulder Tackle'] =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Ninja Nodowa +2", ear1 = "Crep. Earring", ear2 = "Digni. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Etana Ring", ring2 = "Medada's Ring",
		back = gear.Andartia.STR_WSD, waist = "Eschan Stone", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Spinning Attack'] =
	{
		ammo = "Voluspa Tathlum",
		head = "Mpaca's Cap", neck = "Rep. Plat. Medal", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.STR_WSD, waist = "Sailfi Belt +1", legs = "Mochi. Hakama +3", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Spinning Attack'].PDL = set_combine(sets.precast.WS['Spinning Attack'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Ninja Nodowa +2",
		ring2 = "Sroda Ring",
	})

	sets.precast.WS['Tachi: Kasha'] =
	{
		ammo = "Voluspa Tathlum",
		head = "Mpaca's Cap", neck = "Rep. Plat. Medal", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.STR_WSD, waist = "Sailfi Belt +1", legs = "Mochi. Hakama +3", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Tachi: Kasha'].PDL = set_combine(sets.precast.WS['Tashi: Kasha'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Ninja Nodowa +2",
		ring2 = "Sroda Ring"
	})

	sets.precast.WS['Tachi: Jinpu'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Medada's Ring",
		back = gear.Andartia.STR_WSD, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Tachi: Ageha'] =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Ninja Nodowa +2", ear1 = "Crep. Earring", ear2 = "Digni. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Etana Ring", ring2 = "Medada's Ring",
		back = gear.Andartia.STR_WSD, waist = "Eschan Stone", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Tachi: Hobaku'] =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Ninja Nodowa +2", ear1 = "Crep. Earring", ear2 = "Digni. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Etana Ring", ring2 = "Medada's Ring",
		back = gear.Andartia.STR_WSD, waist = "Eschan Stone", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Tachi: Kagero'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Medada's Ring",
		back = gear.Andartia.STR_WSD, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Tachi: Koki'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Medada's Ring",
		back = gear.Andartia.STR_WSD, waist = "Fotia Gorget", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Tachi: Enpi'] =
	{
		ammo = "Voluspa Tathlum",
		head = "Mpaca's Cap", neck = "Rep. Plat. Medal", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.Andartia.STR_WSD, waist = "Sailfi Belt +1", legs = "Mochi. Hakama +3", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Tachi: Enpi'].PDL = set_combine(sets.precast.WS['Tachi: Enpi'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Ninja Nodowa +2",
		ring2 = "Sroda Ring"
	})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {}
	sets.AccDayWSEars = {}
	sets.DayWSEars = {}

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

	sets.midcast.ElementalNinjutsu =
	{
		ammo = "Pemphredo Tathlum",
		head = "Mochi. Hatsuburi +3", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Crematio Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Dingir Ring", ring2 = "Medada's Ring",
		back = gear.Andartia.MAB, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Mochi. Kyahan +3"
	}

	sets.midcast.ElementalNinjutsu.Proc = sets.midcast.FastRecast
	sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {})

	sets.MagicBurst =
	{
		ring1 = "Locus Ring", ring2 = "Mujin Band",
	}

	sets.midcast.NinjutsuDebuff =
	{
		ammo = "Yamarang",
		head = "Hachiya Hatsu. +3", neck = "Sanctity Necklace", ear1 = "Crep. Earring", ear2 = "Digni. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Stikini Ring +1", ring2 = "Regal Ring",
		back = gear.Andartia.MAB, waist = "Eschan Stone", legs = "Malignance Tights", feet = "Mochi. Kyahan +3"
	}

	sets.midcast.NinjutsuBuff =
	{
		ammo = "Sapience Orb",
		head = "Hachiya Hatsu. +3", neck = "Incanter's Torque", ear1 = "Hnoss earring", ear2 = "Stealth Earring",
		body = gear.adhemar.body.d, hands = "Leyline Gloves", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = gear.Andartia.FC, waist = "Cimmerian Sash", feet = "Mochi. Kyahan +3"
	}

	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, { feet = "Hattori Kyahan +3" })

	sets.midcast.RA =
	{
		head = "Malignance Chapeau", neck = "Iskur Gorget", ear1 = "Enervating Earring", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Crepuscular Ring", ring2 = "Regal Ring",
		back = gear.Andartia.DA, waist = "Chaac Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------
	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle =
	{
		ammo = "Yamarang",
		head = "Nyame Helm", neck = "Loricate Torque +1", ear1 = "Eabani Earring", ear2 = "Etiolation Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Defending Ring", ring2 = "Shadow Ring",
		back = gear.Andartia.Enmity, waist = "Engraved Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.idle.Evasion =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Loricate Torque +1", ear1 = "Eabani Earring", ear2 = "Balder Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Shadow Ring",
		back = gear.Andartia.Enmity, waist = "Engraved Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.defense.PDT = {}
	sets.defense.MDT = {}
	sets.defense.MEVA = {}

	sets.Kiting = { feet = "Danzo Sune-Ate" }
	sets.DuskKiting = sets.Kiting
	sets.DuskIdle = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

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
		ammo = "Seki Shuriken",
		head = "Dampening Tam", neck = "Ninja Nodowa +2", ear1 = "Cessance Earring", ear2 = "Telos Earring",
		body = "Ken. Samue +1", hands = gear.adhemar.hands.a, ring1 = "Gere Ring", ring2 = "Epona's Ring",
		back = gear.Andartia.DA, waist = "Windbuffet Belt +1", legs = "Samnuha Tights", feet = gear.herculean_ta_feet
	}
	sets.engaged.Haste30 = set_combine(sets.engaged,
	{
		head = "Hattori Zukin +2", ear1 = "Eabani Earring", ear2 = "Brutal Earring",
		waist = "Reiki Yotai"
	})
	sets.engaged.Haste15 = set_combine(sets.engaged.Haste30,
	{
		ear2 = "Telos Earring",
		body = "Mochi. Chainmail +3",
		legs = "Hachiya Hakama +2"
	})
	sets.engaged.Haste0 = set_combine(sets.engaged.Haste15,
	{
		legs = "Mochi. Hakama +3"
	})

	sets.engaged.DT =
	{
		ammo = "Seki Shuriken",
		head = "Malignance Chapeau", neck = "Ninja Nodowa +2", ear1 = "Cessance Earring", ear2 = "Telos Earring",
		body = "Mpaca's Doublet", hands = "Malignance Gloves", ring1 = "Epona's Ring", ring2 = "Defending Ring",
		back = gear.Andartia.DA, waist = "Engraved Belt", legs = "Mpaca's Hose", feet = "Malignance Boots"
	}
	sets.engaged.DT.Haste30 = set_combine(sets.engaged.DT,
	{
		head = "Hattori Zukin +2", ear1 = "Eabani Earring", ear2 = "Brutal Earring",
		waist = "Reiki Yotai"
	})
	sets.engaged.DT.Haste15 = set_combine(sets.engaged.DT.Haste30,
	{
		ear2 = "Telos Earring",
		body = "Mochi. Chainmail +3",
		legs = "Hachiya Hakama +2"
	})
	sets.engaged.DT.Haste0 = set_combine(sets.engaged.DT.Haste15,
	{
		legs = "Mochi. Hakama +3"
	})

	sets.engaged.Evasion =
	{
		ammo = "Seki Shuriken",
		head = "Malignance Chapeau", neck = "Ninja Nodowa +2", ear1 = "Cessance Earring", ear2 = "Balder Earring +1",
		body = "Mpaca's Doublet", hands = "Malignance Gloves", ring1 = "Vengeful Ring", ring2 = "Ilabrat Ring",
		back = gear.Andartia.DA, waist = "Sailfi Belt +1", legs = "Mpaca's Hose", feet = "Malignance Boots"
	}
	sets.engaged.Evasion.Haste30 = set_combine(sets.engaged.Evasion,
	{
		ear1 = "Eabani Earring",
		waist = "Reiki Yotai", legs = "Malignance Tights"
	})
	sets.engaged.Evasion.Haste15 = set_combine(sets.engaged.Evasion.Haste30,
	{
		ear2 = "Suppanomimi",
		body = "Mochi. Chainmail +3", ring2 = "Regal Ring",
		legs = "Hachiya Hakama +2"
	})
	sets.engaged.Evasion.Haste0 = set_combine(sets.engaged.Evasion.Haste15,
	{
		legs = "Mochi. Hakama +3"
	})

	sets.engaged.Tank =
	{
		ammo = "Date Shuriken",
		head = "Dampening Tam", neck = "Ninja Nodowa +2", ear1 = "Cryptic Earring", ear2 = "Trux Earring",
		body = "Ken. Samue +1", hands = gear.adhemar.hands.a, ring1 = "Gere Ring", ring2 = "Eihwaz Ring",
		back = gear.Andartia.DA, waist = "Windbuffet Belt +1", legs = "Samnuha Tights", feet = gear.herculean_ta_feet
	}
	sets.engaged.Tank.Haste30 = set_combine(sets.engaged.Tank,
	{
		head = "Hattori Zukin +2", ear1 = "Eabani Earring",
		waist = "Reiki Yotai",
	})
	sets.engaged.Tank.Haste15 = set_combine(sets.engaged.Tank.Haste30,
	{
		body = "Mochi. Chainmail +3",
		legs = "Hachiya Hakama +2",
	})
	sets.engaged.Tank.Haste0 = set_combine(sets.engaged.Tank.Haste15,
	{
		legs = "Mochi. Hakama +3"
	})

	sets.engaged.Tank.DT =
	{
		ammo = "Date Shuriken",
		head = "Malignance Chapeau", neck = "Ninja Nodowa +2", ear1 = "Cryptic Earring", ear2 = "Trux Earring",
		body = "Mpaca's Doublet", hands = gear.adhemar.hands.a, ring1 = "Pernicious Ring", ring2 = "Defending Ring",
		back = gear.Andartia.Enmity, waist = "Engraved Belt", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}
	sets.engaged.Tank.DT.Haste30 = set_combine(sets.engaged.Tank.DT,
	{
		head = "Hattori Zukin +2", ear1 = "Eabani Earring",
		waist = "Reiki Yotai", feet = "Malignance Boots"
	})
	sets.engaged.Tank.DT.Haste15 = set_combine(sets.engaged.Tank.Haste30,
	{
		body = "Mochi. Chainmail +3", hands = "Mpaca's Gloves",
		legs = "Hachiya Hakama +2", feet = "Mpaca's Boots"
	})
	sets.engaged.Tank.DT.Haste0 = set_combine(sets.engaged.Tank.Haste15,
	{
		legs = "Mochi. Hakama +3"
	})

	sets.engaged.Tank.Evasion =
	{
		ammo = "Date Shuriken",
		head = "Malignance Chapeau", neck = "Bathy Choker +1", ear1 = "Eabani Earring", ear2 = "Balder Earring +1",
		body = "Mpaca's Doublet", hands = "Nyame Gauntlets", ring1 = "Vengeful Ring", ring2 = "Defending Ring",
		back = gear.Andartia.Enmity, waist = "Svelt. Gouriz +1", legs = "Mpaca's Hose", feet = "Nyame Sollerets"
	}
	sets.engaged.Tank.Evasion.Haste30 = set_combine(sets.engaged.Tank.Evasion,
	{
		head = "Hattori Zukin +2",
		body = "Mochi. Chainmail +3", hands = "Malignance Gloves",
		legs = "Malignance Tights"
	})
	sets.engaged.Tank.Evasion.Haste15 = set_combine(sets.engaged.Tank.Evasion.Haste30,
	{
		ear2 = "Suppanomimi",
		ring2 = "Regal Ring",
		legs = "Hachiya Hakama +2", feet = "Malignance Boots"
	})
	sets.engaged.Tank.Evasion.Haste0 = set_combine(sets.engaged.Tank.Evasion.Haste15,
	{
		ring2 = "Ilabrat Ring",
		legs = "Mochi. Hakama +3"
	})

	sets.engaged.H2H =
	{
		ammo = "Seki Shuriken",
		head = "Hiza. Somen +2", neck = "Ninja Nodowa +2", ear1 = "Mache Earring +1", ear2 = "Mache Earring +1",
		body = "Ken. Samue +1", hands = gear.adhemar.hands.a, ring1 = "Gere Ring", ring2 = "Epona's Ring",
		back = gear.Andartia.DA, waist = "Windbuffet Belt +1", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}
	sets.engaged.H2H.DT = set_combine(sets.engaged.H2H,
	{
		body = "Mpaca's Doublet", ring1 = "Defending Ring",
	})
	sets.engaged.H2H.Evasion = set_combine(sets.engaged.H2H.DT,
	{
		neck = "Bathy Choker +1",
		hands = "Malignance Gloves", ring1 = "Vengeful Ring", ring2 = "Ilabrat Ring",
		back = gear.Andartia.Enmity, waist = "Svelt. Gouriz +1", feet = "Malignance Boots"
	})

	sets.engaged.GKT =
	{
		ammo = "Seki Shuriken",
		head = "Dampening Tam", neck = "Ninja Nodowa +2", ear1 = "Crep. Earring", ear2 = "Telos Earring",
		body = "Ken. Samue +1", hands = gear.herculean_ta_hands, ring1 = "Gere Ring", ring2 = "Epona's Ring",
		back = gear.Andartia.DA, waist = "Windbuffet Belt +1", legs = "Samnuha Tights", feet = gear.herculean_ta_feet
	}
	sets.engaged.GKT.DT = set_combine(sets.engaged.GKT,
	{
		head = "Malignance Chapeau",
		body = "Mpaca's Doublet", hands = "Malignance Gloves", ring1 = "Defending Ring",
		legs = "Mpaca's Hose", feet = "Malignance Boots"
	})	
	sets.engaged.GKT.Evasion = set_combine(sets.engaged.GKT.DT,
	{
		ear1 = "Eabani Earring", ear2 = "Balder Earring +1",
		hands = "Malignance Gloves", ring1 = "Vengeful Ring", ring2 = "Ilabrat Ring",
		waist = "Svelt. Gouriz +1"
	})

	sets.engaged.Proc = set_combine(sets.engaged, { ammo = "Staunch Tathlum +1" })

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Migawari = {} -- body = "Hattori Ningi +1"
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Futae = { hands = "Hattori Tekko +1" }
	sets.buff.Yonin = { legs = "Hattori Hakama +2" }
	sets.buff.Innin = { head = "Hattori Zukin +2" }

	-- Extra Melee sets.  Apply these on top of melee sets.
	sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter,
	{
		ammo = "Per. Lucky Egg",
		hands = "Volte Bracers",
		waist = "Chaac Belt", legs = "Volte Hose",
	})
	sets.Skillchain = {}

	-- Weapons sets
	sets.weapons.Naegling = { main = "Naegling", sub = "Hitaki" }
	sets.weapons.NaeglingAcc = { main = "Naegling", sub = "Kunimitsu" }
	sets.weapons.Kikoku = { main = "Kikoku", sub = "Kunimitsu" }
	sets.weapons.HeishiPhys = { main = "Heishi Shorinken", sub = "Gleti's Knife" }
	sets.weapons.HeishiMag = { main = "Heishi Shorinken", sub = "Kunimitsu" }
	sets.weapons.Magic = { main = "Gokotai", sub = "Kunimitsu" }
	sets.weapons.Tauret = { main = "Tauret", sub = "Kunimitsu" }
	sets.weapons.GKT = { main = "Hachimonji", sub = "Bloodrain Strap" }
	sets.weapons.Karambit = { main = "Karambit" }
	sets.weapons.Tank = { main = "Fudo Masamune", sub = "Tsuru" }
	sets.weapons.ProcDagger = { main = "Ceremonial Dagger", sub = "Yagyu Short. +1" }
	sets.weapons.ProcSword = { main = "Twinned Blade", sub = "Yagyu Short. +1" }
	sets.weapons.ProcGreatSword = { main = "Ophidian Sword", sub = "Bloodrain Strap" }
	sets.weapons.ProcScythe = { main = "Hoe", sub = "Bloodrain Strap" }
	sets.weapons.ProcPolearm = { main = "Iapetus", sub = "Bloodrain Strap" }
	sets.weapons.ProcGreatKatana = { main = "Mutsunokami", sub = "Bloodrain Strap" }
	sets.weapons.ProcKatana = { main = "Yagyu Short. +1", sub = "Ceremonial Dagger" }
	sets.weapons.ProcClub = { main = "Thunder Hammer", sub = "Ceremonial Dagger" }
	sets.weapons.ProcStaff = { main = "Ram Staff", sub = "Bloodrain Strap" }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 3)
	elseif player.sub_job == 'RNG' then
		set_macro_page(1, 3)
	elseif player.sub_job == 'RDM' then
		set_macro_page(1, 3)
	else
		set_macro_page(1, 3)
	end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 004')
end