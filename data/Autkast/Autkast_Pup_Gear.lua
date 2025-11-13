-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal', 'Pet', 'DT')
    state.WeaponskillMode:options('Match', 'PDL', 'Proc')
    state.PhysicalDefenseMode:options('PDT')
	state.IdleMode:options('Normal', 'Refresh')
	state.Weapons:options('None', 'Godhands', 'Verethragna', 'PetWeapons', 'Trial')
	state.PetMode = M{['description']='Pet Mode', 'None','Melee','Ranged','HybridRanged','Bruiser','Tank','LightTank','Magic','Heal','Nuke'}
	state.AutoRepairMode = M(false, 'Auto Repair Mode')
	state.AutoDeployMode = M(true, 'Auto Deploy Mode')
	state.AutoPetMode 	 = M(false, 'Auto Pet Mode')
	state.PetWSGear		 = M(false, 'Pet WS Gear')
	state.PetEnmityGear	 = M(false, 'Pet Enmity Gear')
	
    -- Default/Automatic maneuvers for each pet mode.  Define at least 3.
	defaultManeuvers = {
		Melee = {
			{Name='Fire Maneuver', 	  Amount=1},
			{Name='Thunder Maneuver', Amount=0},
			{Name='Wind Maneuver', 	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
		},
		Bruiser = {
			{Name='Light Maneuver',	  Amount=1},
			{Name='Water Maneuver',   Amount=1},
			{Name='Fire Maneuver', 	  Amount=1},
			{Name='Light Maneuver',	  Amount=0},
		},
		Ranged = {
			{Name='Wind Maneuver', 	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Thunder Maneuver', Amount=0},
		},
		HybridRanged = {
			{Name='Wind Maneuver', 	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Thunder Maneuver', Amount=0},
		},
		Tank = {
			{Name='Earth Maneuver',	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=0},
		},
		LightTank = {
			{Name='Earth Maneuver',	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=0},
		},
		Magic = {
			{Name='Light Maneuver',	  Amount=1},
			{Name='Ice Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Earth Maneuver',	  Amount=0},
		},
		Heal = {
			{Name='Light Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Ice Maneuver',	  Amount=1},
		},
		Nuke = {
			{Name='Ice Maneuver',	  Amount=2},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Earth Maneuver',	  Amount=0},
		},
	}

	deactivatehpp = 85
	
    select_default_macro_book()
	
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f8 gs c toggle AutoPuppetMode')
	send_command('bind @f7 gs c toggle AutoRepairMode')
end

-- Define sets used by this job file.
function init_gear_sets()
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
	head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
	body="Zendik Robe",hands="Malignance Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
	back="Perimede Cape",waist="Isa Belt",legs="Rawhide Trousers",feet="Regal Pumps +1"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    
    -- Precast sets to enhance JAs
    sets.precast.JA['Tactical Switch'] = {feet="Cirque Scarpe +2"}
    sets.precast.JA['Repair'] = {ammo="Automat. Oil +3"} --feet="Foire Babouches"
	sets.precast.JA['Maintenance'] = {ammo="Automat. Oil +3"}

    sets.precast.JA.Maneuver = {main="Midnights",back="Visucius's Mantle"} --neck="Buffoon's Collar",hands="Foire Dastanas",body="Cirque Farsetto +2",

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Lilitu Headpiece",neck="Unmoving Collar +1",ear1="Enchntr. Earring +1",ear2="Handler's Earring +1",
        body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
        back="Moonlight Cape",waist="Chaac Belt",legs="Hiza. Hizayoroi +2",feet=gear.herculean_waltz_feet}
        
    sets.precast.Waltz['Healing Waltz'] = {}


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		head = "Mpaca's Cap", neck = "Rep. Plat. Medal", ear1 = "Schere Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = "Null Shawl", waist = "Moonbow Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS.Proc = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Victory Smite'] =
	{
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Schere Earring", ear2 = "Telos Earring",
		body = "Mpaca's Doublet", hands = "Mpaca's Gloves", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = "Null Shawl", waist = "Moonbow Belt +1", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Stringing Pummel'] =
	{
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Schere Earring", ear2 = "Moonshade Earring",
		body = "Mpaca's Doublet", hands = "Ryuo Tekko +1", ring1 = "Regal Ring", ring2 = "Gere Ring",
		back = "Null Shawl", waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Shijin Spiral'] =
	{
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Schere Earring", ear2 = "Mache Earring +1",
		body = "Mpaca's Doublet", hands = "Mpaca's Gloves", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = "Null Shawl", waist = "Moonbow Belt +1", legs = "Nyame Flanchard", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Howling Fist'] =
	{
		head = "Mpaca's Cap", neck = "Rep. Plat. Medal", ear1 = "Schere Earring", ear2 = "Moonshade Earring",
		body = "Nyanme Mail", hands = "Nyame Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = "Null Shawl", waist = "Moonbow Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Backhand Blow'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Shoulder Tackle'] = set_combine(sets.precast.WS, {})


	-- Midcast Sets
	sets.midcast.FastRecast = {
		head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Zendik Robe",hands="Malignance Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
		back="Perimede Cape",waist="Isa Belt",legs="Rawhide Trousers",feet="Regal Pumps +1"}
	
	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	
    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {}
	sets.midcast.Pet['Enfeebling Magic'] = {neck="Adad Amulet",ear1="Enmerkar Earring",ear2="Handler's Earring +1",body=gear.taeon_pet_body,hands="Regimen Mittens",ring1="Varar Ring +1",ring2="Varar Ring +1",waist="Incarnation Sash",legs="Tali'ah Sera. +2"}
    sets.midcast.Pet['Elemental Magic'] = {neck="Adad Amulet",ear1="Enmerkar Earring",ear2="Handler's Earring +1",body=gear.taeon_pet_body,hands="Regimen Mittens",ring1=		"Varar Ring +1",ring2="Varar Ring +1",waist="Incarnation Sash",legs="Tali'ah Sera. +2"}
	
	-- The following sets are predictive and are equipped before we even know the ability will happen, as a workaround due to
	-- the fact that start of ability packets are too late in the case of Pup abilities, WS, and certain spells.
	sets.midcast.Pet.PetEnmityGear = {}
	sets.midcast.Pet.PetWSGear = {main="Ohtas",head="Mpaca's Cap",neck="Shulmanu Collar",ear1="Enmerkar Earring",ear2="Domesticator's Earring",
        body=gear.taeon_pet_body,hands="Mpaca's Gloves",ring1="Varar Ring +1",ring2="C. Palug Ring",
        back="Visucius's Mantle",waist="Incarnation Sash",legs="Taeon Tights",feet="Mpaca's Boots"}
	
    sets.midcast.Pet.PetWSGear.Ranged = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Melee = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Tank = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Bruiser = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.LightTank = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Magic = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Heal = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Nuke = set_combine(sets.midcast.Pet.PetWSGear, {})
    
	-- Currently broken, preserved in case of future functionality.
	--sets.midcast.Pet.WeaponSkill = {}

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

	-- Idle sets
	sets.idle =
	{
		head = "Nyame Helm", neck = "Warder's Charm +1", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Shadow Ring", ring2 = "Defending Ring",
		back = "Null Shawl", waist = "Carrier's Sash", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.idle.Refresh = set_combine(sets.idle, { ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1" })

	-- Set for idle while pet is out (eg: pet regen gear)
	sets.idle.Pet = set_combine(sets.idle, {})
	sets.idle.Pet.Refresh = set_combine(sets.idle.Pet, sets.idle.Refresh)

	-- Idle sets to wear while pet is engaged
	sets.idle.Pet.Engaged =
	{
		main = "Xiucoatl",
		head = "Mpaca's Cap", neck = "Shulmanu Collar", ear1 = "Crep. Earring", ear2 = "Enmerkar Earring",
		body = "Mpaca's Doublet", hands = "Mpaca's Gloves", ring1 = "Varar Ring +1", ring2 = "Varar Ring +2",
		back = "Null Shawl", waist = "Klouskap Sash +1", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}

	sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Melee = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Tank = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Bruiser = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.LightTank = set_combine(sets.idle.Pet.Engaged, {})
    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Heal = sets.idle.Pet.Engaged.Magic
	sets.idle.Pet.Engaged.Nuke = sets.idle.Pet.Engaged.Magic

	sets.Kiting = { feet = "Hermes' Sandals" }

	-- Engaged sets
	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	sets.Godhands = { ear1 = "Mache Earring +1" }

	-- Normal melee group
	sets.engaged =
	{
		head = "Malignance Chapeau", neck = "Shulmanu Collar", ear1 = "Schere Earring", ear2 = "Kara. Earring +1",
		body = "Mpaca's Doublet", hands = "Mpaca's Gloves", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = "Null Shawl", waist = "Moonbow Belt +1", legs = "Samnuha Tights", feet = gear.herculean_ta_feet
	}
	sets.engaged.Godhands = set_combine(sets.engaged, sets.Godhands)

	sets.engaged.DT =
	{
		head = "Malignance Chapeau", neck = "Loricate Torque +1", ear1 = "Schere Earring", ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = "Null Shawl", waist = "Moonbow Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	sets.engaged.Godhands.DT = set_combine(sets.engaged.DT, sets.Godhands)

	sets.engaged.Pet =
	{
		head = "Mpaca's Cap", neck = "Shulmanu Collar", ear1 = "Crep. Earring", ear2 = "Kara. Earring +1",
		body = "Mpaca's Doublet", hands = "Mpaca's Gloves", ring1 = "Niqmaddu Ring", ring2 = "Gere Ring",
		back = "Null Shawl", waist = "Moonbow Belt +1", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}
	sets.engaged.Godhands.Pet = set_combine(sets.engaged.Pet, sets.Godhands)

	-- Weapons sets
	sets.weapons.Godhands = { main = "Godhands", range = "Neo Animator" }
	sets.weapons.Verethragna = { main = "Verethragna", range = "Neo Animator" }
	sets.weapons.PetWeapons = { main = "Ohtas", range = "Neo Animator" }
	sets.weapons.Trial = { main = "Inferno Claws", range = "Neo Animator" }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 20)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 20)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 20)
    else
        set_macro_page(2, 20)
    end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 018')
end