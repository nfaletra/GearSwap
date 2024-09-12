function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal')
	state.WeaponskillMode:options('Match', 'Normal', 'PDL', 'Proc')
	state.HybridMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
	state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal')
	state.ExtraMeleeMode = M{ ['description']='Extra Melee Mode', 'None' }
	state.Passive = M{ ['description'] = 'Passive Mode', 'None', 'Twilight' }
	state.Weapons:options('Chango', 'ShiningOne', 'Greatsword', 'Naegling', 'DualWeapons', 'ProcDagger', 'ProcSword', 'ProcGreatSword', 'ProcScythe', 'ProcPolearm', 'ProcGreatKatana', 'ProcClub', 'ProcStaff')

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
	sets.precast.JA['Berserk'] = {back="Cichol's Mantle"}
	sets.precast.JA['Warcry'] = {}
	sets.precast.JA['Defender'] = {}
	sets.precast.JA['Aggressor'] = {}
	sets.precast.JA['Mighty Strikes'] = {}
	sets.precast.JA["Warrior's Charge"] = {}
	sets.precast.JA['Tomahawk'] = { ammo = "Thr. Tomahawk" }
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
		head = "Nyame Helm", neck = "War. Beads +2", ear1 = "Thrud Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Regal Ring",
		back = "Atheling Mantle", waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Upheaval'].PDL = set_combine(sets.precast.WS['Upheaval'],
	{
		head = "Sakpata's Helm",
		body = "Sakpata's Plate", hands = "Sakpata's Gauntlets", ring2 = "Sroda Ring",
	})

	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Rampage'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Raging Rush'] = set_combine(sets.precast.WS, {})

	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {})

	sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {})

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
		head = "Nyame Helm", neck = "Warder's Charm +1", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Shadow Ring", ring2 = "Defending Ring",
		back = "Atheling Mantle", waist = "Carrier's Sash", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.Kiting = { ring1 = "Shneddick Ring" }
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Engaged sets
	sets.engaged =
	{
		ammo = "Coiste Bodhar",
		head = "Nyame Helm", neck = "War. Beads +2", ear1 = "Schere Earring", ear2 = "Boii Earring +1",
		body = "Nyame Mail", hands = "Sakpata's Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Moonlight Ring",
		back = "Cichol's Mantle", waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.engaged.DW =
	{

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
	sets.weapons.DualWeapons = { main = "Firangi", sub = "Reikiko" }
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