-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal','DTLite','DT')
	state.RangedMode:options('Normal','Acc','Fodder')
	state.WeaponskillMode:options('Match','Normal', 'Acc')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('Bow', 'Trial', 'Fomalhaut', 'Armageddon', 'DualBow', 'DualTrial', 'DualSavageWeapons', 'DualEviscerationWeapons', 'DualMagicWeapons', 'DualMalevolence')
	
	WeaponType = 
	{
		['Fail-Not'] = "Bow",
		['Ullr'] = "Bow",
		['Sparrowhawk +2'] = "Bow",
		['Bow of Trials'] = "Bow",
		['Fomalhaut'] = "Gun",
		['Ataktos'] = "Gun",
	}

	DefaultAmmo =
	{
		['Bow']  =
		{
			['Default'] = "Eminent Arrow",
			['WS'] = "Eminent Arrow",
			['Acc'] = "Eminent Arrow",
			['Magic'] = "Eminent Arrow",
			['MagicAcc'] = "Eminent Arrow",
			['Unlimited'] = "Hauksbok Arrow",
			['MagicUnlimited'] ="Hauksbok Arrow",
			['MagicAccUnlimited'] ="Hauksbok Arrow"
		},
		['Gun']  =
		{
			['Default'] = "Chrono Bullet",
			['WS'] = "Chrono Bullet",
			['Acc'] = "Chrono Bullet",
			['Magic'] = "Orichalc. Bullet",
			['MagicAcc'] = "Orichalc. Bullet",
			['Unlimited'] = "Hauksbok Bullet",
			['MagicUnlimited'] = "Hauksbok Bullet",
			['MagicAccUnlimited'] ="Animikii Bullet"
		},
		['Crossbow'] =
		{
			['Default'] = "Eminent Bolt",
			['WS'] = "Eminent Bolt",
			['Acc'] = "Eminent Bolt",
			['Magic'] = "Eminent Bolt",
			['MagicAcc'] = "Eminent Bolt",
			['Unlimited'] = "Hauksbok Bolt",
			['MagicUnlimited'] = "Hauksbok Bolt",
			['MagicAccUnlimited'] ="Hauksbok Bolt"
		}
	}
	
	gear.tp_ranger_jse_back = {name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	gear.wsd_ranger_jse_back = {name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}}
	gear.snapshot_jse_back = {name="Belenus's Cape",augments={'"Snapshot"+10',}}
	
	    -- Additional local binds
    send_command('bind !` input /ra <t>')
	send_command('bind !backspace input /ja "Bounty Shot" <t>')
	send_command('bind @f7 gs c toggle RngHelper')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons MagicWeapons;gs c update')
	send_command('bind ^q gs c weapons SingleWeapon;gs c update')

	Ikenga_vest_bonus = 170
	
	select_default_macro_book()

end

-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	
	
	-- Precast sets to enhance JAs
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.precast.JA['Bounty Shot'] = set_combine(sets.TreasureHunter, {hands="Amini Glove. +1"})
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +1"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +1"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +3"}
	sets.precast.JA['Double Shot'] = {back=gear.tp_ranger_jse_back}


	-- Fast cast sets for spells

	sets.precast.FC =
	{
		head = "Carmine Mask +1", neck = "Baetyl Pendant", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = "Dread Jupon", hands = "Leyline Gloves", ring1 = "Prolix Ring", ring2 = "Lebeche Ring",
		back = "Moonlight Cape", waist = "Flume Belt +1", legs = "Rawhide Trousers", feet = "Carmine Greaves +1"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket"})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		head="Amini Gapette +1",
		body="Amini Caban +1",hands="Carmine Fin. Ga. +1",ring1="Crepuscular Ring",
		back=gear.snapshot_jse_back,waist="Impulse Belt",legs="Orion Braccae +3",feet="Meg. Jam. +2"}
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {head="Orion Beret +3",waist="Yemaya Belt"})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		head = "Orion Beret +3", neck = "Fotia Gorget", ear1 = "Moonshade Earring", ear2 = "Sherida Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Dingir Ring",
		back = "Null Shawl", waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Savage Blade'] =
	{
		ammo = "Hauskbok Arrow",
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Mooshade Earring", ear2 = "Sherida Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Sroda Ring", ring2 = "Regal Ring",
		back = "Belenus's Cape", waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS['Savage Blade'],
	{
		head = "Orion Beret +3", ear2 = "Amini Earring +1",
		body = "Ikenga's Vest", ring2 = "Epaminondas's Ring",
		feet = "Amini Bottillons +3"
	})

	sets.precast.WS['Last Stand'] =
	{
		ammo = "Chrono Bullet",
		head = "Orion Beret +3", neck = "Fotia Gorget", ear1 = "Moonshade Earring", ear2 = "Ishvara Earring",
		body = "Amini Caban +3", hands = "Nyame Gauntlets", ring1 = "Dingir Ring", ring2 = "Regal Ring",
		back = "Belenus's Cape", waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Amini Bottillons +3"
	}
	sets.precast.WS['Last Stand'].PDL = set_combine(sets.precast.WS['Last Stand'],
	{
		neck = "Scout's Gorget +2", ear2 = "Amini Earring +1",
		body = "Ikenga's Vest", hands = "Ikenga's Gloves", ring1 = "Sroda Ring", ring2 = "Epaminondas's Ring",
	})

	sets.precast.WS['Coronach'] =
	{
		ammo = "Chrono Bullet",
		head = "Orion Beret +3", neck = "Fotia Gorget", ear1 = "Ishvara Earring", ear2 = "Sherida Earring",
		body = "Amini Caban +3", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Epaminondas's Ring",
		back = "Belenus's Cape", waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Amini Bottillons +3"
	}
	sets.precast.WS['Coronach'].PDL = set_combine(sets.precast.WS['Coronach'],
	{
		neck = "Scout's Gorget +2", ear2 = "Amini Earring +1",
		ring1 = "Sroda Ring",
	})

	sets.precast.WS['Jishnu\'s Radiance'] =
	{
		ammo = "Chrono Arrow",
		head = "Orion Beret +3", neck = "Fotia Gorget", ear1 = "Odr Earring", ear2 = "Amini Earring +1",
		body = "Amini Caban +3", hands = "Amini Glove. +3", ring1 = "Begrudging Ring", ring2 = "Regal Ring",
		back = "Belenus's Cape", waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Amini Bottillons +3"
	}
	sets.precast.WS['Jishnu\'s Radiance'].PDL = set_combine(sets.precast.WS['Jishnu\'s Radiance'],
	{
		head = "Blistering Sallet +1", neck = "Scout's Gorget +2",
		hands = "Malignance Gloves", ring1 = "Epaminondas's Ring",
		legs = "Ikenga's Trousers"
	})

	sets.precast.WS['Flaming Arrow'] =
	{
		ammo = "Chrono Arrow",
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Moonshade Earring", ear2 = "Friomisi Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Epaminondas's Ring", ring2 = "Medada's Ring",
		back = "Belenus's Cape", waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Flaming Arrow'].PDL = set_combine(sets.precast.WS['Flaming Arrow'],
	{
		ear2 = "Amini Earring +1",
		ring2 = "Sroda Ring",
	})

	sets.precast.WS['Apex Arrow'] =
	{
		ammo = "Chrono Arrow",
		head = "Orion Beret +3", neck = "Scout's Gorget +2", ear1 = "Ishvara Earring", ear2 = "Amini Earring +1",
		body = "Amini Caban +3", hands = "Nyame Gauntlets", ring1 = "Sroda Ring", ring2 = "Epaminondas's Ring",
		back = "Belenus's Cape", waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Amini Bottillons +3"
	}
	sets.precast.WS['Apex Arrow'].PDL = set_combine(sets.precast.WS['Apex Arrow'], {})

	sets.precast.WS['Empyreal Arrow'] =
	{
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Moonshade Earring", ear2 = "Ishvara Earring",
		body = "Ikenga's Vest", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Epaminondas's Ring",
		back = "Belenus's Cape", waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Empyreal Arrow'].PDL = set_combine(sets.precast.WS['Empyreal Arrow'],
	{
		neck = "Scout's Gorget +2", ear2 = "Amini Earring +1",
		ring1 = "Sroda Ring"
	})

	sets.precast.WS['Trueflight'] =
	{
		ammo = "Quelling Bolt",
		head = "Nyame Helm", neck = "Scout's Gorget +2", ear1 = "Moonshade Earring", ear2 = "Friomisi Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Medada's Ring", rign2 = "Dingir Ring",
		back = "Belenus's Cape", waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Wilfdfire'] =
	{
		ammo = "Chrono Bullet",
		head = "Nyame Helm", neck = "Scout's Gorget +2", ear1 = "Crematio Earring", ear2 = "Friomisi Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Epaminondas's Ring", ring2 = "Medada's Ring",
		back = "Belenus's Cape", waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Hot Shot'] =
	{
		ammo = "Chrono Bullet",
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Moonshade Earring", ear2 = "Friomisi Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Epaminondas's Ring", ring2 = "Dingir Ring",
		back = "Belenus's Cape", waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Hot Shot'].PDL = set_combine(sets.precast.WS['Hot Shot'],
	{
		ear1 = "Amini Earring +1"
	})

	sets.precast.WS['Aeolian Edge'] =
	{
		ammo = "Hauksbok Arrow",
		head = "Nyame Helm", neck = "Baetyl Pendant", ear1 = "Moonshade Earring", ear2 = "Friomisi Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Epaminondas's Ring", ring2 = "Medada's Ring",
		back = "Belenus's Cape", waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
    sets.midcast.FastRecast = {
        head="Carmine Mask +1",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Moonlight Cape",waist="Flume Belt +1",legs="Rawhide Trousers",feet="Carmine Greaves +1"}
		
	-- Ranged sets

    sets.midcast.RA = {
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Crepuscular Ring",ring2="Dingir Ring",
        back=gear.tp_ranger_jse_back,waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Boots"}
	
    sets.midcast.RA.Acc = {
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.tp_ranger_jse_back,waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
    sets.midcast.RA.Fodder = {
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Dedition Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Crepuscular Ring",ring2="Dingir Ring",
        back=gear.tp_ranger_jse_back,waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	--These sets will overlay based on accuracy level, regardless of other options.
	sets.buff.Camouflage = {body="Orion Jerkin +1"}
	sets.buff.Camouflage.Acc = {}
	sets.buff['Double Shot'] = {back=gear.tp_ranger_jse_back}
	sets.buff['Double Shot'].Acc = {}
	sets.buff.Barrage = {hands="Orion Bracers +1"}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle =
	{
		head = "Malignance Chapeau", neck = "Loricate Torque +1", ear1 = "Eabani Earring", ear2 = "Sanare Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Shadow Ring",
		back = "Null Shawl", waist = "Carrier's Sash", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.Kiting = { legs = "Carmine Cuisses +1" }
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	-- Weapons sets
	sets.weapons.Bow = { main = "Kustawi +1", sub = "Nusku Shield", range = "Ullr" }
	sets.weapons.Trial = { main = "Kustawi +1", sub = "Nusku Shield", range = "Sparrowhawk +2" }
	sets.weapons.Fomalhaut = { main = "Kustawi +1", sub = "Nusku Shield", range = "Fomalhaut" }
	sets.weapons.Armageddon = { main = "Gletis' Kinfe", sub = "Nusku Shield", range = "Armageddon" }
	sets.weapons.DualBow = { main = "Perun +1", sub = "Ternion Dagger +1", range = "Ullr" }
	sets.weapons.DualTrial = { main = "Kustawi +1", sub = "Gleti's Knife", range = "Sparrowhawk +2" }
	sets.weapons.DualSavageWeapons = { main = "Naegling", sub = "Gleti's Knife", range = "Fomalhaut" }
	sets.weapons.DualEviscerationWeapons = { main = "Tauret", sub = "Gleti's Knife", range = "Fomalhaut"}
	sets.weapons.DualMalevolence = {main="Malevolence",sub="Malevolence",range="Fomalhaut"}
	sets.weapons.DualMagicWeapons = {main="Tauret",sub="Naegling",range="Fomalhaut"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Normal melee group
	sets.engaged =
	{
		head = "Malignance Chapeau", neck = "Iskur Gorget", ear1 = "Brutal Earring", ear2 = "Sherida Earring",
		body = "Malignance Tabard" , hands = "Malignance Gloves", ring1 = "Epona's Ring", ring2 = "Petrov Ring",
		back = "Null Shawl", waist = "Windbuffet Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.engaged.DW = set_combine(sets.engaged,
	{
		ear1 = "Suppanomimi",
		body = gear.adhemar.body.b
	})

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(1, 19)
    elseif player.sub_job == 'DNC' then
		set_macro_page(1, 19)
    elseif player.sub_job == 'DRG' then
        set_macro_page(3, 19)
    else
        set_macro_page(1, 19)
    end
end
