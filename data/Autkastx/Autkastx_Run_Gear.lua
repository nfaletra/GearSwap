function user_job_setup()

	state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal', 'DT', 'Inquartata', 'MEVA')
	state.WeaponskillMode:options('Normal', 'DT')
	state.CastingMode:options('SIRD','Normal')
	state.PhysicalDefenseMode:options('PDT_HP','PDT')
	state.MagicalDefenseMode:options('MDT_HP','MDT')
	state.ResistDefenseMode:options('MEVA','MEVA_HP')
	state.IdleMode:options('Normal', 'Evasion')
	state.Weapons:options('Aettir', 'Lionheart', 'Lycurgos', 'Evasion', 'Naegling')
	
	state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP'}

	gear.Ogma =
	{
		Idle = { name = "Ogma's Cape", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10', 'Phys. dmg. taken-10%' } },
		Parry = { name = "Ogma's Cape", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Enmity+10', 'Parrying rate+5%' } },
		FC = { name = "Ogma's Cape", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', '"Fast Cast"+10', 'Spell interruption rate down-10%' } },
	}

	-- Additional local binds
	send_command('bind ^` gs c cycle RuneElement')
	send_command('bind !` gs c RuneElement')
	send_command('bind @pause gs c toggle AutoRuneMode')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
	send_command('bind ^\\\\ input /ma "Protect IV" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Crusade" <me>')
	send_command('bind ^backspace input /ja "Lunge" <t>')
	send_command('bind @backspace input /ja "Gambit" <t>')
	send_command('bind !backspace input /ja "Rayke" <t>')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
	select_default_macro_book()
end

function init_gear_sets()
	sets.Enmity =
	{
		ammo = "Sapience Orb",
		head = "Halitus Helm", neck = "Moonlight Necklace", ear1 = "Cryptic Earring", ear2 = "Odnowa Earring +1",
		body = "Emet Harness +1", hands = "Kurys Gloves", ring1 = "Supershear Ring", ring2 = "Eihwaz Ring",
		back = gear.Ogma.Idle, waist = "Kasiri Belt", legs = "Eri. Leg Guards +2", feet = "Erilaz Greaves +2"
	}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Item sets.

	-- Precast sets to enhance JAs
	sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity, { body = "Futhark Coat +3" })
	sets.precast.JA['Odyllic Subterfuge'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Vallation'] = set_combine(sets.Enmity, { body = "Runeist Coat +2", legs = "Futhark Trousers +3" })
	sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
	sets.precast.JA['Swordplay'] = set_combine(sets.Enmity, { hands = "Futhark Mitons +3" })
	sets.precast.JA['Gambit'] = set_combine(sets.Enmity, { hands = "Runeist Mitons +1" })
	sets.precast.JA['Rayke'] = set_combine(sets.Enmity, { feet = "Futhark Boots +3" })
	sets.precast.JA['Battuta'] = set_combine(sets.Enmity, { head = "Fu. Bandeau +3" })
	sets.precast.JA['Liement'] = set_combine(sets.Enmity, { body = "Futhark Coat +3" })
	sets.precast.JA['Embolden'] = set_combine(sets.Enmity, { back = "Evasionist's Cape" })
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Last Resort'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

	sets.precast.JA['One For All'] =
	{
		head = "Rune. Bandeau +2", neck = "Futhark Torque +2", ear1 = "Etiolation Earring", ear2 = "Odnowa Earring +1",
		body = "Runeist Coat +2", hands = "Runeist Mitons +1", ring1 = "Moonlight Ring", ring2 = "Gelatinous Ring +1",
		back = "Moonlight Cape", waist = "Kasiri Belt", legs = "Futhark Trousers +3", feet = "Carmine Greaves +1"
	}

	sets.precast.JA['Lunge'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Agwu's Cap", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Hermetic Earring",
		body = "Agwu's Robe", hands = "Leyline Gloves", ring1 = "Shiva Ring +1", ring2 = "Metamor. Ring +1",
		back = "Evasionist's Cape", waist = "Eschan Stone", legs = "Agwu's Slops", feet = "Adhemar Gamashes +1"
	}
	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

	-- Gear for specific elemental nukes.
	sets.element.Dark = { head = "Pixie Hairpin +1", ring1 = "Archon Ring" }

	-- Pulse sets, different stats for different rune modes, stat aligned.
	sets.precast.JA['Vivacious Pulse'] =
	{
		ammo = "Staunch Tathlum +1",
		head = "Erilaz Galea +3", neck = "Incanter's Torque", ear1 = "Etiolation Earring", ear2 = "Odnowa Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Moonlight Ring", ring2 = "Stikini Ring +1",
		back = gear.Ogma.Idle, waist = "Engraved Belt", legs = "Runeist Trousers +1", feet = "Nyame Sollerets"
	}
	sets.precast.JA['Vivacious Pulse']['Ignis'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Gelus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Flabra'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tellus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Sulpor'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Unda'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Lux'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tenebrae'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})

	-- Waltz set (chr and vit)
	sets.precast.Waltz =
	{
		ammo = "Yamarang",
		head = "Carmine Mask +1", neck = "Unmoving Collar +1",
	}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}
	sets.precast.JA['Violent Flourish'] = {}

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		ammo = "Sapience Orb",
		head = "Rune. Bandeau +2", neck = "Baetyl Pendant", ear1 = "Loquac. Earring", ear2 = "Etiolation Earring",
		body = gear.adhemar.body.d, hands = "Leyline Gloves", ring1 = "Kishar Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Ogma.FC, waist = "Kasiri Belt", legs = "Agwu's Slops", feet = "Carmine Greaves +1"
	}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,
	{
		ring1 = "Defending Ring",
		legs = "Futhark Trousers +3"
	})
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck = "Magoraga Beads" })
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	sets.precast.WS =
	{
		ammo = "Knobkierrie",
		head = "Nyame Helm", neck = "Futhark Torque +2", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Niqmaddu Ring", ring2 = "Regal Ring",
		back = gear.Ogma.Idle, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast['Dimidiation'] = set_combine(sets.precast.WS,
	{
		neck = "Rep. Plat. Medal", ear1 = "Odr Earring",
		back = gear.Ogma.Idle, legs = "Lustratio Subligar +1", feet = "Lustratio Leggings +1"
	})

	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS,
	{
		ammo = "Coiste Bodhar",
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget",
		body = gear.adhemar.body.b, hands = gear.adhemar.hands.b, ring2 = "Epona's Ring",
		back = gear.Ogma.Idle, waist = "Fotia Belt", legs = "Samnuha Tights", feet = "Lustratio Leggings +1"
	})

	sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS,
	{
		neck = "Rep. Plat. Medal",
		waist = "Sailfi Belt +1"
	})

	sets.precast.WS['Shockwave'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Agwu's Cap", neck = "Sanctity Necklace", ear1 = "Digni. Earring", ear2 = "Crep. Earring",
		body = "Erilaz Surcoat +2", hands = "Agwu's Gages", ring1 = "Etana Ring", ring2 = "Metamor. Ring +1",
		back = gear.Ogma.Idle, waist = "Eschan Stone", legs = "Agwu's Slops", feet = "Agwu's Pigaches"
	}

	sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, { neck = "Rep. Plat. Medal" })

	sets.precast.WS['Steel Cyclone'] = set_combine(sets.precast.WS, { neck = "Rep. Plat. Medal" })

	sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, { neck = "Rep. Plat. Medal" })

	sets.precast.WS['Armor Break'] = set_combine(sets.precast.WS['Shockwave'], {})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Resolution'], {})

	sets.precast.WS['Flat Blade'] = set_combine(sets.precast.WS['Shockwave'], {})

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	sets.SIRD = -- 105% SIRD
	{
		ammo = "Staunch Tathlum +1",
		head = "Erilaz Galea +3", neck = "Moonlight Necklace", ear1 = "Magnetic Earring",
		hands = "Regal Gauntlets",
		gear.Ogma.FC, waist = "Rumination Sash", legs = "Carmine Cuisses +1", feet = "Taeon Boots" -- 9%
	}

	sets.midcast.FastRecast =
	{
		ammo = "Staunch Tathlum +1",
		head = "Rune. Bandeau +2", neck = "Futhark Torque +2", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Defending Ring", ring2 = "Kishar Ring",
		back = gear.Ogma.FC, waist = "Engraved Belt", legs = "Agwu's Slops", feet = "Nyame Sollerets"
	}

	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast,
	{
		head = "Erilaz Galea +3", neck = "Incanter's Torque", ear1 = "Andoaa Earring", ear2 = "Odnowa Earring +1",
		hands = "Runeist Mitons +1", ring1 = "Moonlight Ring", ring2 = "Stikini Ring +1",
		waist = "Flume Belt +1", legs = "Futhark Trousers +3", feet = "Erilaz Greaves +2"
	})
	sets.midcast['Enhancing Magic'].Duration = set_combine(sets.midcast['Enhancing Magic'], { hands = "Regal Gauntlets" })
	sets.midcast['Enhancing Magic'].SIRD = set_combine(sets.midcast['Enhancing Magic'].Duration, sets.SIRD, {})

	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'].Duration,
	{
		head = "Carmine Mask +1",
		body = "Nyame Mail",
		waist = "Flume Belt +1", legs = "Carmine Cuisses +1",
	})
	sets.midcast.BarElement.SIRD = set_combine(sets.midcast.BarElement, sets.SIRD, {})

	sets.midcast['Temper'] = set_combine(sets.midcast['Enhancing Magic'].Duration, {})
	sets.midcast['Temper'].SIRD = set_combine(sets.midcast['Temper'], sets.SIRD, {})

	sets.midcast['Crusade'] = set_combine(sets.midcast['Enhancing Magic'].Duration,
	{
		neck = "Futhark Torque +2", ear1 = "Etiolation Earring",
		body = "Nyame Mail",
		feet = "Nyame Sollerets"
	})
	sets.midcast['Crusade'] = set_combine(sets.midcast['Crusade'], sets.SIRD, {})

	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'].Duration,
	{
		head = "Fu. Bandeau +3",
		body = "Taeon Tabard", hands = "Taeon Gloves",
		legs = "Taeon Tights", feet = "Taeon Boots"
	})
	sets.midcast['Phalanx'].SIRD = set_combine(sets.midcast['Phalanx'], sets.SIRD, {})

	sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'].Duration, { head = "Rune. Bandeau +2", neck = "Sacro Gorget" })
	sets.midcast['Regen'].SIRD = set_combine(sets.midcast['Regen'], sets.SIRD, {})

	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'].Duration, { waist = "Gishdubar Sash" })
	sets.midcast['Refresh'].SIRD = set_combine(sets.midcast['Refresh'], sets.SIRD, {})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'].Duration, { ear2 = "Earthcry Earring", waist = "Siegel Sash" })
	sets.midcast.Stoneskin.SIRD = set_combine(sets.midcast.Stoneskin, sets.SIRD, {})

	sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Foil = set_combine(sets.Enmity, {})
	sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Jettatura = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.midcast['Blue Magic'], sets.Enmity.SIRD, {})

	sets.midcast.Cure =
	{
		ammo = "Staunch Tathlum +1",
		head = "Rune. Bandeau +2", neck = "Sacro Gorget", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Nyame Mail", hands = "Agwu's Gages", ring1 = "Defending Ring", ring2 = "Janniston Ring",
		back = gear.Ogma.FC, waist = "Luminary Sash", legs = "Agwu's Slops", feet = "Nyame Sollerets"
	}

	sets.midcast['Wild Carrot'] = set_combine(sets.midcast.Cure, {})

	sets.Self_Healing = { waist = "Gishdubar Sash" }
	sets.Cure_Received = { waist = "Gishdubar Sash" }
	sets.Self_Refresh = { waist = "Gishdubar Sash" }
	sets.Phalanx_Received = {}

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'].Duration, { ring2 = "Sheltered Ring" })
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'].Duration, { ring2 = "Sheltered Ring" })

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------
	sets.resting = {}

	sets.idle =
	{
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Futhark Torque +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Runeist Coat +2", hands = "Nyame Gauntlets", ring1 = "Stikini Ring +1", ring2 = "Gelatinous Ring +1",
		back = gear.Ogma.Idle, waist = "Engraved Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.idle.Evasion =
	{
		ammo = "Yamarang",
		head = "Nyame Helm", neck = "Bathy Choker +1", ear1 = "Eabani Earring", ear2 = "Infused Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Ilabrat Ring", ring2 = "Vengeful Ring",
		back = gear.Ogma.Idle, waist = "Kasiri Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.Kiting = { legs = "Carmine Cuisses +1" }

	sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
	sets.MP = { body = "Erilaz Surcoat +2", waist = "Flume Belt +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Weapons sets
	sets.weapons.Aettir = { main = "Aettir", sub = "Utu Grip" }
	sets.weapons.Lionheart = { main = "Lionheart", sub = "Utu Grip" }
	sets.weapons.Lycurgos = {main = "Lycurgos", sub = "Utu Grip" }
	sets.weapons.Evasion = { main = "Soulcleaver", sub = "Kupayopl" }
	sets.weapons.Naegling = { main = "Naegling", sub = "Malignance Sword" }

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = { ear2 = "Brutal Earring" }
	sets.AccMaxTP = { ear2 = "Telos Earring" }

	--------------------------------------
	-- Engaged sets
	--------------------------------------
	sets.engaged =
	{
		ammo = "Coiste Bodhar",
		head = "Dampening Tam", neck = "Anu Torque", ear1 = "Sherida Earring", ear2 = "Telos Earring",
		body = gear.adhemar.body.b, hands = gear.adhemar.hands.a, ring1 = "Niqmaddu Ring", ring2 = "Epona's Ring",
		back = gear.Ogma.Parry, waist = "Windbuffet Belt +1", legs = "Samnuha Tights", feet = gear.herculean_ta_feet
	}

	sets.engaged.DT =
	{
		ammo = "Coiste Bodhar",
		head = "Dampening Tam", neck = "Futhark Torque +2", ear1 = "Sherida Earring", ear2 = "Telos Earring",
		body = "Nyame Mail", hands = gear.adhemar.hands.a, ring1 = "Niqmaddu Ring", ring2 = "Defending Ring",
		back = gear.Ogma.Parry, waist = "Windbuffet Belt +1", legs = "Samnuha Tights", feet = "Nyame Sollerets"
	}

	sets.engaged.Inquartata =
	{
		ammo = "Yamarang",
		head = "Nyame Helm", neck = "Futhark Torque +2", ear1 = "Cryptic Earring", ear2 = "Odnowa Earring +1",
		body = "Erilaz Surcoat +2", hands = "Turms Mittens +1", ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = gear.Ogma.Parry, waist = "Engraved Belt", legs = "Eri. Leg Guards +2", feet = "Turms Leggings +1"
	}

	sets.engaged.MEVA =
	{
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Futhark Torque +2", ear1 = "Erilaz Earring", ear2 = "Odnowa Earring +1",
		body = "Runeist Coat +2", hands = "Nyame Gauntlets", ring1 = "Shadow Ring", ring2 = "Moonlight Ring",
		back = gear.Ogma.Parry, waist = "Engraved Belt", legs = "Eri. Leg Guards +2", feet = "Erilaz Greaves +2"
	}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = { }
	sets.buff.Battuta = { hands = "Turms Mittens +1" }
	sets.buff.Embolden = { back = "Evasionist's Cape" }
	sets.buff.Pflug = { feet = "Runeist Bottes +2" }
	sets.buff.Embolden = { back = "Evasionist's Cape" }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(1, 12)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 009')
end