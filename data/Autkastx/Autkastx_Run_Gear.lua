function user_job_setup()

	state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal', 'DT', 'MEVA', 'DD')
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
		ammo = "Staunch Tathlum +1",
		head = "Halitus Helm", neck = "Futhark Torque +2", ear1 = "Odnowa Earring +1", ear2 = "Cryptic Earring",
		body = "Emet Harness +1", hands = "Kurys Gloves", ring1 = "Moonlight Ring", ring2 = "Eihwaz Ring",
		back = gear.Ogma.Idle, waist = "Kasiri Belt", legs = "Eri. Leg Guards +2", feet = "Erilaz Greaves +2"
	}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Item sets.

	-- Precast sets to enhance JAs
	sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity, { body = "Futhark Coat +3" })
	sets.precast.JA['Odyllic Subterfuge'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Vallation'] = set_combine(sets.Enmity, { body = "Runeist Coat +3", legs = "Futhark Trousers +3" })
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
		body = "Runeist Coat +3", hands = "Runeist Mitons +1", ring1 = "Moonlight Ring", ring2 = "Gelatinous Ring +1",
		back = "Moonlight Cape", waist = "Kasiri Belt", legs = "Futhark Trousers +3", feet = "Carmine Greaves +1"
	}

	sets.precast.JA['Lunge'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Agwu's Cap", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Crematio Earring",
		body = "Agwu's Robe", hands = "Leyline Gloves", ring1 = "Mujin Band", ring2 = "Metamor. Ring +1",
		back = gear.Ogma.Idle, waist = "Orpheus's Sash", legs = "Agwu's Slops", feet = "Agwu's Pigaches"
	}
	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

	-- Gear for specific elemental nukes.
	sets.element.Dark = { head = "Pixie Hairpin +1", ring1 = "Archon Ring" }

	-- Pulse sets, different stats for different rune modes, stat aligned.
	sets.precast.JA['Vivacious Pulse'] =
	{
		head = "Erilaz Galea +3", neck = "Incanter's Torque", ear1 = "Saxnot Earring", ear2 = "Beautific Earring",
		ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Altruistic Cape", waist = "Bishop's Sash", legs = "Runeist Trousers +1"
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
		head = "Rune. Bandeau +2", neck = "Orunmila's Torque", ear1 = "Odnowa Earring +1", ear2 = "Etiolation Earring",
		body = "Erilaz Surcoat +3", hands = "Leyline Gloves", ring1 = "Medada's Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Ogma.FC, waist = "Kasiri Belt", legs = "Agwu's Slops", feet = "Carmine Greaves +1"
	}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,
	{
		neck = "Unmoving Collar +1", ear1 = "Loquac. Earring",
		ring1 = "Moonlight Ring",
		waist = "Siegel Sash", legs = "Futhark Trousers +3"
	})
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck = "Magoraga Beads" })
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	sets.precast.WS =
	{
		ammo = "Knobkierrie",
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Ishvara Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Epaminondas's Ring",
		back = gear.Ogma.Idle, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast['Dimidiation'] = set_combine(sets.precast.WS,
	{
		neck = "Fotia Gorget", ear1 = "Sherida Earring",
		ring2 = "Niqmaddu Ring",
		back = gear.Ogma.Idle, waist = "Kentarch Belt +1"
	})

	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS,
	{
		ammo = "Coiste Bodhar",
		neck = "Fotia Gorget", ear1 = "Sherida Earring",
		ring2 = "Epona's Ring",
		waist = "Fotia Belt",
	})

	sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Shockwave'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Agwu's Cap", neck = "Sanctity Necklace", ear1 = "Digni. Earring", ear2 = "Crep. Earring",
		body = "Erilaz Surcoat +2", hands = "Agwu's Gages", ring1 = "Etana Ring", ring2 = "Metamor. Ring +1",
		back = gear.Ogma.Idle, waist = "Eschan Stone", legs = "Agwu's Slops", feet = "Agwu's Pigaches"
	}

	sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Steel Cyclone'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Armor Break'] = set_combine(sets.precast.WS['Shockwave'], {})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Resolution'], {})

	sets.precast.WS['Flat Blade'] = set_combine(sets.precast.WS['Shockwave'], {})

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	sets.SIRD = -- 104% SIRD
	{
		ammo = "Staunch Tathlum +1",
		head = "Erilaz Galea +3", neck = "Moonlight Necklace", ear1 = "Magnetic Earring",
		hands = "Regal Gauntlets",
		gear.Ogma.FC, waist = "Rumination Sash", legs = "Carmine Cuisses +1",
	}

	sets.midcast.FastRecast =
	{
		ammo = "Sapience Orb",
		head = "Rune. Bandeau +2", neck = "Orunmila's Torque", ear1 = "Odnowa Earring +1", ear2 = "Etiolation Earring",
		body = "Erilaz Surcoat +3", hands = "Leyline Gloves", ring1 = "Medada's Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Ogma.FC, waist = "Kasiri Belt", legs = "Agwu's Slops", feet = "Carmine Greaves +1"
	}

	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast,
	{
		head = "Erilaz Galea +3", neck = "Incanter's Torque", ear1 = "Odnowa Earring +1", ear2 = "Mimir Earring",
		body = "Nyame Mail", hands = "Runeist Mitons +1", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Moonlight Cape", waist = "Olympus Sash", legs = "Futhark Trousers +3",
	})
	sets.midcast['Enhancing Magic'].SIRD = set_combine(sets.midcast['Enhancing Magic'], sets.SIRD, {})

	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.BarElement.SIRD = set_combine(sets.midcast.BarElement, sets.SIRD, {})

	sets.midcast['Temper'] = set_combine(sets.midcast['Enhancing Magic'],
	{
		head = "Carmine Mask +1", ear1 = "Andoaa Earring",
		back = "Merciful Cape", legs = "Carmine Cuisses +1"
	})
	sets.midcast['Temper'].SIRD = set_combine(sets.midcast['Temper'], sets.SIRD, {})

	sets.midcast['Crusade'] = set_combine(sets.midcast['Enhancing Magic'],
	{
		neck = "Futhark Torque +2", ear1 = "Etiolation Earring",
		body = "Nyame Mail",
		feet = "Nyame Sollerets"
	})
	sets.midcast['Crusade'].SIRD = set_combine(sets.midcast['Crusade'], sets.SIRD, {})

	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'],
	{
		ammo = "Staunch Tathlum +1",
		head = "Fu. Bandeau +3",
		body = "Taeon Tabard", hands = "Taeon Gloves", ring2 = "Gelatinous Ring +1",
		back = "Moonlight Cape", legs = "Taeon Tights", feet = "Taeon Boots"
	})
	sets.midcast['Phalanx'].SIRD = set_combine(sets.midcast['Phalanx'], sets.SIRD, {})

	sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'],
	{
		ammo = "Staunch Tathlum +1",
		head = "Rune. Bandeau +2", neck = "Sacro Gorget", ear2 = "Erilaz Earring",
		hands = "Regal Gauntlets", ring1 = "Moonlight Ring", rign2 = "Gelatinous Ring +1",
		back = gear.Ogma.FC, waist = "Flume Belt +1"
	})
	sets.midcast['Regen'].SIRD = set_combine(sets.midcast['Regen'], sets.SIRD, {})

	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], { waist = "Gishdubar Sash" })
	sets.midcast['Refresh'].SIRD = set_combine(sets.midcast['Refresh'], sets.SIRD, {})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], { ear2 = "Earthcry Earring", waist = "Siegel Sash" })
	sets.midcast.Stoneskin.SIRD = set_combine(sets.midcast.Stoneskin, sets.SIRD, {})

	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.FastRecast,
	{
		ammo = "Pemphredo Tathlum",
		head = "Agwu's Cap", neck = "Futhark Torque +2", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Nyame Mail", hands = "Agwu's Gages", ring1 = "Defending Ring", ring2 = "Metamor. Ring +1",
		back = gear.Ogma.Idle, waist = "Acuity Belt +1", legs = "Agwu's Slops", feet = "Agwu's Pigaches"
	})
	sets.midcast['Enfeebling Magic'].SIRD = set_combine(sets.midcast['Enfeebling Magic'], sets.SIRD, {})

	sets.midcast.Flash = set_combine(sets.midcast.FastRecast, sets.Enmity, {})
	sets.midcast.Flash.SIRD = set_combine(sets.midcast.Flash, sets.SIRD, {})
	sets.midcast.Foil = set_combine(sets.midcast.FastRecast, sets.Enmity, {})
	sets.midcast.Foil.SIRD = set_combine(sets.midcast.Foil, sets.SIRD, {})
	sets.midcast.Stun = set_combine(sets.midcast.FastRecast, sets.Enmity, {})
	sets.midcast['Blue Magic'] = set_combine(sets.midcast.FastRecast, sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.midcast['Blue Magic'], sets.SIRD, {})

	sets.midcast.Cure =
	{
		ammo = "Sapience Orb",
		head = "Nyame Helm", neck = "Sacro Gorget", ear1 = "Mendicant's Earring", ear2 = "Cryptic Earring",
		body = "Nyame Mail", hands = "Erilaz Gauntlets +2", ring1 = "Moonlight Ring", ring2 = "Eihwaz Ring",
		back = gear.Ogma.Parry, waist = "Sroda Belt", legs = "Erilaz Leg Guards +2", feet = "Erilaz Greaves +2"
	}
	sets.midcast.Cure.SIRD = set_combine(sets.midcast.Cure, sets.SIRD, {})

	sets.midcast['Wild Carrot'] = set_combine(sets.midcast.Cure, {})
	sets.midcast['Wild Carrot'] = set_combine(sets.midcast.Cure.SIRD, {})

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
		head = "Nyame Helm", neck = "Futhark Torque +2", ear1 = "Odnowa Earring +1", ear2 = "Tuisto Earring",
		body = "Erilaz Surcoat +3", hands = "Nyame Gauntlets", ring1 = "Moonlight Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Ogma.Idle, waist = "Flume Belt +1", legs = "Nyame Flanchard", feet = "Erilaz Greaves +2"
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
	sets.weapons.Aettir = { main = "Aettir", sub = "Refined Grip +1" }
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
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Futhark Torque +2", ear1 = "Odnowa Earring +1", ear2 = "Erilaz Earring",
		body = "Erilaz Surcoat +3", hands = "Turms Mittens +1", ring1 = "Moonlight Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Ogma.Parry, waist = "Engraved Belt", legs = "Eri. Leg Guards +2", feet = "Turms Leggings +1"
	}

	sets.engaged.DT =
	{
		ammo = "Staunch Tathlum +1",
		head = "Erilaz Galea +3", neck = "Warder's Charm +1", ear1 = "Odnowa Earring +1", ear2 = "Tuisto Earring",
		body = "Erilaz Surcoat +3", hands = "Erilaz Gauntlets +2", ring1 = "Moonlight Ring", ring2 = "Shadow Ring",
		back = gear.Ogma.Parry, waist = "Flume Belt +1", legs = "Erilaz Leg Guards +2", feet = "Erilaz Greaves +2"
	}

	sets.engaged.MEVA =
	{
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm", neck = "Warder's Charm +1", ear1 = "Odnowa Earring +1", ear2 = "Eabani Earring",
		body = "Runeist Coat +3", hands = "Nyame Gauntlets", ring1 = "Moonlight Ring", ring2 = "Shadow Ring",
		back = gear.Ogma.Parry, waist = "Engraved Belt", legs = "Eri. Leg Guards +2", feet = "Erilaz Greaves +2"
	}

	sets.engaged.DD =
	{
		ammo = "Coiste Bodhar",
		head = "Nyame Helm", neck = "Combatant's Torque", ear1 = "Sherida Earring", ear2 = "Brutal Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Moonlight Ring", ring2 = "Niqmaddu Ring",
		back = gear.Ogma.Parry, waist = "Ioskeha Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
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