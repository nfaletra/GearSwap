function user_job_setup()

	state.OffenseMode:options('Normal', 'Tank')
	state.HybridMode:options('Normal', 'DT')
	state.WeaponskillMode:options('Normal', 'DT')
	state.CastingMode:options('SIRD','Normal')
	state.PhysicalDefenseMode:options('PDT_HP','PDT')
	state.MagicalDefenseMode:options('MDT_HP','MDT')
	state.ResistDefenseMode:options('MEVA','MEVA_HP')
	state.IdleMode:options('Normal', 'Evasion')
	state.Weapons:options('Aettir', 'Evasion', 'Lycurgos', 'Naegling')
	
	state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP'}

	gear.enmity_jse_back = {name="Ogma's cape",augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}}
	gear.stp_jse_back = {name="Ogma's cape",augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	gear.da_jse_back = {name="Ogma's cape",augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^` gs c RuneElement')
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
		head = "Halitus Helm", neck = "Unmoving Collar +1", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Emet Harness +1", hands = "Kurys Gloves", ring1 = "Eihwaz Ring", ring2 = "Supershear Ring",
		back = "Ogma's Cape", waist = "Trance Belt", legs = "Eri. Leg Guards +1", feet = "Erilaz Greaves +1"
	}

	sets.Enmity.SIRD =
	{
		ammo = "Staunch Tathlum",
		head = "Agwu's Cap", neck = "Loricate Torque +1", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = gear.taeon.body.SIRD, hands = "Regal Gauntlets", ring1 = "Defending Ring", ring2 = "Gelatinous Ring +1",
		back = "Ogma's Cape", waist = "Audumbla Sash", legs = "Carmine Cuisses +1", feet = gear.taeon.feet.SIRD
	}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Item sets.

	-- Precast sets to enhance JAs
	sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity, { body = "Futhark Coat +1" })
	sets.precast.JA['Vallation'] = set_combine(sets.Enmity, { body = "Runeist's Coat +3", legs = "Futhark Trousers +3" })
	sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
	sets.precast.JA['Swordplay'] = set_combine(sets.Enmity, { hands = "Futhark Mitons +3" })
	sets.precast.JA['Gambit'] = set_combine(sets.Enmity, { hands = "Runeist's Mitons +3" })
	sets.precast.JA['Rayke'] = set_combine(sets.Enmity, { feet = "Futhark Boots +3" })
	sets.precast.JA['Battuta'] = set_combine(sets.Enmity, { head = "Futhark Bandeau +3" })
	sets.precast.JA['Liement'] = set_combine(sets.Enmity, { body = "Futhark Coat +3" })
	sets.precast.JA['Embolden'] = set_combine(sets.Enmity, { back = "Evasionist's Cape" })
	sets.precast.JA['One For All'] = set_combine(sets.Enmity, { ring2 = "Gelatinous Ring +1", feet = "Ahosi Leggings" })
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Last Resort'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

	sets.precast.JA['Lunge'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Agwu's Cap", neck = "Combatant's Torque", ear1 = "Tuisto Earring", ear2 = "Friomisi Earring",
		body = "Agwu's Robe", hands = "Agwu's Gages", ring1 = "Etana Ring", ring2 = "Metamor. Ring +1",
		back = "Ogma's Cape", waist = "Eschan Stone", legs = "Agwu's Slops", feet = "Agwu's Pigachies"
	}
	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

	-- Gear for specific elemental nukes.
	sets.element.Dark = { head = "Pixie Hairpin +1", ring1 = "Archon Ring" }

	-- Pulse sets, different stats for different rune modes, stat aligned.
	sets.precast.JA['Vivacious Pulse'] =
	{
		ammo = "Staunch Tathlum",
		head = "Erilaz Galea +1", neck = "Futhark Torque +2", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Supershear Ring", ring2 = "Eihwaz Ring",
		back = "Ogma's Cape", waist = "Engraved Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
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
		ammo="Yamarang",
		head="Carmine Mask +1",neck="Unmoving Collar +1",ear1="Enchntr. Earring +1",ear2="Handler's Earring +1",
		body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
		back="Moonlight Cape",waist="Chaac Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet
	}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}
	sets.precast.JA['Violent Flourish'] = {}

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		ammo = "Sapience Orb",
		head = "Rune. Bandeau +3", neck = "Unmoving Collar +1", ear1 = "Loquac. Earring", ear2 = "Enchantr. Earring +1",
		body = gear.body.adhemar.d, hands = "Leyline Gloves", ring1 = "Kishar Ring", ring2 = "Gelatinous Ring +1",
		back = "Ogma's Cape", waist = "Engraved Belt", legs = "Agwu's Slops", feet = "Carmine Greaves +1"
	}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,
	{
		ammo = "Impatiens",
		ear2 = "Etiolation Earring",
		waist = "Siegel Sash", legs = "Futhark Trousers +3"
	})
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck = "Magoraga Beads" })
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	sets.precast.WS =
	{
		ammo = "Knobkierrie",
		head = "Nyame Helm", neck = "Futhark Torque +2", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Niqmaddu Ring",
		back = gear.da_jse_back, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast['Dimidiation'] =
	{
		ammo = "Knobkierrie",
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Odr Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Niqmaddu Ring",
		back = "Ogma's Cape", waist = "Sailfi Belt +1", legs = "Lustratio Subligar +1", feet = "Lustratio Leggings +1"
	}
	sets.precast['Dimidiation'].DT = set_combine(sets.precast['Dimidiation'],
	{
		legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	})

	sets.precast.WS['Resolution'] =
	{
		ammo = "Coiste Bodhar",
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = gear.adhemar.body.b, hands = gear.adhemar.hands.b, ring1 = "Epona's Ring", ring2 = "Niqmaddu Ring",
		back = "Ogma's Cape", waist = "Fotia Belt", legs = "Lustratio Subligar +1", feet = "Lustratio Leggings +1"
	}
	sets.precast.WS['Resolution'].DT = set_combine(sets.precast.WS['Resolution'],
	{
		head = "Nyame Helm",
		body = "Nyame Mail", hands = "Nyame Gauntlets",
		legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	})

	sets.precast.WS['Ground Strike'] =
	{
		ammo = "Knobkierrie",
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Niqmaddu Ring",
		back = "Ogma's Cape", waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Shockwave'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Agwu's Cap", neck = "Sanctity Necklace", ear1 = "Digni. Earring", ear2 = "Crep. Earring",
		body = "Agwu's Robe", hands = "Agwu's Gages", ring1 = "Etana Ring", ring2 = "Metamor. Ring +1",
		back = "Ogma's Cape", waist = "Eschan Stone", legs = "Agwu's Slops", feet = "Agwu's Pigaches"
	}

	sets.precast.WS['Upheaval'] =
	{
		ammo = "Knobkierrie",
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Niqmaddu Ring",
		back = "Ogma's Cape", waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Steel Cyclone'] =
	{
		ammo = "Knobkierrie",
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Niqmaddu Ring",
		back = "Ogma's Cape", waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Fell Cleave'] =
	{
		ammo = "Knobkierrie",
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Niqmaddu Ring",
		back = "Ogma's Cape", waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Armor Break'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Agwu's Cap", neck = "Sanctity Necklace", ear1 = "Digni. Earring", ear2 = "Crep. Earring",
		body = "Agwu's Robe", hands = "Agwu's Gages", ring1 = "Etana Ring", ring2 = "Metamor. Ring +1",
		back = "Ogma's Cape", waist = "Eschan Stone", legs = "Agwu's Slops", feet = "Agwu's Pigaches"
	}

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	sets.midcast.FastRecast =
	{
		ammo = "Staunch Tathlum",
		head = "Runeist's Cap +3", neck = "Futhark Torque +2", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Defending Ring", ring2 = "Kishar Ring",
		back = "Ogma's Cape", waist = "Engraved Belt", legs = "Agwu's Slops", feet = "Nyame Sollerets"
	}

	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast,
	{
		ammo = "Staunch Tathlum",
		head = "Erilaz Galea +1", neck = "Incanter's Torque", ear1 = "Andoaa Earring", ear2 = "Odnowa Earring +1"
		body = "Manasa Chasuble", hands = "Runeist's Mitons +3", ring1 = "Moonbeam Ring", ring2 = "Stikini Ring +1",
		back = "Ogma's Cape", waist = "Flume Belt +1", legs = "Futhark Trousers +3", feet = "Erilaz Greaves +1"
	})

	sets.midcast['Enhancing Magic'].Duration = set_combine(sets.midcast['Enhancing Magic'], { hands = "Regal Gauntlets" })

	sets.midcast['Enhancing Magic'].SIRD = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'].Duration,
	{
		head = "Carmine Mask +1",
		body = "Nyame Mail",
		back = "Moonlight Cape", waist = "Fume Belt +1", legs = "Carmine Cuisses +1",
	})

	sets.midcast['Temper'] = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast['Crusade'] = set_combine(sets.midcast['Enhancing Magic'],
	{
		neck = "Futhark Torque +2", ear1 = "Etiolation Earring",
		body = "Nyame Mail", hands = "Regal Gauntlets", ring2 = "Defending Ring",
		feet = "Nyame Sollerets"
	})

	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'],
	{
		head = "Futhark Bandeau +3",
		body = "Taeon Tabard", hands = "Taeon Gloves",
		legs = "Taeon Tights", feet = "Taeon Boots"
	})

	sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], { head="Rune. Bandeau +3", neck = "Sacro Gorget" }) 
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {}) 
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], { ear2="Earthcry Earring", waist = "Siegel Sash" })
	sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Foil = set_combine(sets.Enmity, {})
	sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Jettatura = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})

	sets.midcast.Cure =
	{
		ammo = "Staunch Tathlum +1",
		head = "Carmine Mask +1", neck = "Sacro Gorget",ear1="Mendi. Earring",ear2="Roundel Earring",
		body="Vrikodara Jupon",hands="Buremte Gloves",ring1="Lebeche Ring",ring2="Janniston Ring",
		back="Tempered Cape +1",waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Skaoi Boots"
	}

	sets.midcast['Wild Carrot'] = set_combine(sets.midcast.Cure, {})

	sets.Self_Healing = {hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	sets.Phalanx_Received = {main="Deacon Sword",hands=gear.herculean_phalanx_hands,feet=gear.herculean_nuke_feet}

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------
	sets.resting = {}

	sets.idle =
	{
		ammo = "Staunch Tathlum",
		head = "Nyame Helm", neck = "Futhark Torque +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Runeist's Coat +3", hands = "Nyame Gauntlets", ring1 = "Moonbeam Ring", ring2 = "Gelatinous Ring +1",
		back = "Ogma's Cape", waist = "Engraved Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.idle.Evasion =
	{
		ammo = "Yamarang",
		head = "Nyame Helm", neck = "Bathy Choker +1", ear1 = "Eabani Earring", ear2 = "Infused Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Ilabrat Ring", ring2 = "Vengeful Ring",
		back = "Ogma's Cape", waist = "Kasiri Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.Kiting = { legs = "Carmine Cuisses +1" }

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
	sets.MP = {ear2="Ethereal Earring",body="Erilaz Surcoat +1",waist="Flume Belt +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Weapons sets
	sets.weapons.Aettir = { main = "Aettir", sub = "Utu Grip" }
	sets.weapons.Evasion = { main = "Soulcleaver", sub = "Kypayopl" }
	sets.weapons.Lycurgos = {main = "Lycurgos", sub = "Utu Grip" }
	sets.weapons.Naegling = { main = "Naegling", sub = "Malignance Sword" }
	
	-- Defense Sets
	
	sets.defense.PDT =
	{
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
		back="Shadow Mantle",waist="Flume Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"
	}
	sets.defense.PDT_HP =
	{
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Unmoving Collar +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
		body="Runeist's Coat +3",hands="Nyame Gauntlets",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"
	}
	sets.defense.MDT =
	{
		ammo="Yamarang",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Archon Ring",ring2="Shadow Ring",
		back="Moonlight Cape",waist="Engraved Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"
	}
	sets.defense.MDT_HP =
	{
		ammo="Yamarang",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
		back="Moonlight Cape",waist="Engraved Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"
	}
	sets.defense.MEVA =
	{
		ammo="Yamarang",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Purity Ring",ring2="Vengeful Ring",
		back=gear.enmity_jse_back,waist="Engraved Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"
	}
	sets.defense.MEVA_HP =
	{
		ammo="Yamarang",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
		back="Moonlight Cape",waist="Engraved Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"
	}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear2="Brutal Earring"}
	sets.AccMaxTP = {ear2="Telos Earring"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------
	sets.engaged =
	{
		ammo = "Coiste Bodhar",
		head = "Dampening Tam", neck = "Anu Torque", ear1 = "Sherida Earring", ear2 = "Telos Earring",
		body = gear.adhemar.body.b, hands = gear.adhemar.hands.a, ring1 = "Epona's Ring", ring2 = "Niqmaddu Ring",
		back = "Ogma's Cape", waist = "Windbuffet Belt +1", legs = "Samnuha Tights", feet = gear.herculean_ta_feet
	}
	sets.engaged.DT = set_combine(sets.engaged,
	{
		neck = "Futhark Torque +2",
		body = "Nyame Mail", hands = gear.adhemar.hands.a, ring1 = "Defending Ring", ring2 = "Niqmaddu Ring",
		back = "Ogma's Cape", waist = "Engraved Belt", legs = "Samnuha Tights", feet = "Nyame Sollerets"
	})

	sets.engaged.Tank =
	{
		ammo = "Staunch Tathlum",
		head = "Nyame Helm", neck = "Futhark Torque +2", ear1 = "Eabani Earring", ear2 = "Odnowa Earring +1",
		body = "Runeist's Coat +3", hands = "Nyame Gauntlets", ring1 = "Eihwaz Ring", ring2 = "Gelatinous Ring +1",
		back = "Ogma's Cape", waist = "Engraved Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.engaged.Tank.DT = set_combine(sets.engaged.Tank,
	{
		ammo = "Yamarang",
		body = "Nyame Mail", hands = "Turms Mittens +1", ring1 = "Defending Ring", ring2 = "Gelatinous Ring +1",
		back = "Ogma's Cape", waist = "Engraved Belt", legs = "Nyame Flanchard", feet = "Turms Leggings +1"
	})

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = { head = "Frenzy Sallet" }
	sets.buff.Battuta = { hands = "Turms Mittens +1" }
	sets.buff.Embolden = { back = "Evasionist's Cape" }
	sets.buff.Pflug = { feet = "Runeist's Bottes +3" }
	sets.buff.Embolden = { back = "Evasionist's Cape" }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(1, 12)
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[980] < spell_latency and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				else
					return false
				end
			end
		end
	end
	return false
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 009')
end