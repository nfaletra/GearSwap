function user_job_setup()
	-- Options: Override default values
	state.CastingMode:options('Normal','Resistant','Proc','OccultAcumen')
	state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal','DT')
	state.IdleMode:options('Normal')
	state.Weapons:options('None', 'Mpaca', 'Khatvanga', 'Death')

	gear.Taranus =
	{
		Idle = { name = "Taranus's Cape", augments = { 'MP+60', 'Mag. Acc+20 /Mag. Dmg.+20', 'MP+20', '"Fast Cast"+10', 'Damage taken-5%' } },
		MAB = { name = "Taranus's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', 'Damage taken-5%' } },
	}

		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode') 
	send_command('bind ~^` gs c cycleback ElementalMode') --Robbiewobbie's idea
	send_command('bind ^d gs c set weapons Death;gs c set DeathMode Lock')
	send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
	send_command('bind ^r gs c weapons Default;gs c reset CastingMode;gs c reset DeathMode;gs c reset MagicBurstMode')
	send_command('bind !\\\\ input /ja "Manawell" <me>')
	send_command('bind !` input /ma "Aspir III" <t>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f9 gs c cycle DeathMode')
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace input /ja "Enmity Douse" <t>')
	send_command('bind @backspace input /ja "Alacrity" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind @= input /ja "Addendum: White" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
    
	select_default_macro_book()
end

function init_gear_sets()

    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	-- Weapons sets
	sets.weapons.Mpaca = { main = "Mpaca's Staff", sub = "Enki Strap" }
	sets.weapons.Khatvanga = { main = "Khatvanga", sub = "Khonsu" }
	sets.weapons.Death = { main = "Mpaca's Staff", sub = "Niobid St" }
	
    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}	
	
	-- Treasure Hunter
	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.merlinic_treasure_feet})
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {back=gear.nuke_jse_back,feet="Wicce Sabots +1"}

    sets.precast.JA.Manafont = {} --body="Sorcerer's Coat +2"
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

	sets.precast.FC =
	{
		ammo = "Impatiens",
		head = "Merlinic Hood", neck = "Voltsurge Torque", ear1 = "Malignance Earring", ear2 = "Etiolation Earring",
		body = "Merlinic Jubbah", hands = gear.merlinic.hands.FC, ring1 = "Lebeche Ring", ring2 = "Medada's Ring",
		back = gear.Taranus.Idle, waist = "Witful Belt", legs = "Agwu's Slops", feet = "Merlinic Crackows"
	}
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC,
	{
		head = "Amalric Coif +1", ear2 = "Loquac. Earring",
		body = "Dalmatica +1", hands = "Nyame Gauntlets", ring2 = "Defending Ring",
		feet = "Nyame Sollerets"
	})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, { head = empty, body = "Crepuscular Cloak" })
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Genmei Shield" })

	sets.precast.FC.Death = set_combine(sets.precast.FC,
	{
		head = "Amalric Coif +1",
		body = "Wicce Coat +3", hands = "Agwu's Gages", ring1 = "Mephitas's Ring +1",
		legs = "Psycloth Lappas", feet = gear.amalric.feet.a
	})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ghastly Tathlum +1",
		head="Nyame Helm",neck="Saevus Pendant +1",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Freke Ring",ring2="Shiva Ring +1",
		back= gear.Taranus.Idle ,waist="Fotia Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Vidohunir'] =
	{
		ammo = "Ghastly Tathlum +1",
		head = "Pixie Hairpin +1", neck = "Src. Stole +2", ear1 = "Malignance Earring", ear2 = "Regal Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Freke Ring", ring2 = "Epaminondas's Ring",
		back = gear.Taranus.Idle, waist = "Acuity Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Shattersoul'] =
	{
		ammo = "Oshasha's Treatise",
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Malignance Earring", ear2 = "Regal Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Freke Ring", ring2 = "Epaminondas's Ring",
		back = gear.Taranus.Idle, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Earth Crusher'] =
	{
		ammo = "Sroda Tathlum",
		head = "Agwu's Cap", neck = "Quanpur Necklace", ear1 = "Malignance Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Wicce Gloves +2", ring1 = "Freke Ring", ring2 = "Epaminondas's Ring",
		back = gear.Taranus.Idle, waist = "Acuity Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Cataclysm'] =
	{
		ammo = "Sroda Tathlum",
		head = "Pixie Hairpin +1", neck = "Saevus Pendant +1", ear1 = "Malignance Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Wicce Gloves +2", ring1 = "Archon Ring", ring2 = "Epaminondas's Ring",
		back = gear.Taranus.Idle, waist = "Acuity Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Myrkr'] =
	{
		ammo = "Psilomene",
		head = "Amalric Coif +1", neck = "Dualism Collar +1", ear1 = "Moonshade Earring", ear2 = "Etiolation Earring",
		body = "Amalric Doublet +1", hands = "Spae. Gloves +3", ring1 = "Mephitas's Ring +1", ring2 = "Sangoma Ring",
		back = "Bane Cape", waist = "Shinjutsu-no-Obi +1", legs = "Amalric Slops +1", feet = "Psycloth Boots"
	}

	---- Midcast Sets ----
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

	sets.midcast.Cure =
	{
		ammo = "Staunch Tathlum +1",
		head = "Vanya Hood", neck = "Incanter's Torque", ear1 = "Mendi. Earring", ear2 = "Meili Earring",
		body = "Vrikodara Jupon", hands = "Wicce Gloves +2", ring1 = "Menelaus's Ring", ring2 = "Defending Ring",
		back = "Aurist's Cape +1", waist = "Luminary Sash", legs = "Gyve Trousers", feet = "Vanya Clogs"
	}

	sets.midcast.Curaga = sets.midcast.Cure
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure,
	{
		neck = "Debilis Medallion",
		hands = "Hieros Mittens", ring1 = "Menelaus's Ring", ring2 = "Haoma's Ring",
		back = "Oretan. Cape +1"
	})

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast,
	{
		main = "Gada", sub = "Ammurapi Shield",
		head = "Telchine Cap", neck = "Incanter's Torque", ear1 = "Andoaa Earring", ear2 = "Calamitous Earring",
		body = "Telchine Chas.", hands = gear.telchine.hands.enhancing, ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1", waist = "Embla Sash", legs = "Telchine Braconi", feet = "Telchine Pigaches"
	})
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], { ear2 = "Earthcry Earring" })
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], { head = "Amalric Coif +1" })
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], { head = "Amalric Coif +1", hands = "Regal Cuffs" })
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.midcast['Enfeebling Magic'] =
	{
		main = "Contemplator +1", sub = "Khonsu", ammo = "Pemphredo Tathlum",
		head = empty, neck = "Src. Stole +2", ear1 = "Malignance Earring", ear2 = "Regal Earring",
		body = "Cohort Cloak +1", hands = "Regal Cuffs", ring1 = "Kishar Ring", ring2 = "Metamor. Ring +1",
		back = "Aurist's Cape +1", waist = "Acuity Belt +1", legs = "Spae. Tonban +3", feet = "Spae. Sabots +3"
	}

	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'],
	{
		head = "Wicce Petasos +2",
		body = "Spae. Coat +3", hands = "Spae. Gloves +3", ring1 = "Stikini Ring +1",
		legs = "Arch. Tonban +3", feet = "Arch. Sabots +3"
	})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

	sets.midcast['Dark Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'],
	{
		main = "Rubicundity", sub = "Ammurapi Shield", ammo = "Pemphredo Tathlum",
		head = "Pixie Hairpin +1", neck = "Erra Pendant", ear1 = "Hirudinea Earring", ear2 = "Regal Earring",
		ring1 = "Evanescence Ring", ring2 = "Archon Ring",
		waist = "Fucho-no-obi", feet = "Agwu's Pigaches"
	})
	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Death =
	{
		ammo = "Ghastly Tathlum +1",
		head = "Pixie Hairpin +1", neck = "Sanctity Necklace", ear1 = "Barkaro. Earring", ear2 = "Etiolation Earring",
		body = "Amalric Doublet +1", hands = "Amalric Gages +1", ring1 = "Mephitas's Ring +1", ring2 = "Archon Ring",
		back = gear.Taranus.Idle, waist = "Shinjutsu-no-Obi +1", legs = "Amalric Slops +1",feet = gear.amalric.feet.a
	}
	sets.midcast.Death.Resistant = set_combine(sets.midcast.Death,
	{
		head = "Amalric Coif +1", ear2 = "Regal Earring",
		body = "Wicce Coat +3", hands = "Spae. Gloves +3",
		waist = "Acuity Belt +1", legs = "Spae. Tonban +3", feet = "Wicce Sabots +2"
	})

    sets.midcast.Stun = {sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
        head="Amalric Coif +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
        body="Zendik Robe",hands="Volte Gloves",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back=gear.Taranus.Idle,waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
    sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Amalric Coif +1",neck="Erra Pendant",ear1="Malignance Earring",ear2="Regal Earring",
        body="Zendik Robe",hands="Volte Gloves",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back=gear.Taranus.Idle,waist="Witful Belt",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}

    sets.midcast.BardSong = {main="Daybreak",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head="Amalric Coif +1",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Regal Earring",
		body="Zendik Robe",hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back=gear.Taranus.Idle,waist="Luminary Sash",legs="Merlinic Shalwar",feet="Medium's Sabots"}
		
	sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'],
	{
		body = "Crepuscular Cloak", hands = "Spae. Gloves 3", ring1 = "Stikini Ring +1",
		legs = "Wicce Chausses +3",
	})

	-- Elemental Magic sets
	sets.midcast['Elemental Magic'] =
	{
		ammo = "Sroda Tathlum",
		head = "Wicce Petasos +2", neck = "Src. Stole +2", ear1 = "Malignance Earring", ear2 = "Regal Earring",
		body = "Wicce Coat +3", hands = "Wicce Gloves +2", ring1 = "Freke Ring", ring2 = "Metamor. Ring +1",
		back = gear.Taranus.MAB, waist = "Acuity Belt +1", legs = "Wicce Chausses +3", feet = "Wicce Sabots +2"
	}
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].OccultAcumen = set_combine(sets.midcast['Elemental Magic'],
	{
		ammo = "Seraphic Ampulla",
		neck = "Combatant's Torque", ear1 = "Dedition Earring", ear2 = "Crep. Earring",
		body = "Spae. Coat +3", ring1 = "Chirich Ring +1", ring2 = "Crepuscular Ring",
		waist = "Oneiros Rope", legs = "Perdition Slops",
	})

	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant
		
		-- Minimal damage gear, maximum recast gear for procs.
    sets.midcast['Elemental Magic'].Proc = {main=empty,sub=empty,ammo="Impatiens",
        head="Vanya Hood",neck="Loricate Torque +1",ear1="Gifted Earring",ear2="Loquac. Earring",
        body="Spaekona's Coat +3",hands="Regal Cuffs",ring1="Kishar Ring",ring2="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Assid. Pants +1",feet="Regal Pumps +1"}
		
    sets.midcast['Elemental Magic'].OccultAcumen = {main="Khatvanga",sub="Bloodrain Strap",ammo="Seraphic Ampulla",
        head="Mall. Chapeau +2",neck="Combatant's Torque",ear1="Dedition Earring",ear2="Telos Earring",
        body=gear.merlinic_occult_body,hands=gear.merlinic_occult_hands,ring1="Rajas Ring",ring2="Petrov Ring",
        back=gear.Taranus.MAB,waist="Oneiros Rope",legs="Perdition Slops",feet=gear.merlinic_occult_feet}
		
	sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {head=empty,body="Crepuscular Cloak"})
	
	-- Sets to return to when not performing an action.
	-- Idle sets

	-- Normal refresh idle set
	sets.idle =
	{
		main = "Mpaca's Staff", sub = "Khonsu", ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Warder's Charm +1", ear1 = "Lugalbanda Earring", ear2 = "Etiolation Earring",
		body = "Wicce Coat +3", hands = "Nyame Gauntlets", ring1 = "Mephitas's Ring +1", ring2 = "Shadow Ring",
		back = gear.Taranus.Idle, waist = "Carrier's Sash", legs = "Agwu's Slops", feet = "Nyame Sollerets"
	}

	sets.idle.Death =
	{
		ammo = "Ghastly Tathlum +1",
		head = "Wicce Petasos +2", neck = "Sanctity Necklace", ear1 = "Nehalennia Earring", ear2 = "Etiolation Earring",
		body = "Ros. Jaseran +1", hands = "Nyame Gauntlets", ring1 = "Mephitas's Ring +1", ring2 = "Mephitas's Ring",
		back = gear.Taranus.Idle, waist = "Shinjutsu-no-Obi +1", legs= "Amalric Slops +1", feet = "Wicce Sabots +2"
	}

	sets.Kiting = { ring2 = "Shneddick Ring" }

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.HPDown = {head="Pixie Hairpin +1",ear1="Genmei Earring",ear2="Evans Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",legs="Shedir Seraweels",feet="Jhakri Pigaches +2"}
		
	sets.HPCure = {main="Chatoyant Staff",ammo="Hasty Pinion +1",
		head="Nyame Helm",neck="Nodens Gorget",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Kunaji Ring",ring2="Meridian Ring",
		back="Tempered Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Vanya Clogs"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff['Mana Wall'] = {back=gear.Taranus.Idle,feet="Wicce Sabots +1"}
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Spaekona's Coat +3"}
	sets.RecoverBurst = {body="Spaekona's Coat +3"}
	-- Gear for Magic Burst mode.
	sets.MagicBurst =
	{
		ammo = "Ghastly Tathlum +1",
		head = "Ea Hat +1", neck = "Src. Stole +2", ear1 = "Malignance Earring", ear2 = "Regal Earring",
		body = "Wicce Coat +3", hands = "Agwu's Gages", ring1 = "Freke Ring", ring2 = "Metamor. Ring +1",
		back = gear.Taranus.MAB, waist = "Acuity Belt +1", legs = "Wicce Chausses +3", feet = "Agwu's Pigaches"
	}
	sets.MagicBurst.Resistant = set_combine(sets.MagicBurst,
	{
		ammo = "Pemphredo Tathlum",
		head = "Wicce Petasos +2", hands = "Wicce Gloves +2", ring1 = "Stikini Ring +1",
		feet = "Spae. Sabots +3"
	})

	sets.MagicBurst.Death = set_combine(sets.MagicBurst,
	{
		head = "Pixie Hairpin +1", ear1 = "Bararko. Earring", ear2 = "Etiolation Earring",
		ring1 = "Mephitas's Ring +1", ring2 = "Archon Ring",
		waist = "Shinjutsu-no-Obi +1", feet = "Amalric Nails +1"
	})
	sets.MagicBurst.Death.Resistant = set_combine(sets.MagicBurst.Death,
	{
		head = "Amalric Coif +1", ear2 = "Regal Earring",
		gloves = "Spae. Gloves +3", ring1 = "Metamor. Ring +1",
		waist = "Acuity Belt +1", feet = "Spae. Sabots +3"
	})

	-- Gear for specific elemental nukes.
	sets.element.Dark = { }
	sets.element.Earth = { neck = "Quanpur Necklace" }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged =
	{
		ammo = "Amar Cluster",
		head = "Nyame Helm", neck = "Combatant's Torque", ear1 = "Telos Earring", ear2 = "Mache Earring +1",
		body = "Nyame Mail", hands = "Gazu Bracelets +1", ring1 = "Chirich Ring +1", ring2 = "Chirich Ring +1",
		back = gear.Taranus.Idle, waist = "Olseni Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.engaged.DT = set_combine(sets.engaged, { ring2 = "Defending Ring" })

	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 7)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 005')
end

state.Weapons:options('None','BurstWeapons','Khatvanga','Lathi')

autows_list = {['BurstWeapons']='Myrkr',['Khatvanga']='Myrkr',['Lathi']='Myrkr'}