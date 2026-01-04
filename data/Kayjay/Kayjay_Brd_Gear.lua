function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant', 'AoE')
    state.IdleMode:options('Normal')
	state.Weapons:options('None', 'Aeneas', 'Naegling', 'Trial', 'DualWeapons', 'DualNaegling', 'DualTauret', 'DualAeolian', 'DualTrial')

	gear.Intarabus =
	{
		Idle = { name = "Intarabus's Cape", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity-10', 'Damage taken-5%' } },
		FC = { name = "Intarabus's Cape", augments = { 'CHR+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'Mag. Acc.+10', '"Fast Cast"+10', 'Damage taken-5%' } }
	}

	-- Adjust this if using the Terpander (new +song instrument)
	info.ExtraSongInstrument = "Terpander"
	-- How many extra songs we can keep from Daurdabla/Terpander
	info.ExtraSongs = 1
	-- How long to wait between singing
	info.SongDelay = 15
	-- Auto Songs to sing
	info.AutoSongs = 'march min min'
	-- How long to wait between auto singing
	info.AutoSongDelay = 210 -- 3:30 min

	info.CastSpeed = 0.5

	-- Set this to false if you don't want to use custom timers.
	state.UseCustomTimers = M(false, 'Use Custom Timers')
	
	-- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !r gs c weapons None;gs c update')
	send_command('bind !q gs c weapons NukeWeapons;gs c update')
	send_command('bind ^q gs c weapons Swords;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Aeneas = { main = "Aeneas", sub = "Genmei Shield"}
	sets.weapons.Naegling = { main = "Naegling", sub = "Genmei Shield" }
	sets.weapons.Trial = { main = "Daybreak", sub = "Genmei Shield", range = "Gjallarhorn" }
	sets.weapons.DualWeapons = { main = "Aeneas", sub = "Blurred Knife +1" }
	sets.weapons.DualNaegling = { main = "Naegling", sub = "Blurred Knife +1" }
	sets.weapons.DualTauret = { main = "Tauret", sub = "Blurred Knife +1" }
	sets.weapons.DualAeolian = { main = "Tauret", sub = "Malevolence" }
	sets.weapons.DualTrial = { main = "Aeneas", sub = "Blurred Knife +1", range = "Gjallarhorn" }

    sets.buff.Sublimation = { waist = "Embla Sash" }
    sets.buff.DTSublimation = { waist = "Embla Sash" }
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		main = "Kali", sub = "Genmei Shield",
		head = "Fili Calot +1", neck = "Loricate Torque +1", ear1 = "Etiolation Earring", ear2 = "Loquac. Earring",
		body = "Inyanga Jubbah +2", hands = "Gende. Gages +1", ring1 = "Prolix Ring", ring2 = "Murky Ring",
		back = gear.Intarabus.FC, waist = "Flume Belt +1", legs = "Aya. Cosciales +2", feet = "Regal Pumps +1"
	}
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Ammurapi Shield" })

	sets.precast.FC.BardSong =
	{
		main = "Carnwenhan", sub = "Genmei Shield",
		head = "Fili Calot +1", neck = "Loricate Torque +1", ear1 = "Enchanter's Earring +1", ear2 = "Loquac. Earring",
		body = "Inyanga Jubbah +2", hands = "Gende. Gages +1", ring1 = "Kishar Ring", ring2 = "Rahab Ring",
		back = gear.Intarabus.FC, waist = "Embla Sash", legs = "Kaykaus Tights +1", feet = "Bihu Slippers +1"
	}
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong, { range = "Marsyas" })

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, { range = info.ExtraSongInstrument })
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla

	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = { feet = "Bihu Slippers +1" }
	sets.precast.JA.Troubadour = { body = "Bihu Jstcorps +1" }
	sets.precast.JA['Soul Voice'] = { legs = "Bihu Cannions +1" }

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		range = "Linos",
		head = "Nyame Helm", neck = "Republican Platinum Medal", ear1 = "Regal Earring", ear2 = "Moonshade Earring",
		body = "Bihu Justaucorps +3", hands = "Nyame Gauntlets", ring1 = "Shukuyu Ring", ring2 = "Rufescent Ring",
		back = gear.Intarabus.Idle, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast =
	{
		range = "Terpander",
		head = "Bunzi's Hat", neck = "Orunmila's Torque", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = "Inyanga Jubbah +2", hands = "Leyline Gloves", ring1 = "Kishar Ring", ring2 = "Rahab Ring",
		back = gear.Intarabus.FC, waist = "Embla Sash", legs = "Kaykaus Tights +1", feet = "Volte Gaiters"
	}

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = { legs = "Fili Rhingrave +1" }
	sets.midcast.Lullaby = { range = "Marsyas" }
	sets.midcast['Horde Lullaby'] = { range = "Marsyas" }
	sets.midcast['Horde Lullaby II'] = { range = "Marsyas" }
	sets.midcast.Madrigal = { head = "Fili Calot +1", feet = "Fili Cothurnes +1" }
	sets.midcast.Paeon = { head = "Brioso Roundlet +3" }
	sets.midcast.March = { hands = "Fili Manchettes +1" }
	sets.midcast['Honor March'] = set_combine(sets.midcast.March, { range = "Marsyas" })
	sets.midcast.Minuet = { body = "Fili Hongreline +1" }
	sets.midcast.Minne = { legs = "Mousai Seraweels +1" }
	sets.midcast.Carol = { hands = "Mousai Gages +1" }
	sets.midcast["Sentinel's Scherzo"] = { feet = "Fili Cothurnes +1" }
	sets.midcast['Magic Finale'] = { range = "Blurred Harp +1" }
	sets.midcast.Mazurka = { range = "Marsyas" }
	sets.midcast.Etude = { head = "Mousai Turban +1" }
	sets.midcast.Prelude = { feet = "Fili Cothurnes +1" }
	sets.midcast.Mamob = { feet = "Mousai Crackows +1" }

	-- Dummy songs
	sets.midcast['Goblin Gavotte'] = set_combine(sets.precast.DaurdablaDummy, {})
	sets.midcast['Warding Round'] = set_combine(sets.precast.DaurdablaDummy, {})
	sets.midcast['Gold Capriccio'] = set_combine(sets.precast.DaurdablaDummy, {})
	sets.midcast['Puppet\'s Operetta'] = set_combine(sets.precast.DaurdablaDummy, {})
	

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect =
	{
		main = "Kali", sub = "Genmei Shield", range = "Gjallarhorn",
		head = "Bunzi's Hat", neck = "Mnbw. Whistle +1", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = "Fili Hongreline +1", hands = "Bunzi's Gloves", ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = gear.Intarabus.FC, waist = "Embla Sash", legs = "Inyanga Shalwar +2", feet = "Brioso Slippers +3"
	}

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff =
	{
		main = "Kali", sub = "Ammurapi Shield", range = "Terpander",
		head = "Brioso Roundlet +3", neck = "Mnbw. Whistle +1", ear1 = "Enchntr. Earring +1", ear2 = "Regal Earring",
		body = "Brioso Justaucorps +3", hands = "Brioso Cuffs +3", ring1 = "Metamorph Ring +1", ring2 = "Stikini Ring +1",
		back = gear.Intarabus.FC, waist = "Obstinate Sash", legs = "Inyanga Shalwar +2", feet = "Brioso Slippers +3"
	}

	-- Cast spell with normal gear, except using Daurdabla instead
	sets.midcast.Daurdabla = { range = info.ExtraSongInstrument }
	sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, { range = info.ExtraSongInstrument })

	sets.precast.FC['Goblin Gavotte'] = set_combine(sets.precast.DaurdablaDummy, {})
	sets.precast.FC['Warding Round'] = set_combine(sets.precast.DaurdablaDummy, {})
	sets.precast.FC['Gold Capriccio'] = set_combine(sets.precast.DaurdablaDummy, {})
	sets.precast.FC['Puppet\'s Operetta'] = set_combine(sets.precast.DaurdablaDummy, {})

	-- Other general spells and classes.
	sets.midcast.Cure =
	{
		main = "Daybreak", sub = "Genmei Shield", range = "Terpander",
		head = "Kaykaus Mitra +1", neck = "Incanter's Torque", ear1 = "Meili Earring", ear2 = "Regal Earring",
		body = "Kaykaus Bliaut +1", hands = "Kaykaus Cuffs +1", ring1 = "Metamor. Ring +1", ring2 = "Menelaus's Ring",
		back = "Aurist's Cape +1", waist = "Luminary Sash", legs = "Kaykaus Tights +1", feet = "Kaykaus Boots +1"
	}

	sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast['Enhancing Magic'] =
	{
		head = gear.telchine.head.enhancing, neck = "Loricate Torque +1", ear1 = "Eabani Earring", ear2 = "Sanare Earring",
		body = gear.telchine.body.enhancing, hands = gear.telchine.hands.enhancing, ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = gear.Intarabus.FC, waist = "Embla Sash", legs = gear.telchine.legs.enhancing, feet = gear.telchine.feet.enhancing
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], { legs = "Shedir Seraweels" })
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], { back = "Grapevine Cape", waist = "Gishdubar Sash" })
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],
	{
		head = "Umuthi Hat", neck = "Incanter's Toruqe", ear1 = "Mimir Earring", ear2 = "Andoaa Earring",
		hands = "Inyanga Dastanas +2", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Fi Follet Cape +1", legs = "Shedir Seraweels", feet = "Kaykaus Boots +1"
	})

	sets.midcast.Cursna =
	{
		head = "Vanya Hood", neck = "Debilis Medallion", ear1 = "Meili Earring", ear2 = "Etiolation Earring",
		body = "Inyanga Jubbah +2", hands = "Inyanga Dastanas +2", ring1 = "Haoma's Ring", ring2 = "Menelaus's Ring",
		back = "Oretania's Cape +1", waist = "Witful Belt", legs = "Kaykaus Tights +1", feet = "Vanya Clogs"
	}

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
	
	sets.idle =
	{
		main = "Daybreak", sub = "Genmei Shield", range = "Terpander",
		head = "Inyanga Tiara +2", neck = "Loricate Torque +1", ear1 = "Eabani Earring", ear2 = "Ethereal Earring",
		body = "Inyanga Jubbah +2", hands = "Inyan. Dastanas +2", ring1 = "Inyanga Ring", ring2 = "Stikini Ring +1",
		back = gear.Intarabus.Idle, waist = "Carrier's Sash", legs = "Inyanga Shalwar +2", feet = "Inyan. Crackows +2"
	}

	sets.Kiting = { ring2 = "Shneddick Ring" }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged =
	{
		range = "Linos",
		head = "Aya. Zucchetto +2", neck = "Bard's Charm +2", ear1 = "Suppanomimi", ear2 = "Brutal Earring",
		body = "Ayanmo Corazza +2", hands = "Aya. Manopolas +2", ring1 = "Chirich Ring +1", ring2 = "Chirich Ring +1",
		back = gear.Intarabus.Idle, waist = "Reiki Yotai", legs = "Aya. Cosciales +2", feet = "Aya. Gambieras +2"
	}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(10, 10)
end

state.Weapons:options('None','Naegling','Aeneas','DualWeapons','DualNaegling','DualTauret','DualAeolian')

autows_list = {['Naegling']='Savage Blade',['Aeneas']="Rudra's Storm",['DualWeapons']="Rudra's Storm",['DualNaegling']='Savage Blade',['DualTauret']='Evisceration',
     ['DualAeolian']='Aeolian Edge'}