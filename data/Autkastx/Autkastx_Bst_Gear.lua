function user_job_setup()
	state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal', 'Pet')
	state.WeaponskillMode:options('Match', 'Normal', 'PDL', 'SubtleBlow', 'Proc')
	state.CastingMode:options('Normal')
	state.IdleMode:options('Normal')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PetPDT', 'PDT', 'Reraise', 'PKiller')
	state.MagicalDefenseMode:options('PetMDT', 'MDT', 'MKiller')
	state.ResistDefenseMode:options('PetMEVA', 'MEVA')
	state.Weapons:options('None', 'Aymur', 'Pangu', 'Dolichenus', 'Naegling', 'Drepanum', 'DualAymur', 'DualPangu', 'DualDolichenus', 'DualNaegling')
	state.ExtraMeleeMode = M{ ['description']='Extra Melee Mode','None' }

	-- Set up Jug Pet cycling and keybind Ctrl+F7
	-- INPUT PREFERRED JUG PETS HERE
	state.JugMode = M{['description']='Jug Mode','GenerousArthur','CaringKiyomaro','FatsoFargann','ScissorlegXerin','BlackbeardRandy','AttentiveIbuki','DroopyDortwin','WarlikePatrick','AcuexFamiliar'}
	send_command('bind ^f7 gs c cycle JugMode')

	-- Set up Monster Correlation Modes and keybind Alt+F7
	state.CorrelationMode = M(false, 'Correlation Mode')
	send_command('bind !f7 gs c toggle CorrelationMode')

	-- Set up Pet Modes for Hybrid sets and keybind 'Windows Key'+F7
	state.PetMode = M{ ['description'] = 'Pet Mode', 'DD', 'DT' }
	send_command('bind @f7 gs c cycle PetMode')

	-- Set up Reward Modes and keybind Ctrl+Backspace
	state.RewardMode = M{ ['description'] = 'Reward Mode', 'Theta', 'Zeta', 'Eta' }
	send_command('bind ^backspace gs c cycle RewardMode')

	send_command('bind @f8 gs c toggle AutoReadyMode')
	send_command('bind !` gs c ready default')

	--Example of how to change default ready moves.
	--ready_moves.default.WarlikePatrick = 'Tail Blow'

	gear.Artio =
	{
		Idle = { name = "Artio's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Store TP"+10', 'Damage taken-5%' } },
		STP = { name = "Artio's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Store TP"+10', 'Damage taken-5%' } },
		DA = { name = "Artio's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dbl.Atk."+10', 'Damage taken-5%' } },
		Pet_Idle = { name = "Artio's Mantle", augments = { 'Pet: M.Acc.+20 Pet: M.Dmg.+20', 'Eva.+20 /Mag. Eva.+20', 'Pet: Mag. Acc.+10', '"Cure" potency +10%', 'Damage taken-5%' } },
		Pet_Macc = { name = "Artio's Mantle", augmnents = { 'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20', 'Eva.+20 /Mag. Eva.+20', 'Pet: Accuracy+10 Pet: Rng. Acc.+10', 'Pet: Haste+10', 'Pet: Damage taken -5%' } },
		STR_WSD = { name = "Artio's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Damage taken-5%' } },
		MND_WSD = { name = "Artio's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Damage taken-5%' } },
		CHR_WSD = { name = "Artio's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Damage taken-5%' } },
	}

	select_default_macro_book()
end

-- BST gearsets
function init_gear_sets()
	-- PRECAST SETS
	sets.precast.JA['Killer Instinct'] = { head = "Ankusa Helm +3" }
	sets.precast.JA['Call Beast'] =
	{
		head = gear.acro.head.call_beast, neck = "Loricate Torque +1", ear1 = "Eabani Earring", ear2 = "Sanare Earring",
		body = "Mirke Wardecors", hands = "Ankusa Gloves +3", ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = gear.Artio.FC, waist = "Flume Belt +1", legs = gear.acro.legs.call_beast, feet = gear.acro.feet.call_beast
	}
	sets.precast.JA['Bestial Loyalty'] = set_combine(sets.precast.JA['Call Beast'], {})

	sets.precast.JA.Familiar = { legs = "Ankusa Trousers +3" }
	sets.precast.JA.Spur = { main = "Skullrender", sub = "Skullrender", back = gear.Artio.Idle, feet = "Nukumi Ocreae +1" }

	sets.precast.JA['Feral Howl'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Malignance Chapeau", neck = "Sanctity Necklace", ear1 = "Crep. Earring", ear2 = "Digni. Earring",
		body = "Ankusa Jackcoat +3", hands = "Malignance Gloves", ring1 = "Metamor. Ring +1", ring2 = "Stikini Ring +1",
		back = gear.Artio.CHR_WSD, waist = "Eschan Stone", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.JA.Reward =
	{
		ammo = "Pet Food Theta",
		head = "Stout Bonnet", neck = "Unmoving Collar +1", ear1 = "Eabani Earring", ear2 = "Enmerkar Earring",
		body = "Totemic Jackcoat +3", hands = "Malignance Gloves", ring1 = "Metamor. Ring +1", ring2 = "Stikini Ring +1",
		back = gear.Artio.MND_WSD, waist = "Engraved Belt", legs = "Ankusa Trousers +3", feet = "Ankusa Gaiters +3"
	}

	sets.precast.JA.Charm =
	{
		ammo = "Pemphredo Tathlum",
		head = "Ankusa Helm +3", neck = "Bst. Collar +2", ear1 = "Crep. Earring", ear2 = "Enchantr. Earring +1",
		body = "Ankusa Jackcoat +3", hands = "Ankusa Gloves +3", ring1 = "Metamor. Ring +1", ring2 = "Stikini Ring +1",
		back = gear.Artio.CHR_WSD, waist = "Eschan Stone", legs = "Ankusa Trousers +3", feet = "Ankusa Gaiters +3"
	}

	sets.precast.JA.Ready = { legs = "Gleti's Breeches" }

	-- CURING WALTZ
	sets.precast.Waltz =
	{
		ammo = "Voluspa Tathlum",
		head = "Anwig Salade", neck = "Unmoving Collar +1", ear1 = "Handler's Earring +1", ear2 = "Enchantr. Earring +1",
		body = "Gleti's Cuirass", hands = "Gleti's Gauntlets", ring1 = "Metamor. Ring +1",
		back = gear.Artio.CHR_WSD, waist = "Flume Belt +1", legs = "Dashing Subligar", feet = "Nyame Sollerets"
	}

		-- HEALING WALTZ
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.FC =
	{
		main = "Shukuyu's Scythe", sub = "Bloodrain Strap", ammo = "Sapience Orb",
		head = "Nyame Helm", neck = "Orunmila's Torque", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = "Sacro Breastplate", hands = "Leyline Gloves", ring1 = "Medada's Ring", ring2 = "Rahab Ring",
		back = gear.Artio.FC, waist = "Flume Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck = "Magoraga Beads" })

		-- MIDCAST SETS
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

	sets.midcast.Cure = set_combine(sets.midcast.FastRecast,
	{
		neck = "Incanter's Torque",
		body = "Jumalik Mail", hands = "Nyame Gauntlets", ring2 = "Menelaus's Ring",
		back = gear.Artio.Pet_Macc, waist = "Tempus Fugit"
	})
	sets.midcast.Curaga = sets.midcast.Cure

	sets.Self_Refresh = { waist = "Gishdubar Sash" }
	sets.midcast.Stoneskin = sets.midcast.FastRecast
	sets.midcast.Cursna = set_combine(sets.midcast.FastRecast,
	{
		neck = "Debilis Medallion",
		ring1 = "Haoma's Ring", ring2 = "Menelaus's Ring",
		waist = "Tempus Fugit"
	})

	sets.midcast.Protect = set_combine(sets.midcast.FastRecast, { ring2 = "Sheltered Ring" })
	sets.midcast.Protectra = sets.midcast.Protect

	sets.midcast.Shell = set_combine(sets.midcast.FastRecast, { ring2 = "Sheltered Ring" })
	sets.midcast.Shellra = sets.midcast.Shell

	sets.midcast['Enfeebling Magic'] = sets.midcast.FastRecast

	sets.midcast['Elemental Magic'] = sets.midcast.FastRecast

	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic']

		-- WEAPONSKILLS
		-- Default weaponskill sets.
	sets.precast.WS =
	{
		ammo = "Coiste Bodhar",
		head = "Nyame Helm", neck = "Bst. Collar +2", ear1 = "Thrud Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Gere Ring",
		back = gear.Artio.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS.PDL = set_combine(sets.precast.WS,
	{
		ammo = "Crepuscular Pebble",
		body = "Gleti's Cuirass", ring1 = "Sroda Ring"
	})

	sets.SubtleBlow = { neck = "Bathy Choker +1", ring2 = "Chirich Ring +1" }

	sets.precast.WS['Subtle Blow'] = set_combine(sets.precast.WS, sets.SubtleBlow)

	-- Specific weaponskill sets.
	sets.precast.WS['Mistral Axe'] =
	{
		ammo = "Coiste Bodhar",
		head = "Nyame Helm", neck = "Bst. Collar +2", ear1 = "Thrud Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Gere Ring",
		back = gear.Artio.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Mistral Axe'].PDL = set_combine(sets.precast.WS['Mistral Axe'],
	{
		ammo = "Crepuscular Pebble",
		body = "Gleti's Cuirass", ring1 = "Sroda Ring"
	})
	sets.precast.WS['Mistral Axe']['Subtle Blow'] = set_combine(sets.precast.WS['Mistral Axe'], sets.SubtleBlow)

	sets.precast.WS['Calamity'] =
	{
		ammo = "Coiste Bodhar",
		head = "Nyame Helm", neck = "Bst. Collar +2", ear1 = "Thrud Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Gere Ring",
		back = gear.Artio.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets",
	}
	sets.precast.WS['Calamity'].PDL = set_combine(sets.precast.WS['Calamity'],
	{
		ammo = "Crepuscular Pebble",
		body = "Gleti's Cuirass", ring1 = "Sroda Ring",
	})
	sets.precast.WS['Calamity']['Subtle Blow'] = set_combine(sets.precast.WS['Calamity'], sets.SubtleBlow)

	sets.precast.WS['Decimation'] =
	{
		ammo = "Coiste Bodhar",
		head = "Blistering Sallet +1", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Lugra Earring +1",
		body = "Tali'ah Manteel +2", hands = "Nyame Gauntlets", ring1 = "Epona's Ring", ring2 = "Gere Ring",
		back = gear.Artio.DA, waist = "Fotia Belt", legs = "Meghanada Chausses +2", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Decimation'].PDL = set_combine(sets.precast.WS['Decimation'],
	{
		ammo = "Crepuscular Pebble",
		head = "Gleti's Mask", neck = "Bst. Collar +2",
		hands = "Gleti's Gauntlets", ring1 = "Sroda Ring",
		feet = "Gleti's Boots"
	})
	sets.precast.WS['Decimation']['Subtle Blow'] = set_combine(sets.precast.WS['Decimation'], sets.SubtleBlow)

	sets.precast.WS['Ruinator'] =
	{
		ammo = "Coiste Bodhar",
		head = "Blistering Sallet +1", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Lugra Earring +1",
		body = "Tali'ah Manteel +2", hands = "Nyame Gauntlets", ring1 = "Epona's Ring", ring2 = "Gere Ring",
		back = gear.Artio.DA, waist = "Fotia Belt", legs = "Meghanada Chausses +2", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Ruinator'].PDL = set_combine(sets.precast.WS['Ruinator'],
	{
		ammo = "Crepuscular Pebble",
		head = "Gleti's Mask", neck = "Bst. Collar +2",
		body = "Gleti's Cuirass", hands = "Gleti's Gauntlets", ring1 = "Sroda Ring",
		legs = "Gleti's Breeches", feet = "Gleti's Boots"
	})
	sets.precast.WS['Ruinator']['Subtle Blow'] = set_combine(sets.precast.WS['Ruinator'], sets.SubtleBlow)

	sets.precast.WS['Onslaught'] =
	{
		ammo = "Coiste Bodhar",
		head = "Ankusa Helm +3", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Lugra Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Epaminondas's Ring",
		back = gear.Artio.STR_WSD, waist = "Fotia Belt", legs = "Lustratio Subligar +1", feet = "Lustratio Leggings +1"
	}
	sets.precast.WS['Onslaught'].PDL = set_combine(sets.precast.WS['Onslaught'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Bst. Collar +2",
		body = "Gleti's Cuirass", ring1 = "Sroda Ring",
		legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	})
	sets.precast.WS['Onslaught']['Subtle Blow'] = set_combine(sets.precast.WS['Onslaught'], sets.SubtleBlow)

	sets.precast.WS['Bora Axe'] =
	{
		ammo = "Coiste Bodhar",
		head = "Ankusa Helm +3", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Lugra Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Gere Ring",
		back = gear.Artio.STR_WSD, waist = "Grunfeld Rope", legs = "Lustratio Subligar +1", feet = "Lustratio Leggings +1"
	}
	sets.precast.WS['Bora Axe'].PDL = set_combine(sets.precast.WS['Bora Axe'],
	{
		ammo = "Crepuscular Pebble",
		neck = "Bst. Collar +2",
		body = "Gleti's Cuirass", ring1 = "Sroda Ring",
		legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	})
	sets.precast.WS['Bora Axe']['Subtle Blow'] = set_combine(sets.precast.WS['Bora Axe'], sets.SubtleBlow)

	sets.precast.WS['Primal Rend'] =
	{
		ammo = "Ghastly Tathlum +1",
		head = "Nyame Helm", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Medada's Ring",
		back = gear.Artio.CHR_WSD, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Primal Rend']['Subtle Blow'] = set_combine(sets.precast.WS['Primal Rend'], sets.SubtleBlow)

	sets.precast.WS['Cloudsplitter'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Nyame Helm", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Medada's Ring",
		back = gear.Artio.MND_WSD, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Cloudsplitter']['Subtle Blow'] = set_combine(sets.precast.WS['Cloudsplitter'], sets.SubtleBlow)

	sets.precast.WS['Rampage'] =
	{
		ammo = "Coiste Bodhar",
		head = "Blistering Sallet +1", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Lugra Earring +1",
		body = "Gleti's Cuirass", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Gere Ring",
		back = gear.Artio.DA, waist = "Fotia Belt", legs = "Meghanada Chausses +2", feet = gear.valorous.feet.crit
	}
	sets.precast.WS['Rampage'].PDL = set_combine(sets.precast.WS['Rampage'],
	{
		ammo = "Crepuscular Pebble",
		head = "Gleti's Mask", neck = "Bst. Collar +2",
		hands = "Gleti's Gauntlets", ring1 = "Sroda Ring",
		legs = "Gleti's Breeches", feet = "Gleti's Boots"
	})
	sets.precast.WS['Rampage']['Subtle Blow'] = set_combine(sets.precast.WS['Rampage'], sets.SubtleBlow)

	sets.precast.WS['Savage Blade'] =
	{
		ammo = "Coiste Bodhar",
		head = "Ankusa Helm +3", neck = "Bst. Collar +2", ear1 = "Thrud Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Gere Ring",
		back = gear.Artio.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS['Savage Blade'],
	{
		ammo = "Crepuscular Pebble",
		body = "Gleti's Cuirass", ring1 = "Sroda Ring",
	})
	sets.precast.WS['Savage Blade']['Subtle Blow'] = set_combine(sets.precast.WS['Savage Blade'], sets.SubtleBlow)

	sets.precast.WS['Sanguine Blade'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Pixie Hairpin +1", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Archon Ring",
		back = gear.Artio.MND_WSD, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Red Lotus Blade'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Nyame Helm", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Medada's Ring",
		back = gear.Artio.STR_WSD, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Burning Blade'] = {} -- Empty for omen/proc purproses

	sets.precast.WS['Seraph Blade'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Nyame Helm", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Medada's Ring",
		back = gear.Artio.STR_WSD, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Shining Blade'] = {} -- Empty for omen/proc purproses

	sets.precast.WS['Evisceration'] =
	{
		ammo = "Coiste Bodhar",
		head = "Blistering Sallet +1", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Lugra Earring +1",
		body = "Gleti's Cuirass", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Gere Ring",
		back = gear.Artio.DA, waist = "Fotia Belt", legs = "Lustratio Subligar +1", feet = gear.valorous.feet.crit
	}
	sets.precast.WS['Evisceration'].PDL = set_combine(sets.precast.WS['Evisceration'],
	{
		ammo = "Crepuscular Pebble",
		head = "Gleti's Mask", neck = "Bst. Collar +2",
		hands = "Gleti's Gauntlets", ring1 = "Sroda Ring",
		legs = "Gleti's Breeches", feet = "Gleti's Boots"
	})
	sets.precast.WS['Evisceration']['Subtle Blow'] = set_combine(sets.precast.WS['Evisceration'], sets.SubtleBlow)

	sets.precast.WS['Aeolian Edge'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Nyame Helm", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Medada's Ring",
		back = gear.Artio.CHR_WSD, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['True Strike'] =
	{
		ammo = "Coiste Bodhar",
		head = "Ankusa Helm +3", neck = "Bst. Collar +2", ear1 = "Thrud Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Gere Ring",
		back = gear.Artio.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['True Strike'].PDL = set_combine(sets.precast.WS['True Strike'],
	{
		ammo = "Crepuscular Pebble",
		body = "Gleti's Cuirass", ring1 = "Sroda Ring"
	})
	sets.precast.WS['True Strike']['Subtle Blow'] = set_combine(sets.precast.WS['True Strike'], sets.SubtleBlow)

	sets.precast.WS['Spiral Hell'] =
	{
		ammo = "Coiste Bodhar",
		head = "Ankusa Helm +3", neck = "Bst. Collar +2", ear1 = "Thrud Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Gere Ring",
		back = gear.Artio.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Spiral Hell'].PDL = set_combine(sets.precast.WS['Spiral Hell'],
	{
		ammo = "Crepuscular Pebble",
		body = "Gleti's Cuirass", ring1 = "Sroda Ring"
	})
	sets.precast.WS['Spiral Hell']['Subtle Blow'] = set_combine(sets.precast.WS['Spiral Hell'], sets.SubtleBlow)

	sets.precast.WS['Entropy'] =
	{
		ammo = "Coiste Bodhar",
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Tali'ah Manteel +2", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Gere Ring",
		back = gear.Artio.DA, waist = "Fotia Belt", legs = "Meghanada Chausses +2", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Entropy'].PDL = set_combine(sets.precast.WS['Entropy'],
	{
		ammo = "Crepuscular Pebble",
		head = "Gleti's Mask", neck = "Bst. Collar +2",
		body = "Gleti's Cuirass", hands = "Gleti's Gauntlets", ring1 = "Sroda Ring",
		legs = "Gleti's Breeches", feet = "Gleti's Boots"
	})
	sets.precast.WS['Entropy']['Subtle Blow'] = set_combine(sets.precast.WS['Entropy'], sets.SubtleBlow)

		-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}

	-- PET SIC & READY MOVES
	sets.midcast.Pet.WS =
	{
		ammo = "Hesperiidae",
		head = "Emicho Coronet +1", neck = "Shulmanu Collar", ear1 = "Kyrene's Earring", ear2 = "Enmerkar Earring",
		body = gear.valorous.body.pet_phys, hands = "Nukumi Manoplas +1", ring1 = "Cath Palug Ring", ring2 = "Varar Ring +1",
		back = gear.Artio.Pet_Idle, waist = "Incarnation Sash", legs = gear.valorous.legs.pet_phys, feet = "Gleti's Boots"
	}

	sets.midcast.Pet.MultiHitReady = set_combine(sets.midcast.Pet.WS,
	{
		ear2 = "Domesticator's Earring",
		legs = "Emicho Hose +1",
	})

	sets.midcast.Pet.MagicReady =
	{
		ammo = "Hesperiidae",
		head = gear.valorous.head.pet_mab, neck = "Adad Amulet", ear1 = "Kyrene's Earring", ear2 = "Enmerkar Earring",
		body = "Emicho Haubert +1", hands = "Nukumi Manoplas +1", ring1 = "Cath Palug Ring", ring2 = "Tali'ah Ring",
		back = gear.Artio.Pet_Macc, waist = "Incarnation Sash", legs = gear.valorous.legs.pet_mab, feet = gear.valorous.feet.pet_mab
	}
		
	sets.midcast.Pet.DebuffReady =
	{
		ammo = "Hesperiidae",
		head = "Nyame Helm", neck = "Adad Amulet", ear1 = "Enmerkar Earring", ear2 = "Nukumi Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Cath Palug Ring", ring2 = "Tali'ah Ring",
		back = gear.Artio.Pet_Macc, waist = "Incarnation Sash", legs = "Nyame Flanchard", feet = "Gleti's Boots"
	}
		
	sets.midcast.Pet.PhysicalDebuffReady = set_combine(sets.midcast.Pet.WS, {})

	sets.midcast.Pet.BuffReady =
	{
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Shepherd's Chain", ear1 = "Handler's Earring +1", ear2 = "Enmerkar Earring",
		body = "Totemic Jackcoat +3", hands = "Nukumi Manoplas +1", ring1 = "Cath Palug Ring", ring2 = "Defending Ring",
		back = gear.Artio.Pet_Idle, waist = "Isa Belt", legs = "Tali'ah Seraweels +2", feet = "Ankusa Gaiters +3"
	}

	sets.midcast.Pet.ReadyRecast = { legs = "Gleti's Breeches" }
	sets.midcast.Pet.ReadyRecastDW =  { legs = "Gleti's Breeches" }
	sets.Correlation = { head = "Nukumi Cabasset +1" }

	-- RESTING
	sets.resting = {}

	sets.idle =
	{
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Warder's Charm +1", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Shadow Ring", ring2 = "Defending Ring",
		back = gear.Artio.Idle, waist = "Engraved Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.idle.Pet =
	{
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Shepherd's Chain", ear1 = "Handler's Earring +1", ear2 = "Enmerkar Earring",
		body = "Totemic Jackcoat +3", hands = "Gleti's Gauntlets", ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = gear.Artio.Pet_Idle, waist = "Isa Belt", legs = "Tali'ah Seraweels +2", feet = "Ankusa Gaiters +3"
	}

	sets.idle.Pet.Engaged =
	{
		ammo = "Voluspa Tathlum",
		head = "Tali'ah Turban +2", neck = "Bst. Collar +2", ear1 = "Handler's Earring +1", ear2 = "Enmerkar Earring",
		body = "Ankusa Jackcoat +3", hands = "Gleti's Gauntlets", ring1 = "Cath Palug Ring", ring2 = "Varar Ring +1",
		back = gear.Artio.Pet_Idle, waist = "Incarnation Sash", legs = "Ankusa Trousers +3", feet = "Gleti's Boots"
	}
	sets.idle.Pet.Engaged.DD = sets.idle.Pet.Engaged

	sets.idle.Pet.Engaged.DT =
	{
		ammo = "Staunch Tathlum +1",
		head = "Anwig Salade", neck = "Shepherd's Chain", ear1 = "Handler's Earring +1", ear2 = "Enmerkar Earring",
		body = "Totemic Jackcoat +3", hands = "Gleti's Gauntlets", ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = gear.Artio.Pet_Idle, waist = "Isa Belt", legs = "Tali'ah Seraweels +2", feet = "Ankusa Gaiters +3"
	}

	sets.Kiting = { ring1 = "Shneddick Ring" }
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- MELEE (SINGLE-WIELD) SETS
	sets.engaged =
	{
		ammo = "Coiste Bodhar",
		head = "Malignance Chapeau", neck = "Anu Torque", ear1 = "Sherida Earring", ear2 = "Telos Earring",
		body = "Gleti's Cuirass", hands = "Malignance Gloves", ring1 = "Gere Ring", ring2 = "Defending Ring",
		back = gear.Artio.STP, waist = "Sailfi Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	sets.engaged.DW = set_combine(sets.engaged,
	{
		ear2 = "Eabani Earring",
		back = gear.Artio.DA, waist = "Reiki Yotai"
	})

	sets.engaged.Pet = set_combine(sets.engaged,
	{
		neck = "Shulmanu Collar", ear2 = "Enmerkar Earring",
		body = "Totemic Jackcoat +3", hands = "Gleti's Gauntlets", ring2 = "Defending Ring",
		back = gear.Artio.STP, legs = "Tali'ah Seraweels +2", feet = "Gleti's Boots"
	})

	sets.engaged.DW.Pet = set_combine(sets.engaged.Pet,
	{
		waist = "Klouskap Sash +1", feet = "Malignance Boots"
	})

	sets.buff['Killer Instinct'] = { body = "Nukumi Gausape +1" }
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter,
	{
		ammo = "Per. Lucky Egg",
		hands = "Volte Bracers",
		waist = "Chaac Belt", legs = "Volte Hose",
	})

	-- Weapons sets
	sets.weapons.Aymur = { main = "Agwu's Axe", sub = "Sacro Bulwark" }
	sets.weapons.Pangu = { main = "Pangu", sub = "Sacro Bulwark" }
	sets.weapons.Dolichenus = { main = "Dolichenus", sub = "Sacro Bulwark" }
	sets.weapons.Naegling = { main = "Naegling", sub = "Sacro Bulwark" }
	sets.weapons.Drepanum = { main = "Drepanum", sub = "Bloodrain Strap" }
	sets.weapons.DualAymur = { main = "Aymur", sub = "Agwu's Axe" }
	sets.weapons.DualPangu = { main = "Pangu", sub = "Agwu's Axe" }
	sets.weapons.DualDolichenus = { main = "Dolichenus", sub = "Agwu's Axe" }
	sets.weapons.DualNaegling = { main = "Naegling", sub = "Fernagu" }

-------------------------------------------------------------------------------------------------------------------
-- Complete Lvl 76-99 Jug Pet Precast List +Funguar +Courier +Amigo
-------------------------------------------------------------------------------------------------------------------

	sets.precast.JA['Bestial Loyalty'].FunguarFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Seedbed Soil"})
	sets.precast.JA['Bestial Loyalty'].CourierCarrie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Fish Oil Broth"})
	sets.precast.JA['Bestial Loyalty'].AmigoSabotender = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sun Water"})
	sets.precast.JA['Bestial Loyalty'].NurseryNazuna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="D. Herbal Broth"})
	sets.precast.JA['Bestial Loyalty'].CraftyClyvonne = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Cng. Brain Broth"})
	sets.precast.JA['Bestial Loyalty'].PrestoJulio = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="C. Grass. Broth"})
	sets.precast.JA['Bestial Loyalty'].SwiftSieghard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Mlw. Bird Broth"})
	sets.precast.JA['Bestial Loyalty'].MailbusterCetas = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Gob. Bug Broth"})
	sets.precast.JA['Bestial Loyalty'].AudaciousAnna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="B. Carrion Broth"})
	sets.precast.JA['Bestial Loyalty'].TurbidToloi = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Auroral Broth"})
	sets.precast.JA['Bestial Loyalty'].LuckyLulush = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="L. Carrot Broth"})
	sets.precast.JA['Bestial Loyalty'].DipperYuly = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wool Grease"})
	sets.precast.JA['Bestial Loyalty'].FlowerpotMerle = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Vermihumus"})
	sets.precast.JA['Bestial Loyalty'].DapperMac = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Briny Broth"})
	sets.precast.JA['Bestial Loyalty'].DiscreetLouise = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Deepbed Soil"})
	sets.precast.JA['Bestial Loyalty'].FatsoFargann = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="C. Plasma Broth"})
	sets.precast.JA['Bestial Loyalty'].FaithfulFalcorr = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Lucky Broth"})
	sets.precast.JA['Bestial Loyalty'].BugeyedBroncha = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Svg. Mole Broth"})
	sets.precast.JA['Bestial Loyalty'].BloodclawShasra = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Rzr. Brain Broth"})
	sets.precast.JA['Bestial Loyalty'].GorefangHobs = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="B. Carrion Broth"})
	sets.precast.JA['Bestial Loyalty'].GooeyGerard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Cl. Wheat Broth"})
	sets.precast.JA['Bestial Loyalty'].CrudeRaphie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Shadowy Broth"})

	-------------------------------------------------------------------------------------------------------------------
	-- Complete iLvl Jug Pet Precast List
	-------------------------------------------------------------------------------------------------------------------

	sets.precast.JA['Bestial Loyalty'].DroopyDortwin = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Swirling Broth"})
	sets.precast.JA['Bestial Loyalty'].PonderingPeter = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Vis. Broth"})
	sets.precast.JA['Bestial Loyalty'].SunburstMalfik = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Shimmering Broth"})
	sets.precast.JA['Bestial Loyalty'].AgedAngus = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Ferm. Broth"})
	sets.precast.JA['Bestial Loyalty'].WarlikePatrick = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Livid Broth"})
	sets.precast.JA['Bestial Loyalty'].ScissorlegXerin = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Spicy Broth"})
	sets.precast.JA['Bestial Loyalty'].BouncingBertha = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Bubbly Broth"})
	sets.precast.JA['Bestial Loyalty'].RhymingShizuna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Lyrical Broth"})
	sets.precast.JA['Bestial Loyalty'].AttentiveIbuki = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Salubrious Broth"})
	sets.precast.JA['Bestial Loyalty'].SwoopingZhivago = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Windy Greens"})
	sets.precast.JA['Bestial Loyalty'].AmiableRoche = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Airy Broth"})
	sets.precast.JA['Bestial Loyalty'].HeraldHenry = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Trans. Broth"})
	sets.precast.JA['Bestial Loyalty'].BrainyWaluis = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Crumbly Soil"})
	sets.precast.JA['Bestial Loyalty'].HeadbreakerKen = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Blackwater Broth"})
	sets.precast.JA['Bestial Loyalty'].SuspiciousAlice = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Furious Broth"})
	sets.precast.JA['Bestial Loyalty'].AnklebiterJedd = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Crackling Broth"})
	sets.precast.JA['Bestial Loyalty'].FleetReinhard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Rapid Broth"})
	sets.precast.JA['Bestial Loyalty'].CursedAnnabelle = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Creepy Broth"})
	sets.precast.JA['Bestial Loyalty'].SurgingStorm = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Insipid Broth"})
	sets.precast.JA['Bestial Loyalty'].SubmergedIyo = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Deepwater Broth"})
	sets.precast.JA['Bestial Loyalty'].RedolentCandi = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Electrified Broth"})
	sets.precast.JA['Bestial Loyalty'].AlluringHoney = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Bug-Ridden Broth"})
	sets.precast.JA['Bestial Loyalty'].CaringKiyomaro = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Fizzy Broth"})
	sets.precast.JA['Bestial Loyalty'].VivaciousVickie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Tant. Broth"})
	sets.precast.JA['Bestial Loyalty'].HurlerPercival = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Pale Sap"})
	sets.precast.JA['Bestial Loyalty'].BlackbeardRandy = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Meaty Broth"})
	sets.precast.JA['Bestial Loyalty'].GenerousArthur = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Dire Broth"})
	sets.precast.JA['Bestial Loyalty'].ThreestarLynn = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Muddy Broth"})
	sets.precast.JA['Bestial Loyalty'].MosquitoFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wetlands Broth"})
	sets.precast.JA['Bestial Loyalty']['Left-HandedYoko'] = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Heavenly Broth"})
	sets.precast.JA['Bestial Loyalty'].BraveHeroGlenn = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wispy Broth"})
	sets.precast.JA['Bestial Loyalty'].SharpwitHermes = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Saline Broth"})
	sets.precast.JA['Bestial Loyalty'].ColibriFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sugary Broth"})
	sets.precast.JA['Bestial Loyalty'].ChoralLeera = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Glazed Broth"})
	sets.precast.JA['Bestial Loyalty'].SpiderFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sticky Webbing"})
	sets.precast.JA['Bestial Loyalty'].GussyHachirobe = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Slimy Webbing"})
	sets.precast.JA['Bestial Loyalty'].AcuexFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Poisonous Broth"})
	sets.precast.JA['Bestial Loyalty'].FluffyBredo = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Venomous Broth"})
	sets.precast.JA['Bestial Loyalty'].WeevilFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Pristine Sap"})
	sets.precast.JA['Bestial Loyalty'].StalwartAngelina = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="T. Pristine Sap"})
	sets.precast.JA['Bestial Loyalty'].SweetCaroline = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Aged Humus"})
	sets.precast.JA['Bestial Loyalty']['P.CrabFamiliar'] = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Rancid Broth"})
	sets.precast.JA['Bestial Loyalty'].JovialEdwin = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Pungent Broth"})
	sets.precast.JA['Bestial Loyalty']['Y.BeetleFamiliar'] = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Zestful Sap"})
	sets.precast.JA['Bestial Loyalty'].EnergizedSefina = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Gassy Sap"})
	sets.precast.JA['Bestial Loyalty'].LynxFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Frizzante Broth"})
	sets.precast.JA['Bestial Loyalty'].VivaciousGaston = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Spumante Broth"})
	sets.precast.JA['Bestial Loyalty']['Hip.Familiar'] = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Turpid Broth"})
	sets.precast.JA['Bestial Loyalty'].DaringRoland = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Feculent Broth"})
	sets.precast.JA['Bestial Loyalty'].SlimeFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Decaying Broth"})
	sets.precast.JA['Bestial Loyalty'].SultryPatrice = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Putrescent Broth"})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(4, 16)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 015')
end

state.Weapons:options('None','PetPDTAxe','DualWeapons')

autows_list = {['PetPDTAxe']='Ruinator',['DualWeapons']='Ruinator'}