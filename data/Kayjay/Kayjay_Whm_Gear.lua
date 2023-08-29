-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant','SIRD','DT')
    state.IdleMode:options('Normal','PDT','MDT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','DualWeapons','MeleeWeapons')
	state.WeaponskillMode:options('Normal','Fodder')

	state.AutoCureMode:options('Off', 'Party', 'Ally')
	state.StatusCureMode:options('Party', 'Ally', 'Off')

	gear.obi_cure_waist = "Austerity Belt +1"
	gear.obi_cure_back = "Alaunus's Cape"

	gear.obi_nuke_waist = "Sekhmet Corset"
	gear.obi_high_nuke_waist = "Yamabuki-no-Obi"
	gear.obi_nuke_back = "Toro Cape"

		-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

	-- Smartcure binds
	-- Party - Ctrl + FKey
	send_command('bind ^f1 gs c smartcure p0')
	send_command('bind ^f2 gs c smartcure p1')
	send_command('bind ^f3 gs c smartcure p2')
	send_command('bind ^f4 gs c smartcure p3')
	send_command('bind ^f5 gs c smartcure p4')
	send_command('bind ^f6 gs c smartcure p5')

	-- Top alliance - Alt + FKey
	send_command('bind !f1 gs c smartcure a10')
	send_command('bind !f2 gs c smartcure a11')
	send_command('bind !f3 gs c smartcure a12')
	send_command('bind !f4 gs c smartcure a13')
	send_command('bind !f5 gs c smartcure a14')
	send_command('bind !f6 gs c smartcure a15')

	-- Bottom alliance - WindowsKey + FKey
	send_command('bind @f1 gs c smartcure a20')
	send_command('bind @f2 gs c smartcure a21')
	send_command('bind @f3 gs c smartcure a22')
	send_command('bind @f4 gs c smartcure a23')
	send_command('bind @f5 gs c smartcure a24')
	send_command('bind @f6 gs c smartcure a25')

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Weapons sets
	sets.weapons.MeleeWeapons = {main="Izcalli",sub="Ammurapi Shield"}
	sets.weapons.DualWeapons = {main="Izcalli",sub="Nehushtan"}

	sets.buff.Sublimation = {waist="Embla Sash"}
	sets.buff.DTSublimation = {waist="Embla Sash"}
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		ammo = "Incantor Stone",
		head = "Vanya Hood", neck = "Clr. Torque +2", ear1 = "Loquac. Earring", ear2 = "Malignance Earring",
		body = "Inyanga Jubbah +2", hands = "Gende. Gages +1", ring1 = "Kishar Ring", ring2 = "Lebeche Ring",
		back = "Perimede Cape", waist = "Witful Belt", legs = "Aya. Cosciales +2", feet = "Regal Pumps +1"
	}

	sets.precast.FC.DT =
	{
		ammo = "Incantor Stone",
		head = "Vanya Hood", neck = "Clr. Torque +2", ear1 = "Loquac. Earring", ear2 = "Malignance Earring",
		body = "Inyanga Jubbah +2", hands = "Gende. Gages +1", ring1 = "Kishar Ring", ring2 = "Lebeche Ring",
		back = "Perimede Cape", waist = "Witful Belt", legs = "Aya. Cosciales +2", feet = "Regal Pumps +1"
	}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, { legs = "Ebers Pant. +1" })

	sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'],
	{
		main = "Queller's Rod", sub = "Sors Shield",
		ear2 = "Mendi. Earring",
		feet = "Vanya Clogs"
	})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})

    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Bliaut +1"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Bunzi's Hat",ear1="Roundel Earring",
		body="Piety Bliaut +1",hands="Telchine Gloves",
		waist="Chaac Belt",back="Aurist's Cape +1"}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Hasty Pinion +1",
        head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back="Moonlight Cape",waist="Olseni Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
		
    sets.precast.WS.Fodder = {ammo="Hasty Pinion +1",
        head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back="Moonlight Cape",waist="Windbuffet Belt +1",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}

    sets.precast.WS.Dagan = {ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Moonshade Earring",
		body="Kaykaus Bliaut",hands="Regal Cuffs",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Aurist's Cape +1",waist="Fotia Belt",legs="Nyame Flanchard",feet="Theo. Duckbills +3"}
		
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring"}
	sets.MaxTP.Dagan = {ear1="Etiolation Earring",ear2="Evans Earring"}

    --sets.precast.WS['Flash Nova'] = {}

    --sets.precast.WS['Mystic Boon'] = {}

    -- Midcast Sets

    sets.Kiting = { ring2 = "Shneddick Ring" }
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}
	sets.DayIdle = {}
	sets.NightIdle = {back="Umbra Cape"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})
	
	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}

	-- Conserve Mp set for spells that don't need anything else, for set_combine.
	
	sets.ConserveMP = {main=gear.grioavolr_fc_staff,sub="Umbra Strap",ammo="Hasty Pinion +1",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Gwati Earring",
		body="Vedic Coat",hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Solemnity Cape",waist="Austerity Belt +1",legs="Vanya Slops",feet="Medium's Sabots"}
		
	sets.midcast.Teleport = sets.ConserveMP
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {main=gear.grioavolr_nuke_staff,sub="Enki Strap",neck="Mizu. Kubikazari",ring1="Mujin Band",ring2="Locus Ring"}
	
    sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Bunzi's Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"}
		
    -- Cure sets

	sets.midcast['Full Cure'] = sets.midcast.FastRecast
	
	sets.midcast.Cure =
	{
		main = "Queller Rod", sub = "Sors Shield", ammo = "Staunch Tathlum +1",
		head = "Vanya Hood", neck = "Clr. Torque +2", ear1 = "Nourish. Earring +1", ear2 = "Mendi. Earring",
		body = "Ebers Bliaut +1", hands = "Weath. Cuffs +1", ring1 = "Prolix Ring", ring2 = "Mephitas's Ring +1",
		back = "Fi Follet Cape", waist = "Austerity Belt", legs = "Ebers Pant. +1", feet = "Vanya Clogs"
	}
		
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure, { body = "Ebers Bliaut +1" })
	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, { back = "Twilight Cape", waist = "Hachirin-no-Obi" })
	sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.CureSolace, sets.midcast.LightWeatherCure, {})
	sets.midcast.LightDayCure = set_combine(sets.midcast.LightWeatherCure, {})
	sets.midcast.LightDayCureSolace = set_combine(sets.midcast.CureSolace, sets.midcast.LightDayCure, {})

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
	sets.midcast.LightWeatherCuraga = set_combine(sets.midcast.Curaga, sets.midcast.LightWeatherCure, {})
	sets.midcast.LightDayCuraga = set_combine(sets.midcast.LightWeatherCuraga, {})

	sets.midcast.Cure.DT = sets.midcast.Cure

	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure =
	{
		ammo = "Pemphredo Tathlum",
		head = "Kaykaus Mitra +1", neck = "Clr. Torque +2", ear1 = "Nourish. Earring +1", ear2 = "Mendi. Earring",
		body = "Theo. Bliaut +2", hands = "Theophany Mitts +3", ring1 = "Janniston Ring", ring2 = "Mephitas's Ring +1",
		back = "Alaunus's Cape", waist = "Luminary Sash", legs = "Ebers Pant. +1", feet = "Kaykaus Boots +1"
	}

	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaut +1"})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1"})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})
	
	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1"})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaut +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})

	sets.midcast.Cursna = {main=gear.grioavolr_fc_staff,sub="Clemency Grip",ammo="Hasty Pinion +1",
		head="Ebers Cap +1",neck="Debilis Medallion",ear1="Meili Earring",ear2="Malignance Earring",
		body="Ebers Bliaut +1",hands="Fanatic Gloves",ring1="Haoma's Ring",ring2="Menelaus's Ring",
		back="Alaunus's Cape",waist="Witful Belt",legs="Th. Pant. +3",feet="Vanya Clogs"}

	sets.midcast.StatusRemoval = {main=gear.grioavolr_fc_staff,sub="Clemency Grip",ammo="Hasty Pinion +1",
		head="Ebers Cap +1",neck="Clr. Torque +2",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Ebers Pant. +1",feet="Regal Pumps +1"}
		
	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Clr. Torque +2"})

	-- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] =
	{
		main = gear.gada_enhancing_club, sub = "Ammurapi Shield", ammo = "Hasty Pinion +1",
		head = "Telchine Cap", neck = "Incanter's Torque", ear1 = "Andoaa Earring", ear2 = "Gifted Earring",
		body = "Telchine Chas.", hands = "Telchine Gloves", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Mending Cape", waist = "Embla Sash", legs = "Telchine Braconi", feet = "Theo. Duckbills +3"
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})

	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills +1"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Ammurapi Shield",hands="Regal Cuffs",waist="Emphatikos Rope",legs="Shedir Seraweels"})

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], { head = "Inyanga Tiara +2", hands = "Ebers Mitts +1", legs = "Th. Pant. +3" }) 
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet="Piety Duckbills +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet="Piety Duckbills +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",legs="Piety Pantaln. +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",legs="Piety Pantaln. +1",ear1="Gifted Earring",waist="Sekhmet Corset"})

	sets.midcast.BarElement =
	{
		main = "Beneficus", sub = "Ammurapi Shield", ammo = "Staunch Tathlum +1",
		head="Ebers Cap +1", neck = "Incanter's Torque", ear1 = "Andoaa Earring", ear2 = "Gifted Earring",
		body = "Ebers Bliaut +1", hands = "Ebers Mitts +1", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Alaunus's Cape", waist = "Olympus Sash", legs = "Piety Pantaln. +1", feet = "Ebers Duckbills +1"
	}

	sets.midcast.Impact = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=empty,neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Twilight Cloak",hands=gear.chironic_enfeeble_hands,ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back="Toro Cape",waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.chironic_nuke_feet}
		
	sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head="Bunzi's Hat",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Witching Robe",hands=gear.chironic_enfeeble_hands,ring1="Shiva Ring +1",ring2="Freke Ring",
		back="Toro Cape",waist=gear.ElementalObi,legs="Chironic Hose",feet=gear.chironic_nuke_feet}

	sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head="C. Palug Crown",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Crematio Earring",
		body="Witching Robe",hands=gear.chironic_enfeeble_hands,ring1="Metamor. Ring +1",ring2="Freke Ring",
		back="Toro Cape",waist="Yamabuki-no-Obi",legs="Chironic Hose",feet=gear.chironic_nuke_feet}

	sets.midcast['Divine Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="C. Palug Crown",neck="Incanter's Torque",ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Luminary Sash",legs="Chironic Hose",feet=gear.chironic_nuke_feet}
		
	sets.midcast.Holy = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="C. Palug Crown",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Witching Robe",hands=gear.chironic_enfeeble_hands,ring1="Metamor. Ring +1",ring2="Freke Ring",
		back="Toro Cape",waist=gear.ElementalObi,legs="Gyve Trousers",feet=gear.chironic_nuke_feet}

	sets.midcast['Dark Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Bunzi's Hat",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",hands=gear.chironic_enfeeble_hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.chironic_nuke_feet}

    sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
        body="Inyanga Jubbah +2",hands=gear.chironic_enfeeble_hands,ring1="Evanescence Ring",ring2="Archon Ring",
        back="Aurist's Cape +1",waist="Fucho-no-obi",legs="Chironic Hose",feet=gear.chironic_nuke_feet}

    sets.midcast.Drain.Resistant = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Bunzi's Hat",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
        body="Chironic Doublet",hands=gear.chironic_enfeeble_hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Aurist's Cape +1",waist="Fucho-no-obi",legs="Chironic Hose",feet=gear.chironic_nuke_feet}

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Bunzi's Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"}

	sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Bunzi's Hat",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.chironic_nuke_feet}
		
	sets.midcast.Dispel = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Bunzi's Hat",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.chironic_nuke_feet}
		
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {main="Daybreak",sub="Ammurapi Shield"})

	sets.midcast['Enfeebling Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Theophany Bliaut +2",hands="Regal Cuffs",ring1="Kishar Ring",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Obstin. Sash",legs="Chironic Hose",feet="Uk'uxkaj Boots"}

	sets.midcast['Enfeebling Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Theophany Bliaut +2",hands="Theophany Mitts +3",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Luminary Sash",legs="Chironic Hose",feet="Theo. Duckbills +3"}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = sets.midcast['Enfeebling Magic']
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = sets.midcast['Enfeebling Magic']

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {back="Alaunus's Cape"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {back="Alaunus's Cape"})

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting =
	{
		main = "Chatoyant Staff", sub = "Oneiros Grip", ammo = "Homiliary",
		head = "Inyanga Tiara +2", neck = "Twilight Torque", ear1 = "Etiolation Earring", ear2 = "Ethereal Earring",
		body = "Annoint. Kalasiris", hands = "Inyan. Dastanas +2", ring1 = "Inyanga Ring", ring2 = "Stikini Ring +1",
		back = "Moonlight Cape", waist = "Carrier's Sash", legs = "Inyanga Shalwar +2", feet = "Inyan. Crackows +2"
	}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle =
	{
		main = "Queller Rod", sub = "Sors Shield", ammo = "Homiliary",
		head = "Inyanga Tiara +2", neck = "Twilight Torque", ear1 = "Etiolation Earring", ear2 = "Ethereal Earring",
		body = "Annoint. Kalasiris", hands = "Inyan. Dastanas +2", ring1 = "Inyanga Ring", ring2 = "Stikini Ring +1",
		back = "Moonlight Cape", waist = "Carrier's Sash", legs = "Inyanga Shalwar +2", feet = "Inyan. Crackows +2"
	}

	sets.idle.PDT =
	{
		main = "Queller Rod", sub = "Sors Shield", ammo = "Homiliary",
		head = "Inyanga Tiara +2", neck = "Twilight Torque", ear1 = "Etiolation Earring", ear2 = "Ethereal Earring",
		body = "Annoint. Kalasiris", hands = "Inyan. Dastanas +2", ring1 = "Inyanga Ring", ring2 = "Stikini Ring +1",
		back = "Moonlight Cape", waist = "Carrier's Sash", legs = "Inyanga Shalwar +2", feet = "Inyan. Crackows +2"
	}

	sets.idle.MDT =
	{
		main = "Queller Rod", sub = "Sors Shield", ammo = "Homiliary",
		head = "Inyanga Tiara +2", neck = "Twilight Torque", ear1 = "Etiolation Earring", ear2 = "Ethereal Earring",
		body = "Annoint. Kalasiris", hands = "Inyan. Dastanas +2", ring1 = "Inyanga Ring", ring2 = "Stikini Ring +1",
		back = "Moonlight Cape", waist = "Carrier's Sash", legs = "Inyanga Shalwar +2", feet = "Inyan. Crackows +2"
	}

	-- Defense sets

	sets.defense.PDT = {main="Mafic Cudgel",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Shadow Mantle",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.MDT = {main="Daybreak",sub="Ammurapi Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Shadow Ring",ring2="Archon Ring",
		back="Moonlight Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.defense.MEVA = {main="Daybreak",sub="Ammurapi Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Purity Ring",ring2="Vengeful Ring",
		back="Aurist's Cape +1",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
		-- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {ammo="Staunch Tathlum +1",
        head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back="Moonlight Cape",waist="Windbuffet Belt +1",legs="Aya. Cosciales +2",feet="Battlecast Gaiters"}

    sets.engaged.Acc = {ammo="Hasty Pinion +1",
        head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Telos Earring",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back="Moonlight Cape",waist="Olseni Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}

	sets.engaged.DW = {ammo="Staunch Tathlum +1",
        head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Telos Earring",ear2="Suppanomimi",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back="Moonlight Cape",waist="Shetal Stone",legs="Aya. Cosciales +2",feet="Battlecast Gaiters"}

    sets.engaged.DW.Acc = {ammo="Hasty Pinion +1",
        head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Telos Earring",ear2="Suppanomimi",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back="Moonlight Cape",waist="Shetal Stone",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}

		-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1",back="Mending Cape"}

	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Zendik Robe",hands="Hieros Mittens",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",waist="Carrier's Sash",legs="Shedir Seraweels",feet=""}

	sets.HPCure = {main="Queller Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Nyame Helm",neck="Nodens Gorget",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Kunaji Ring",ring2="Meridian Ring",
		back="Alaunus's Cape",waist="Eschan Stone",legs="Ebers Pant. +1",feet="Kaykaus Boots"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(3, 6)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 002')
end

autows_list = {['DualWeapons']='Realmrazer',['MeleeWeapons']='Realmrazer'}

function extra_user_job_tick()
	if player.hp == 0 and #ActionStack > 0 then
		ClearActionStack()
	end

	if os.clock() - lastChat > 10 then
		if buffactive['petrification'] then
			send_command('input /p stoned')
			lastChat = os.clock()
		elseif buffactive['sleep'] then
			send_command('input /p zzz')
			lastChat = os.clock()
		end
	end

	if buffactive['paralysis'] then
		AddToStack(GetSpellFromName('Paralyna'), player.name)
	end

	if state.AutoCureMode ~= 'Off' then
		CureProcess()
	end
end

function process_chat_message(message, sender)
	local threeSlice = message:sub(1, 3)
	local fourSlice = message:sub(1, 4)
	local fiveSlice = message:sub(1, 5)
	local sixSlice = message:sub(1, 6)
	local sevenSlice = message:sub(1, 7)
	local eightSlice = message:sub(1, 8)

	local getBoost = function()
		local stats = { 'str', 'dex', 'vit', 'agi', 'int', 'mnd', 'chr' }
		if fiveSlice == 'boost' then
			for _, v in pairs(stats) do
				if eightSlice:sub(-3) == v then
					return v:upper()
				end
			end
		elseif S{ 'str', 'dex', 'vit', 'agi', 'int', 'mnd', 'chr' }:contains(threeSlice) and eightSlice:sub(-4) ~= 'down' and sevenSlice ~= 'strange' then
			for _, v in pairs(stats) do
				if threeSlice == v then
					return v:upper()
				end
			end
		end

		return nil
	end
	local boostSuffix = getBoost()

	local getStorm = function()
		if message:sub(-5) ~= 'storm' then return nil end
		local weatherMap =
		{
			sand = { 'sand', 'earth', 'stone' },
			wind = { 'wind', 'aero' },
			rain = { 'rain', 'water' },
			fire = { 'fire' },
			hail = { 'hail', 'ice', 'blizz' },
			thunder = { 'thunder' },
			void = { 'void', 'dark' },
			aurora = { 'aurora', 'light' }
		}

		for k, v in pairs(weatherMap) do
			if v:contains(fourSlice) or v:contains(fiveSlice) or v:contains(sixSlice) or v:contains(sevenSlice) then
				return k:ucfirst()
			end
		end

		return nil
	end
	local stormPrefix = getStorm()

	local fullBuffs =
	T{
		waterbuffs = { 'Protectra V', 'Shellra V', 'Barwatera', 'Barpoisonra', 'Boost-STR', 'Auspice' },
		firebuffs = { 'Protectra V', 'Shellra V', 'Barfira', 'Baramnesra', 'Boost-STR', 'Auspice' },
		thunderbuffs = { 'Protectra V', 'Shellra V', 'Barthundra', 'Barsleepra', 'Boost-STR', 'Auspice' },
		icebuffs = { 'Protectra V', 'Shellra V', 'Barblizzara', 'Barparalyzra', 'Boost-STR', 'Auspice' },
		windbuffs = { 'Protectra V', 'Shellra V', 'Baraera', 'Barsilencera', 'Boost-STR', 'Auspice' },
		stonebuffs = { 'Protectra V', 'Shellra V', 'Barstonra', 'Barpetra', 'Boost-STR', 'Auspice' },
	}

	if state.StatusCureMode == 'Party' then
		if CheckRange(sender, true) then -- In range and in party
			if fourSlice == 'slow' or fourSlice == 'grav' or fiveSlice == 'bound' or sixSlice == 'max hp' or
				sevenSlice == 'hp down' or sixSlice == 'max mp' or sevenSlice == 'mp down' or threeSlice == 'bio' or
				threeSlice == 'dia' or fiveSlice == 'erase') then
					AddToStack(GetSpellFromName('Erase'), sender, { partyCheck = true })
			elseif fourSlice == 'devo' then
				if IsAbilityReady('Devotion') then
					AddToStack(GetAbilityFromName('Devotion'), sender, { partyCheck = true })
				end
			elseif fiveSlice == 'esuna' then
				AddToStack(GetSpellFromName('Esuna'), sender, { partyCheck = true })
			elseif fiveSlice == 'sacro' then
				if IsAbilityReady('Sacrosanctity') then
					AddToStack(GetAbilityFromName('Sacrosanctity'), player.name)
				end
			elseif fiveSlice == 'sleeo' or message:sub(1, 2) == 'zz' then
				AddToStack(GetSpellFromName('Curaga', sender,
				{
					partyCheck = true,
					precastCheck = function(this)
						if os.clock() - this.addedAt < 1 then
							return true
						end
						if CheckPlayerForBuff(sender, 'sleep') then
							return true
						end
						return 'remove'
					end,
				})
			elseif fiveSlice == 'haste' then
				AddToStack(GetSpellFromName('Haste'), sender
				{
					partyCheck = true,
					precastCheck = function(this)
						if os.clock() - this.addedAt < 1 then
							return true
						end
						if CheckPlayerForBuff(sender, 'slow') then
							AddToStack(GetSpellFromName('Erase'), sender
							{
								partyCheck = true,
								precastCheck = function(this)
									if os.clock() - this.addedAt < 1 then
										return true
									end
									if CheckPlayerForBuff(sender, 'slow') then
										return true
									end
									return 'remove'
								end
							})
							return false
						end
						return true
					end,
				})
			elseif fourSlice == 'prot' then
				if CheckAoERange(sender) then
					AddToStack(GetSpellFromName('Protectra V'), player.name)
				else
					AddToStack(GetSpellFromName('Protect V'), sender)
				end
			elseif fiveSlice == 'shell' then
				if CheckAoERange(sender) then
					AddToStack(GetSpellFromName('Shellra V'), player.name)
				else
					AddToStack(GetSpellFromName('Shell V'), player.name)
				end
			elseif fiveSlice == 'sacri' or sixSlice == 'zombie' then
				AddToStack(GetSpellFromName('Sacrifice'), sender, { partyCheck = true })
			elseif fiveSlice == 'sneak' then
				AddToStack(GetSpellFromName('Sneak'), sender,
				{
					partyCheck = true,
					precastCheck = function(this)
						if os.clock() - this.addedAt < 1 then
							return true
						end
						if not CheckPlayerForBuff(sender, 'sneak') then
							return true
						end
						return 'remove'
					end,
				})
			elseif fiveSlice == 'invis' then
				AddToStack(GetSpellFromName('Invisible'), sender,
				{
					partyCheck = true,
					precastCheck = function(this)
						if os.clock() - this.addedAt < 1 then
							return true
						end
						if not CheckPlayerForBuff(sender, 'invisible') then
							return true
						end
						return 'remove'
					end,
				})
			elseif fiveSlice == 'regen' then
				AddToStack(GetSpellFromName('Regen IV'), sender, { partyCheck = true })
			elseif threeSlice == 'bar' then
				if CheckAoERange(sender) then
					if fiveSlice == 'barfi' then
						AddToStack(GetSpellFromName('Barfira'), player.name)
					elseif fiveSlice == 'barwa' then
						AddToStack(GetSpellFromName('Barwatera'), player.name)
					elseif fiveSlice == 'barth' then
						AddToStack(GetSpellFromName('Barthundra'), player.name)
					elseif fiveSlice == 'barae' or fiveSlice == 'barwi' then
						AddToStack(GetSpellFromName('Baraera'), player.name)
					elseif sevenSlice == 'barbliz' then
						AddToStack(GetSpellFromName('Barblizzara'), player.name)
					elseif fiveSlice == 'barbl' then
						AddToStack(GetSpellFromName('Barblindra'), player.name)
					elseif fiveSlice == 'baram' then
						AddToStack(GetSpellFromName('Baramnesra'), player.name)
					elseif fiveSlice == 'barpe' then
						AddToStack(GetSpellFromName('Barpetra'), player.name)
					elseif fiveSlice == 'barpo' then
						AddToStack(GetSpellFromName('Barpoisonra'), player.name)
					elseif fiveSlice == 'barpa' then
						AddToStack(GetSpellFromName('Barparalyzra'), player.name)
					elseif fiveSlice == 'barsi' then
						AddToStack(GetSpellFromName('Barsilencera'), player.name)
					elseif fiveSlice == 'barvi' then
						AddToStack(GetSpellFromName('Barvira'), player.name)
					end
				end
			elseif fiveSlice == 'auspi' then
				if CheckAoERange(sender) then
					AddToStack(GetSpellFromName('Auspice'), player.name)
				end
			elseif boostSuffix then
				if CheckAoERange(sender) then
					AddToStack(GetSpellFromName('Boost-'..boostSuffix), player.name)
				end
			elseif player.sub_job == 'RDM' and sevenSlice == 'refresh' then
				AddToStack(GetSpellFromName('Refresh'), sender, { partyCheck = true })
			elseif player.sub_job == 'SCH' and stormPrefix then
				AddToStack(GetSpellFromName(stormPrefix..'storm'), sender, { partyCheck = true })
			elseif fullBuffs:containskey(message) then
				for _, v in pairs(fullBuffs[message]) do
					AddToStack(GetSpellFromName(v), player.name)
				end
			end
		elseif CheckRange(sender, false) then -- In range and in alliance
			if fourSlice == 'para' then
				AddToStack(GetSpellFromName('Paralyna'), sender,
				{
					precastCheck = function(this)
						if os.clock() - this.addedAt < 1 then
							return true
						end
						if CheckPlayerForBuff(sender, 'paralysis') then
							return true
						end
						return 'remove'
					end,
				})
			elseif fourSlice == 'viru' or sevenSlice == 'disease' or sixSlice == 'plague' then
					AddToStack(GetSpellFromName('Viruna'), sender,
					{
						precastCheck = function(this)
							if os.clock() - this.addedAt < 1 then
								return true
							end
							local buffs = GetPlayerBuffsFromAlliance(sender)
							if buffs['plague'] or buffs['disease'] then
								return true
							end
							return 'remove'
						end,
					})
				end
			elseif fiveSlice == 'blind' then
				AddToStack(GetSpellFromName('Blindna'), sender,
				{
					precastCheck = function(this)
						if os.clock() - this.addedAt < 1 then
							return true
						end
						if CheckPlayerForBuff(sender, 'blindness') then
							return true
						end
						return 'remove'
					end,
				})
			elseif fiveSlice == 'silen' then
				AddToStack(GetSpellFromName('Silena'), sender,
				{
					precastCheck = function(this)
						if os.clock() - this.addedAt < 1 then
							return true
						end
						if CheckPlayerForBuff(sender, 'silence') then
							return true
						end
						return 'remove'
					end,
				})
			elseif fiveSlice == 'curse' or fourSlice == 'doom' then
				AddToStack(GetSpellFromName('Cursna'), sender,
				{
					precastCheck = function(this)
						if os.clock() < this.addedAt < 1 then
							return true
						end
						local buffs GetPlayerBuffsFromAlliance(sender)
						if buffs['curse'] or buffs['doom'] then
							return true
						end
						return 'remove'
					end,
				})
			elseif sixSlice == 'poison' then
				AddToStack(GetSpellFromName('Poisona'), sender
				{
					precastCheck = function(this)
						if os.clock() - this.addedAt < 1 then
							return true
						end
						if CheckPlayerForBuff(sender, 'poison') then
							return true
						end
						return 'remove'
					end,
				})
			elseif sixSlice == 'stoned' or fiveSlice == 'stona' or fourSlice == 'petra' then
				AddToStack(GetSpellFromName('Stona'), sender
				{
					precastCheck = function(this)
						if os.clock() - this.addedAt < 1 then
							return true
						end
						if CheckPlayerForBuff(sender, 'petrification') then
							return true
						end
						return 'remove'
					end,
				})
			elseif fiveSlice == 'sleep' or message:sub(1, 2) == 'zz' then
				AddToStack(GetSpellFromName('Cure'), sender,
				{
					precastCheck = function(this)
						if os.clock() - this.addedAt < 1 then
							return true
						end
						if CheckPlayerForBuff(sender, 'sleep') then
							return true
						end
						return 'remove'
					end,
				})
			elseif fiveSlice == 'haste' then
				AddToStack(GetSpellFromName('Haste'), sender
				{
					precastCheck = function(this)
						if os.clock() - this.addedAt < 1 then
							return true
						end
						local buffs = GetPlayerBuffsFromAlliance(sender)
						if not buffs['slow'] then
							return true
						end
						return 'remove'
					end,
				})
			elseif fourSlice == 'prot' then
				AddToStack(GetSpellFromName('Protect V'), sender)
			elseif fiveSlice == 'shell' then
				AddToStack(GetSpellFromName('Shell V'), sender)
			end
		elseif (fiveSlice == 'raise' or fiveSlice == 'arise') and CheckRaisable(sender) then
			local raisePrecast = function()
				if os.clock() - this.addedAt < 1 then
					return true
				end
				if CheckRaisable(sender) then
					return true
				end
				return 'remove'
			end
			local RaiseSpells = S{ 'Arise', 'Raise III', 'Raise II', 'Raise' }
			for k, v in pairs(RaiseSpells) do
				if IsSpellReady(v) then
					AddToStack(GetSpellFromName(v), sender, { precastCheck = raisePrecast })
					break
				end
			end
		end
	end
end