-- Setup vars that are user-dependent.  Can override this function in a sidecar.
function user_job_setup()
	state.OffenseMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant', 'OccultAcumen')
	state.IdleMode:options('Normal')
	state.Weapons:options('None', 'Gridarvor', 'Khatvanga')

	gear.magic_jse_back = { name = "Campestres's Cape",augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}}
	gear.phys_jse_back = {name="Campestres's Cape",augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}}
	
	send_command('bind !` input /ja "Release" <me>')
	send_command('bind @` gs c cycle MagicBurst')
	send_command('bind ^` gs c toggle PactSpamMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
	send_command('bind !q gs c weapons default;gs c reset CastingMode')

	gear.Campestres =
	{
		Idle = { name = "Campestres's Cape", augments = { 'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20', 'Eva.+20 /Mag. Eva.+20', 'Pet: Accuracy+10 Pet: Rng. Acc.+10', 'Pet: "Regen"+10', 'Damage taken-5%' } },
		Magic = { name = "Campestres's Cape", augments = {'Pet: M.Acc.+20 Pet: M.Dmg.+20', 'Eva.+20 /Mag. Eva.+20', 'Pet: Mag. Acc.+10', '"Fast Cast"+10', 'Damage taken-5%' } },
	}
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Precast Sets
	--------------------------------------

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.merlinic_treasure_feet})
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Astral Flow'] = { }--head = "Glyphic Horn +1" }

	sets.precast.JA['Elemental Siphon'] =
	{
		main = "Chatoyant Staff", sub = "Vox Grip", ammo = "Esper Stone +1",
		head = "Baayami Hat", neck = "Incanter's Torque", ear1 = "Lodurr Earring", ear2 = "C. Palug Earring",
		body = "Baayami Robe", hands = "Baayami Cuffs +1", ring1 = "Evoker's Ring", ring2 = "Stikini Ring +1",
		back = "Conveyance Cape", waist = "Kobo Obi", legs = "Baayami Slops", feet = "Beck. Pigaches +1"
	}

	sets.precast.JA['Mana Cede'] = { hands = "Beck. Bracers +1" }

	-- Pact delay reduction gear
	sets.precast.BloodPactWard =
	{
		main = "Espiritus", sub = "Vox Grip", ammo = "Sancus Sachet +1",
		head = "Beckoner's Horn +2", neck = "Incanter's Torque", ear1 = "Lodurr Earring", ear2 = "C. Palug Earring",
		body = "Baayami Robe", hands = "Baayami Cuffs +1", ring1 = "Evoker's Ring", ring2 = "Stikini Ring +1",
		back = "Conveyance Cape", waist = "Kobo Obi", legs = "Baayami Slops", feet = "Baayami Sabots"
	}

	sets.precast.BloodPactRage = sets.precast.BloodPactWard

	-- Fast cast sets for spells

	sets.precast.FC =
	{
		main = "Grioavolr", sub = "Umbra Strap",
		head = "Bunzi's Hat", neck = "Orunmila's Torque", ear1 = "Loquac. Earring", ear2 = "Malignance Earring",
		body = "Inyanga Jubbah +2", hands = "Telchine Gloves", ring1 = "Kishar Ring", ring2 = "Lebeche Ring",
		back = gear.Campestres.Magic, waist = "Witful Belt", legs = "Psycloth Lappas", feet = "Regal Pumps +1"
	}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Crepuscular Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Myrkr'] =
	{
		ammo = "Epitaph",
		head = "Beckoner's Horn +2", neck = "Sanctity Necklace", ear1 = "Etiolation Earring", ear2 = "Gifted Earring",
		body = "Con. Doublet +3", hands = "Regal Cuffs", ring1 = "Mephitas's Ring +1", ring2 = "Mephitas's Ring",
		back = "Conveyance Cape", waist = "Luminary Sash", legs = "Psycloth Lappas", feet = "Beck. Pigaches +1"
	}


	--------------------------------------
	-- Midcast sets
	--------------------------------------
	sets.midcast.FastRecast =
	{
		main = "Grioavolr", sub = "Clerisy Strap +1",
		head = "Bunzi's Hat", neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Volte Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"
	}

	sets.midcast.Cure =
	{
		main = "Chatoyant Staff", ammo = "Pemphredo Tathlum",
		head = "Vanya Hood", neck = "Incanter's Torque", ear1 = "Mendi. Earring", ear2 = "Malignance Earring",
		body = "Vedic Coat", hands = "Telchine Gloves" ,ring1 = "Lebeche Ring", ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1", waist = "Luminary Sash", legs = "Assiduity Pants +1", feet = "Vanya Clogs"
	}

	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		back="Oretan. Cape +1",ring1="Haoma's Ring",ring2="Menelaus's Ring",waist="Witful Belt"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Summoning Magic'] =
	{
		main = "Mpaca's Staff", sub = "Umbra Strap", ammo = "Epitaph",
		head = "Beckoner's Horn +2", neck = "Incanter's Torque", ear1 = "Andoaa Earring", ear2 = "Lodurr Earring",
		body = "Baayami Robe", hands = "Glyphic Bracers +1", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = gear.Campestres.Magic, waist = "Emphatikos Rope", legs = "Assid. Pants +1", feet = "Glyph. Pigaches +1"
	}

	sets.midcast['Elemental Magic'] =
	{
		main = "Bunzi's Rod", sub = "Ammurapi Shield", ammo = "Ghastly Tathlum +1",
		head = "Bunzi's Hat", neck = "Baetyl Pendant", ear1 = "Crematio Earring", ear2 = "Friomisi Earring",
		body = gear.merlinic_nuke_body, hands = "Amalric Gages +1", ring1 = "Medada's Ring", ring2 = "Freke Ring",
		back = "Toro Cape", waist = "Sekhmet Corset", legs = "Merlinic Shalwar", feet = gear.amalric.feet.d
	}

    sets.midcast['Elemental Magic'].OccultAcumen = {main="Khatvanga",sub="Bloodrain Strap",ammo="Seraphicz Ampulla",
        head=gear.merlinic_nuke_head,neck="Combatant's Torque",ear1="Dedition Earring",ear2="Telos Earring",
        body=gear.merlinic_occult_body,hands=gear.merlinic_occult_hands,ring1="Rajas Ring",ring2="Petrov Ring",
        back="Toro Cape",waist="Oneiros Rope",legs="Perdition Slops",feet=gear.merlinic_occult_feet}
		
	sets.midcast.Impact =
	{
		main = "Bunzi's Rod", sub = "Ammurapi Shield", ammo = "Pemphredo Tathlum",
		head = empty,neck = "Erra Pendant", ear1 = "Enchntr. Earring +1", ear2 = "Gwati Earring",
		body = "Crepuscular Cloak", hands = "Regal Cuffs", ring1 = "Metamor. Ring +1", ring2 = "Stikini Ring +1",
		back = "Toro Cape", waist = "Acuity Belt +1", legs = "Merlinic Shalwar", feet = gear.merlinic_aspir_feet
	}
	sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {head=empty,body="Crepuscular Cloak"})

    sets.midcast['Divine Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
        head=gear.merlinic_nuke_head,neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Medada's Ring",ring2="Freke Ring",
		back="Toro Cape",waist="Sekhmet Corset",legs="Merlinic Shalwar",feet = gear.amalric.feet.d}
		
    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head=gear.merlinic_nuke_head,neck="Incanter's Torque",ear1="Digni. Earring",ear2="Gwati Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
        back="Aurist's Cape +1",waist="Yamabuki-no-Obi",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}
	
	sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Incanter's Torque",ear1="Digni. Earring",ear2="Gwati Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Archon Ring",ring2="Evanescence Ring",
        back="Aurist's Cape +1",waist="Fucho-no-obi",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}
    
    sets.midcast.Aspir = sets.midcast.Drain
		
    sets.midcast.Stun = {main="Grioavolr",sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Amalric Coif +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Volte Gloves",ring1="Kishar Ring",ring2="Stikini Ring +1",
		back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
    sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head="Amalric Coif +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Gwati Earring",
		body="Inyanga Jubbah +2",hands="Volte Gloves",ring1="Kishar Ring",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet=gear.merlinic_aspir_feet}
		
	sets.midcast['Enfeebling Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Digni. Earring",ear2="Gwati Earring",
		body=gear.merlinic_nuke_body,hands="Regal Cuffs",ring1="Kishar Ring",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Luminary Sash",legs="Psycloth Lappas",feet="Uk'uxkaj Boots"}
		
	sets.midcast['Enfeebling Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Digni. Earring",ear2="Gwati Earring",
		body=gear.merlinic_nuke_body,hands="Regal Cuffs",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Luminary Sash",legs="Psycloth Lappas",feet="Skaoi Boots"}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
		
	sets.midcast['Enhancing Magic'] =
	{
		main= "Gada", sub = "Ammurapi Shield", ammo = "Hasty Pinion +1",
		head = "Telchine Cap", neck = "Incanter's Torque", ear1 = "Andoaa Earring", ear2 = "Gifted Earring",
		body = "Telchine Chas.", hands = "Telchine Gloves", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Perimede Cape", waist = "Embla Sash", legs = "Telchine Braconi", feet = "Telchine Pigaches"
	}
		
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head="Amalric Coif +1",hands="Regal Cuffs",waist="Emphatikos Rope",legs="Shedir Seraweels"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})

	-- Avatar pact sets.  All pacts are Ability type.

	sets.midcast.Pet.BloodPactWard =
	{
		main = "Espiritus", sub = "Vox Grip", ammo = "Epitaph",
		head = "Baayami Hat", neck = "Incanter's Torque", ear1 = "Lodurr Earring", ear2 = "C. Palug Earring",
		body = "Baayami Robe", hands = "Baayami Cuffs +1", ring1 = "Evoker's Ring", ring2 = "Stikini Ring +1",
		back = "Conveyance Cape", waist = "Kobo Obi", legs = "Baayami Slops", feet = "Baayami Sabots"
	}

	sets.midcast.Pet['Wind\'s Blessing'] = set_combine(sets.midcast.Pet.BloodPactWard,
	{
		neck = "Smn. Collar +2",
		body = "Shomonjijoe +1",
		legs = "Assid. Pants +1"
	})

	sets.midcast.Pet.DebuffBloodPactWard =
	{
		main = "Espiritus", sub = "Vox Grip", ammo = "Sancus Sachet +1",
		head = "Convoker's Horn +2", neck = "Smn. Collar +2", ear1 = "Lugalbanda Earring", ear2 = "Enmerkar Earring",
		body = "Con. Doublet +3", hands = "Convo. Bracers +2", ring1 = "Evoker's Ring", ring2 = "C. Palug Ring",
		back = gear.Campestres.Magic, waist = "Regal Belt", legs = "Convo. Spats +2", feet = "Convo. Pigaches +3"
	}
	sets.midcast.Pet.DebuffBloodPactWard.Acc = sets.midcast.Pet.DebuffBloodPactWard

	sets.midcast.Pet.PhysicalBloodPactRage =
	{
		main = "Gridarvor", sub = "Elan Strap +1", ammo = "Epitaph",
		head = "Apogee Crown +1", neck = "Smn. Collar +2", ear1 = "Lugalbanda Earring", ear2 = "Beckoner's Earring +1",
		body = "Con. Doublet +3", hands = "Convo. Bracers +2", ring1 = "Varar Ring +1", ring2 = "C. Palug Ring",
		back = gear.Campestres.Idle, waist = "Incarnation Sash", legs = gear.apogee.legs.d, feet = gear.apogee.feet.b
	}

	sets.midcast.Pet.PhysicalBloodPactRage.Acc = { feet = "Convo. Pigaches +3" }

	sets.midcast.Pet.MagicalBloodPactRage =
	{
		main = "Grioavolr", sub = "Elan Strap +1", ammo = "Epitaph",
		head = "C. Palug Crown", neck = "Smn. Collar +2", ear1 = "Lugalbanda Earring", ear2 = "Gelos Earring",
		body = "Con. Doublet +3", hands = gear.merlinic.hands.BP, ring1 = "Varar Ring +1", ring2 = "Varar Ring +1",
		back = gear.Campestres.Magic, waist = "Regal Belt", legs = "Enticer's Pants", feet = gear.apogee.feet.a
	}

	sets.midcast.Pet.MagicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.MagicalBloodPactRage,
	{
		ear2 = "Enmerkar Earring",
	})

	-- Spirits cast magic spells, which can be identified in standard ways.

	sets.midcast.Pet.WhiteMagic = {} --legs="Summoner's Spats"

	sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {}) --legs="Summoner's Spats"

	sets.midcast.Pet['Elemental Magic'].Resistant = {}

	sets.midcast.Pet['Impact'] = sets.midcast.Pet.DebuffBloodPactWard

	sets.midcast.Pet['Flaming Crush'] =
	{
		main = "Grioavolr" , sub = "Elan Strap +1", ammo = "Epitaph",
		head = "C. Palug Crown", neck = "Smn. Collar +2", ear1 = "Lugalbanda Earring", ear2 = "Gelos Earring",
		body = "Apogee Dalmatica +1", hands = gear.merlinic.hands.BP, ring1 = "Varar Ring +1", ring2 = "Varar Ring +1",
		back = gear.Campestres.Magic, waist = "Regal Belt", legs = gear.apogee.legs.a, feet = gear.apogee.feet.a
	}

	sets.midcast.Pet['Mountain Buster'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, { legs = "Enticer's Pants" })
	sets.midcast.Pet['Rock Buster'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, { legs = "Enticer's Pants" })
	sets.midcast.Pet['Crescent Fang'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, { legs = "Enticer's Pants" })
	sets.midcast.Pet['Eclipse Bite'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, { legs = "Enticer's Pants" })
	sets.midcast.Pet['Blindside'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, { legs = "Enticer's Pants" })
	sets.midcast.Pet['Hysteric Assault'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, { legs = "Enticer's Pants" })

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle =
	{
		main = "Mpaca's Staff", sub = "Khonsu", ammo = "Staunch Tathlum +1",
		head = "Beckoner's Horn +2", neck = "Smn. Collar +2", ear1 = "Eabani Earring", ear2 = "Beck. Earring +1",
		body = "Shomonjijoe +1", hands = "Inyan. Dastanas +2", ring1 = "Inyanga Ring", ring2 = "Stikini Ring +1",
		back = "Moonlight Cape", waist = "Carrier's Sash", legs = "Inyanga Shalwar +2", feet = "Baayami Sabots"
	}

	-- perp costs:
	-- spirits: 7
	-- carby: 11 (5 with mitts)
	-- fenrir: 13
	-- others: 15
	-- avatar's favor: -4/tick

	-- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
	-- Aim for -14 perp, and refresh in other slots.

	-- Can make due without either the head or the body, and use +refresh items in those slots.

	sets.idle.Avatar =
	{
		main = "Gridarvor", sub = "Elan Strap +1", ammo = "Sancus Sachet +1",
		head = "Beckoner's Horn +2", neck = "Smn. Collar +2", ear1 = "Cath Palug Earring", ear2 = "Beck. Earring +1",
		body = "Beck. Doublet +2", hands = "Inyan. Dastanas +2", ring1 = "Inyanga Ring", ring2 = "Defending Ring",
		back = gear.Campestres.Idle, waist = "Isa Belt", legs = "Inyanga Shalwar +2", feet = "Baayami Sabots"
	}
	sets.idle.Spirit = sets.idle.Avatar

	--Favor always up and head is best in slot idle so no specific items here at the moment.
	sets.idle.Avatar.Favor = {}
	sets.idle.Avatar.Engaged = {}
	
	sets.idle.Avatar.Engaged.Carbuncle = {}
	sets.idle.Avatar.Engaged['Cait Sith'] = {}

	sets.perp = {}
	-- Caller's Bracer's halve the perp cost after other costs are accounted for.
	-- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
	-- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
	-- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
	sets.perp.Day = {}
	sets.perp.Weather = {}

	sets.perp.Carbuncle = {}
	sets.perp.Diabolos = {}
	sets.perp.Alexander = sets.midcast.Pet.BloodPactWard

	-- Not really used anymore, was for the days of specific staves for specific avatars.
	sets.perp.staff_and_grip = {}

	sets.Kiting = { ring2 = "Shneddick Ring" }
	sets.latent_refresh = { waist = "Fucho-no-obi" }
	sets.latent_refresh_grip = { sub = "Oneiros Grip" }
	sets.TPEat = { neck = "Chrys. Torque" }
	sets.DayIdle = {}
	sets.NightIdle = {}

	sets.HPDown = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = { neck = "Sacrifice Torque" }

	-- Weapons sets
	sets.weapons.Gridarvor = { main = "Gridarvor", sub = "Elan Strap +1" }
	sets.weapons.Khatvanga = { main = "Khatvanga", sub = "Bloodrain Strap" }

	sets.buff.Sublimation = { waist = "Embla Sash" }
	sets.buff.DTSublimation = { waist = "Embla Sash" }
	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Normal melee group
	sets.engaged = set_combine(sets.idle.Avatar,
	{
		hands = "Bunzi's Gloves", ear2 = "Telos Earring",
		waist = "Cornelia's Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
	-- Default macro set/book
	set_macro_page(1, 17)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 010')
end