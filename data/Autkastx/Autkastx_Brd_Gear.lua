function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal')
    state.CastingMode:options('Normal','Resistant','AoE')
    state.IdleMode:options('Normal')
	state.Weapons:options('None', 'Aeneas', 'Naegling', 'DualWeapons', 'DualNaegling', 'DualTauret', 'DualAeolian')

	-- Adjust this if using the Terpander (new +song instrument)
	info.ExtraSongInstrument = 'Daurdabla'
	-- How many extra songs we can keep from Daurdabla/Terpander
	info.ExtraSongs = 2

	-- Auto Songs to sing
	info.AutoSongs = 'ja hmarch min min mad'
	-- How long to wait between auto singing
	info.AutoSongDelay = 600 -- 10:00 min

	info.CastSpeed = 0.2

	gear.Intarabus =
	{
		TP = { name = "Intarabus's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dbl.Atk."+10', 'Damage taken-5%' } },
		DEX_WSD = { name = "Intarabus's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', 'Weapon skill damage +10%' } },
	}

	gear.Linos =
	{
		TP = { name = "Linos", augments = { 'Accuracy+15', '"Store TP"+3', 'Quadruple Attack +3' } },
		WSD = { name="Linos", augments = { 'Accuracy+13 Attack+13', '"Store TP"+4', 'STR+8' } }
	}
	
	-- Set this to false if you don't want to use custom timers.
	state.UseCustomTimers = M(false, 'Use Custom Timers')
	
	-- Additional local binds
	send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind ^r gs c weapons None;gs c update')
	send_command('bind !q gs c weapons NukeWeapons;gs c update')
	send_command('bind ^q gs c weapons Swords;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Aeneas = { main = "Aeneas", sub = "Genmei Shield" }
	sets.weapons.Naegling = { main= "Naegling", sub = "Genmei Shield" }
	sets.weapons.DualWeapons = { main = "Aeneas", sub = "Gleti's Knife"}
	sets.weapons.DualNaegling = { main = "Naegling", sub = "Gleti's Knife"}
	sets.weapons.DualTauret = { main = "Tauret", sub = "Gleti's Knife" }
	sets.weapons.DualAeolian = { main = "Tauret", sub = "Malevolence" }

	sets.buff.Sublimation = { waist = "Embla Sash" }
	sets.buff.DTSublimation = { waist = "Embla Sash" }
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		main = "Kali", sub = "Genmei Shield",
		head = "Bunzi's Hat", neck = "Orunmila's Torque", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = "Inyanga Jubbah +2", hands = "Leyline Gloves", ring1 = "Kishar Ring", ring2 = "Medada's Ring",
		back = "Fi Follet Cape +1", waist = "Witful Belt", legs = "Kaykaus Tights +1", feet = "Volte Gaiters"
	}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Genmei Shield" })
	
	sets.precast.FC.BardSong =
	{
		main = "Kali", sub = "Genmei Shield", range = "Blurred Harp +1", ammo = empty,
		head = "Fili Calot +3", neck = "Orunmila's Torque", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = "Inyanga Jubbah +2", hands = "Leyline Gloves", ring1 = "Kishar Ring", ring2 = "Medada's Ring",
		back = "Fi Follet Cape +1", waist = "Embla Sash", legs = "Aya. Cosciales +2", feet = "Bihu Slippers +3"
	}

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong, {})
	sets.precast.FC.Lullaby = { range="Marsyas" }
	sets.precast.FC['Horde Lullaby'] = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby'].Resistant = {range="Blurred Harp +1"}
	sets.precast.FC['Horde Lullaby'].AoE = {range="Blurred Harp +1"}
	sets.precast.FC['Horde Lullaby II'] = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby II'].Resistant = {range="Blurred Harp +1"}
	sets.precast.FC['Horde Lullaby II'].AoE = {range="Blurred Harp +1"}
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla

	sets.precast.FC['Goblin Gavotte'] = set_combine(sets.precast.DaurdablaDummy, {})
	sets.precast.FC['Warding Round'] = set_combine(sets.precast.DaurdablaDummy, {})
	sets.precast.FC['Gold Capriccio'] = set_combine(sets.precast.DaurdablaDummy, {})
	sets.precast.FC['Puppet\'s Operetta'] = set_combine(sets.precast.DaurdablaDummy, {})

	-- Precast sets to enhance JAs

	sets.precast.JA.Nightingale = { feet = "Bihu Slippers +3" }
	sets.precast.JA.Troubadour = { body = "Bihu Jstcorps. +3" }
	sets.precast.JA['Soul Voice'] = { legs = "Bihu Cannions +3" }

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		range = gear.Linos.WSD,
		head = "Nyame Helm", neck = "Rep. Plat. Medal", ear1 = "Ishvara Earring", ear2 = "Moonshade Earring",
		body = "Bihu Jstcorps. +3", hands = "Nyame Gauntlets", ring1 = "Sroda Ring", ring2 = "Epaminondas's Ring",
		back = gear.Intarabus.DEX_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS,
	{
		range = "Terpander",
		head = "Pixie Hairpin +1", neck = "Baetyl Pendant",
		ring2 = "Archon Ring",
		waist = "Eschan Stone"
	})

	sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS,
	{
		neck = "Bard's Charm +2", ear2 = "Mache Earring +1",
		ring1 = "Metamor. Ring +1", ring2 = "Ilabrat Ring",
		waist = "Grunfeld Rope"
	})

	sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS['Mordant Rime'],
	{
		ear1 = "Mache Earring +1", ear2 = "Moonshade Earring",
		ring1 = "Petrov Ring",
	})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS['Mordant Rime'],
	{
		neck = "Fotia Gorget", ear2 = "Mache Earring +1",
		body = "Ayanmo Corazza +2", hands = "Bunzi's Gloves", ring1 = "Petrov Ring",
		waist = "Fotia Belt"
	})

	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Sanguine Blade'],
	{
		head = "Nyame Helm", ear1 = "Friomisi Earring",
		ring2 = "Ilabrat Ring"
	})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = sets.precast.FC

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = {}
	sets.midcast.Lullaby = { range = "Marsyas" }
	sets.midcast['Horde Lullaby'] = {range="Marsyas"}
	sets.midcast['Horde Lullaby'].Resistant = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby'].AoE = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby II'] = {range="Marsyas"}
	sets.midcast['Horde Lullaby II'].Resistant = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby II'].AoE = {range="Blurred Harp +1"}
	sets.midcast.Madrigal = { head = "Fili Calot +3", back = gear.Intarabus.TP, feet = "Fili Cothurnes +2" }
	sets.midcast.Paeon = { head = "Brioso Roundlet +1" }
	sets.midcast.March = { hands = "Fili Manchettes +2" }
	sets.midcast['Honor March'] = set_combine(sets.midcast.March, { range = "Marsyas"})
	sets.midcast.Minuet = { body = "Fili Hongreline +3" }
	sets.midcast.Minne = { legs = "Mousai Seraweels +1" }
	sets.midcast.Carol = { hands = "Mousai Gages +1" }
	sets.midcast["Sentinel's Scherzo"] = { feet = "Fili Cothurnes +2" }
	sets.midcast['Magic Finale'] = { range = "Blurred Harp +1" }
	sets.midcast.Mazurka = { range = "Marsyas" }
	sets.midcast.Etude = { head = "Mousai Turban +1" }
	sets.midcast.Prelude = { back = gear.Intarabus.TP }
	sets.midcast.Mambo = { feet = "Mousai Crackows +1" }
	sets.midcast.Threnody = { body = "Mousai Manteel +1" }

	-- Dummy songs
	sets.midcast['Goblin Gavotte'] = set_combine(sets.precast.DaurdablaDummy, {})
	sets.midcast['Warding Round'] = set_combine(sets.precast.DaurdablaDummy, {})
	sets.midcast['Gold Capriccio'] = set_combine(sets.precast.DaurdablaDummy, {})
	sets.midcast['Puppet\'s Operetta'] = set_combine(sets.precast.DaurdablaDummy, {})
	

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect =
	{
		main = "Kali", sub = "Genmei Shield", range = "Gjallarhorn",
		head = "Fili Calot +3", neck = "Mnbw. Whistle +1", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",	
		body = "Fili Hongreline +3", hands = "Fili Manchettes +2", ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = "Fi Follet Cape +1", waist = "Embla Sash", legs = "Inyanga Shalwar +2", feet = "Brioso Slippers +3"
	}

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = set_combine(sets.midcast.SongEffect,
	{
		sub = "Ammurapi Shield",
		ear1 = "Regal Earring", ear2 = "Fili Earring +1",
		ring1 = "Metamor. Ring +1", ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1", waist = "Acuity Belt +1", legs = "Bihu Cannions +3", feet = "Bihu Slippers +3"
	})
		
	-- Song-specific recast reduction
	sets.midcast.SongRecast = sets.midcast.FastRecast

	-- Cast spell with normal gear, except using Daurdabla instead
	sets.midcast.Daurdabla = { range = info.ExtraSongInstrument }

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
	sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, { range = info.ExtraSongInstrument })

	-- Other general spells and classes.
	sets.midcast.Cure =
	{
		main = "Daybreak", sub = "Ammurapi Shield", ammo = "Pemphredo Tathlum",
		head = "Kaykaus Mitra +1", neck = "Reti Pendant", ear1 = "Calamitous Earring", ear2 = "Magnetic Earring",
		body = "Kaykaus Bliaut +1", hands = "Kaykaus Cuffs +1", ring1 = "Metamor. Ring +1", ring2 = "Mephitas's Ring +1",
		back = "Aurist's Cape +1", waist = "Shinjutsu-no-Obi +1", legs = "Kaykaus Tights +1", feet = "Kaykaus Boots +1"
	}
	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
		
	sets.midcast['Enhancing Magic'] =
	{
		sub = "Ammurapi Shield", ammo = "Hasty Pinion +1",
		head = "Telchine Cap", neck = "Voltsurge Torque" , ear1 = "Andoaa Earring", ear2 = "Gifted Earring",
		body = "Telchine Chas.", hands = gear.telchine.hands.enhancing, ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Fi Follet Cape +1", waist = "Embla Sash", legs = "Telchine Braconi", feet = "Telchine Pigaches"
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
		
	sets.midcast['Elemental Magic'] =
	{
		main = "Daybreak", sub = "Ammurapi Shield", ammo = "Ghastly Tathlum +1",
		head = "C. Palug Crown", neck = "Sanctity Necklace", ear1 = "Friomisi Earring", ear2 = "Crematio Earring",
		body = "Chironic Doublet", hands = "Volte Gloves", ring1 = "Metamor. Ring +1", ring2 = "Medada's Ring",
		back = "Toro Cape", waist = "Sekhmet Corset", legs = "Gyve Trousers", feet = gear.chironic_nuke_feet
	}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure,
	{
		neck = "Debilis Medallion", hands = "Hieros Mittens", ring1 = "Haoma's Ring", ring2 = "Menelaus's Ring",
		back = "Oretan. Cape +1", waist = "Witful Belt", feet = "Vanya Clogs"
	})

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.idle =
	{
		main = "Daybreak", sub = "Genmei Shield", range = "Terpander",
		head = "Fili Calot +3", neck = "Loricate Torque +1", ear1 = "Etiolation Earring", ear2 = "Fili Earring +1",
		body = "Volte Doublet", hands = "Fili Manchettes +2", ring1 = "Shadow Ring", ring2 = "Defending Ring",
		back = "Solemnity Cape", waist = "Carrier's Sash", legs = "Inyanga Shalwar +2", feet = "Inyan. Crackows +2"
	}

	-- Resting sets
	sets.resting = sets.idle

	sets.Kiting = { feet = "Fili Cothurnes +2" }
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged =
	{
		range = gear.Linos.TP,
		head = "Bunzi's Hat", neck = "Bard's Charm +2", ear1 = "Crep. Earring", ear2 = "Telos Earring",
		body = "Ashera Harness", hands = "Bunzi's Gloves", ring1 = "Chirich Ring +1", ring2 = "Chirich Ring +1",
		back = gear.Intarabus.TP, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.engaged.DW =
	{
		range = gear.Linos.TP,
		head = "Bunzi's Hat", neck = "Bard's Charm +2", ear1 = "Eabani Earring", ear2 = "Telos Earring",
		body = "Ashera Harness", hands = "Bunzi's Gloves", ring1 = "Chirich Ring +1", ring2 = "Chirich Ring +1",
		back = gear.Intarabus.TP, waist = "Reiki Yotai", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 9)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 014')
end

state.Weapons:options('None','Naegling','Aeneas','DualWeapons','DualNaegling','DualTauret','DualAeolian')

autows_list = {['Naegling']='Savage Blade',['Aeneas']="Rudra's Storm",['DualWeapons']="Rudra's Storm",['DualNaegling']='Savage Blade',['DualTauret']='Evisceration',
     ['DualAeolian']='Aeolian Edge'}