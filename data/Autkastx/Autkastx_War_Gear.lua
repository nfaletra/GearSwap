function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'TwoHanded')
	state.WeaponskillMode:options('Match', 'Normal', 'PDL', 'Proc')
	state.HybridMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
	state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal')
	state.ExtraMeleeMode = M{ ['description']='Extra Melee Mode', 'None' }
	state.Passive = M{ ['description'] = 'Passive Mode', 'None', 'Twilight' }
	state.Weapons:options('Chango', 'ShiningOne', 'Greatsword', 'Naegling', 'DualWeapons', 'ProcDagger', 'ProcSword', 'ProcGreatSword', 'ProcScythe', 'ProcPolearm', 'ProcGreatKatana', 'ProcClub', 'ProcStaff')

	gear.Cichol =
	{
		TP = { name = "Cichol's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dbl.Atk."+10', 'Damage taken-5%' } },
		STR_WSD = { name = "Cichol's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Damage taken-5%' } }
	}

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')

	Ikenga_axe_bonus = 0

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets

	sets.Enmity = {}
	sets.Knockback = {}
	sets.passive.Twilight = { head = "Twilight Helm", body = "Twilight Mail" }

	-- Precast sets to enhance JAs
	sets.precast.JA['Berserk'] = { body = "Pumm. Lorica +1", back = gear.Cichol.TP, feet = "Agoge Calligae +3" }
	sets.precast.JA['Warcry'] = { head = "Agoge Mask +1", }
	sets.precast.JA['Defender'] = {}
	sets.precast.JA['Aggressor'] = { head = "Pumm. Mask +1", body = "Agoge Lorica +3" }
	sets.precast.JA['Mighty Strikes'] = { hands = "Agoge Mufflers +1" }
	sets.precast.JA["Warrior's Charge"] = {}
	sets.precast.JA['Tomahawk'] = { ammo = "Thr. Tomahawk", feet = "Agoge Calligae +3" }
	sets.precast.JA['Retaliation'] = {}
	sets.precast.JA['Restraint'] = {}
	sets.precast.JA['Blood Rage'] = {}
	sets.precast.JA['Brazen Rush'] = {}
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity,{})

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	sets.precast.Step = {}
	sets.precast.Flourish1 = {}

	-- Fast cast sets for spells

	sets.precast.FC = {ammo="Impatiens",
		head="Carmine Mask +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Odyss. Chestplate",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs=gear.odyssean_fc_legs,feet="Odyssean Greaves"}
	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	-- Midcast Sets
	sets.midcast.FastRecast = {ammo="Staunch Tathlum +1",
		head="Carmine Mask +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Odyss. Chestplate",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
		back="Moonlight Cape",waist="Tempus Fugit",legs=gear.odyssean_fc_legs,feet="Odyssean Greaves"}
	
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

	sets.midcast.Cure = {}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS =
	{
		ammo = "Knobkierrie",
		head = "Agoge Mask +3", neck = "War. Beads +2", ear1 = "Moonshade Earring", ear2 = "Thrud Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Regal Ring",
		back = gear.Cichol.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.	
	sets.precast.WS['Savage Blade'] =
	{
		ammo = "Knobkierrie",
		head = "Agoge Mask +3", neck = "War. Beads +2", ear1 = "Moonshade Earring", ear2 = "Thrud Earring",
		body = "Nyame Mail", hands = "Boii Mufflers +3", ring1 = "Beithir Ring", ring2 = "Regal Ring",
		back = gear.Cichol.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS['Savage Blade'],
	{
		body = "Sakpata's Plate", ring1 = "Epaminondas's Ring", ring2 = "Sroda Ring",
		legs = "Boii Cuisses +3"
	})

	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS,
	{
		ear2 = "Friomisi Earring",
		head = "Pixie Hairpin +1", ring1 = "Archon Ring", ring2 = "Epaminondas's Ring"
	})

	sets.precast.WS['Upheaval'] =
	{
		ammo = "Knobkierrie",
		head = "Agoge Mask +3", neck = "War. Beads +2", ear1 = "Moonshade Earring", ear2 = "Thrud Earring",
		body = "Nyame Mail", hands = "Boii Mufflers +3", ring1 = "Niqmaddu Ring", ring2 = "Regal Ring",
		back = gear.Cichol.STR_WSD, waist = "Sailfi Belt +1", legs = "Boii Cuisses +3", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Upheaval'].PDL = set_combine(sets.precast.WS['Upheaval'],
	{
		head = "Sakpata's Helm",
		body = "Sakpata's Plate", hands = "Sakpata's Gauntlets", ring2 = "Sroda Ring",
	})

	sets.precast.WS['Raging Rush'] =
	{
		ammo = "Yetshila +1",
		head = "Boii Mask +3", neck = "Fotia Gorget", ear1 = "Moonshade Earring", ear2 = "Boii Earring +1",
		body = "Sakpata's Plate", hands = "Nyame Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Begrudging Ring",
		back = gear.Cichol.STR_WSD, waist = "Fotia Belt", legs = "Boii Cuisses +3", feet = "Boii Calligae +3"
	}
	sets.precast.WS['Raging Rush'].PDL = set_combine(sets.precast.WS['Raging Rush'],
	{
		hands = "Sakpata's Gauntlets", ring2 = "Sroda Ring",
	})

	sets.precast.WS['Ukko\'s Fury'] =
	{
		ammo = "Yetshila +1",
		head = "Boii Mask +3", neck = "War. Beads +2", ear1 = "Moonshade Earring", ear2 = "Boii Earring +1",
		body = "Sakpata's Plate", hands = "Boii Mufflers +3", ring1 = "Niqmaddu Ring", ring2 = "Begrudging Ring",
		back = gear.Cichol.STR_WSD, waist = "Sailfi Belt +1", legs = "Boii Cuisses +3", feet = "Boii Calligae +3"
	}
	sets.precast.WS['Ukko\'s Fury'].PDL = set_combine(sets.precast.WS['Ukko\'s Fury'],
	{
		hands = "Sakpata's Gauntlets", ring2 = "Sroda Ring"
	})

	sets.precast.WS['King\'s Justice'] =
	{
		ammo = "Knobkierrie",
		head = "Agoge Mask +3", neck = "War. Beads +2", ear1 = "Moonshade Earring", ear2 = "Thrud Earring",
		body = "Nyame Mail", hands = "Boii Mufflers +3", ring1 = "Niqmaddu Ring", ring2 = "Regal Ring",
		back = gear.Cichol.STR_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['King\'s Justice'].PDL = set_combine(sets.precast.WS['King\'s Justice'],
	{
		ammo = "Crepuscular Pebble",
		body = "Sakpata's Plate", ring2 = "Sroda Ring",
		legs = "Boii Cuisses +3"
	})

	sets.precast.WS['Decimation'] =
	{
		ammo = "Coiste Bodhar",
		head = "Boii Mask +3", neck = "War. Beads +2", ear1 = "Schere Earring", ear2 = "Boii Earring +1",
		body = "Nyame Mail", hands = "Boii Mufflers +3", ring1 = "Niqmaddu Ring", ring2 = "Regal Ring",
		back = gear.Cichol.TP, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Decimation'].PDL = set_combine(sets.precast.WS['Decimation'],
	{
		
	})

	--Specialty WS set overwrites.
	sets.AccWSMightyCharge = {}
	sets.AccWSCharge = {}
	sets.AccWSMightyCharge = {}
	sets.WSMightyCharge = {}
	sets.WSCharge = {}
	sets.WSMighty = {}

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle =
	{
		ammo = "Staunch Tathlum +1",
		head = "Sakpata's Helm", neck = "Warder's Charm +1", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Sacro Breastplate", hands = "Macabre Gauntlets +1", ring1 = "Shadow Ring", ring2 = "Defending Ring",
		back = gear.Cichol.TP, waist = "Carrier's Sash", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	}

	sets.Kiting = { ring1 = "Shneddick Ring" }
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Engaged sets
	sets.engaged =
	{
		ammo = "Coiste Bodhar",
		head = "Boii Mask +3", neck = "War. Beads +2", ear1 = "Schere Earring", ear2 = "Boii Earring +1",
		body = "Hjarrandi Breast.", hands = "Sakpata's Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Petrov Ring",
		back = gear.Cichol.TP, waist = "Sailfi Belt +1", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	}

	sets.engaged.TwoHanded =
	{
		ammo = "Coiste Bodhar",
		head = "Boii Mask +3", neck = "War. Beads +2", ear1 = "Schere Earring", ear2 = "Boii Earring +1",
		body = "Boii Lorica +3", hands = "Sakpata's Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Moonlight Right",
		back = gear.Cichol.TP, waist = "Sailfi Belt +1", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	}

	sets.engaged.DW =
	{
		ammo = "Coiste Bodhar",
		head = "Boii Mask +3", neck = "War. Beads +2", ear1 = "Eabani Earring", ear2 = "Boii Earring +1",
		body = "Agoge Lorica +3", hands = "Sakpata's Gloves", ring1 = "Niqmaddu Ring", ring2 = "Petrov Ring",
		back = gear.Cichol.TP, waist = "Reiki Yotai", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	}

	--Extra Special Sets
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Chango = { main = "Chango", sub = "Utu Grip" }
	sets.weapons.ShiningOne = { main = "Shining One", sub = "Utu Grip" }
	sets.weapons.Greatsword = { main = "Montante +1", sub = "Utu Grip" }
	sets.weapons.Naegling = { main = "Naegling", sub = "Blurred Shield +1" }
	sets.weapons.DualWeapons = { main = "Dolichenus", sub = "Zantetsuken" }
	sets.weapons.ProcDagger = {main="Chicken Knife II",sub=empty}
	sets.weapons.ProcSword = {main="Ark Sword",sub=empty}
	sets.weapons.ProcGreatSword = {main="Lament",sub=empty}
	sets.weapons.ProcScythe = {main="Ark Scythe",sub=empty}
	sets.weapons.ProcPolearm = {main="Pitchfork +1",sub=empty}
	sets.weapons.ProcGreatKatana = {main="Hardwood Katana",sub=empty}
	sets.weapons.ProcClub = {main="Dream Bell +1",sub=empty}
	sets.weapons.ProcStaff = {main="Terra's Staff",sub=empty}

end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(3, 3)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 017')
end