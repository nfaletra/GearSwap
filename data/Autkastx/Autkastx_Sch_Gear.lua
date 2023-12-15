-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal','Resistant','Proc','OccultAcumen','9k')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.HybridMode:options('Normal','Dual Wield')
	state.Weapons:options('None','Musa','Khatvanga','Maxentius','Daybreak','DualMaxentius','DualDaybreak')

	state.AutoCureMode:options('Off', 'Party', 'Ally')
	state.StatusCureMode:options('Off', 'Party', 'Ally')

	gear.Lughs =
	{
		Nuke = { name = "Lugh's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', 'Phys. dmg. taken-10%' } }
	}

		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c scholar power')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
	send_command('bind !q gs c weapons default;gs c reset CastingMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace gs c scholar speed')
	send_command('bind @backspace gs c scholar aoe')
	send_command('bind ^= input /ja "Dark Arts" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise III" <me>')

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

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = { legs = "Peda. Pants +2" }
	sets.precast.JA['Enlightenment'] = {} --body="Peda. Gown +1"

    -- Fast cast sets for spells

	sets.precast.FC =
	{
		main = "Mpaca's Staff", sub = "Khonsu", ammo = "Impatiens",
		head = "Merlinic Hood", neck = "Orunmila's Torque", ear1 = "Malignance Earring", ear2 = "Loquac. Earring",
		body = "Merlinic Jubbah", hands = "Gende. Gages +1", ring1 = "Kishar Ring", ring2 = "Medada's Ring",
		back = "Fi Follet Cape +1", waist = "Witful Belt", legs = "Agwu's Slops", feet = "Peda. Loafers +3"
	}

	sets.precast.FC.Arts = { head = "Peda. M.Board +3", feet = "Acad. Loafers +1" }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], { head = empty, body = "Crepuscular Cloak" })
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Genmei Shield"})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		ammo = "Oshasha's Treatise",
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Crep. Earring", ear2 = "Telos Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Freke Ring", ring2 = "Archon Ring",
		waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS,
	{
		neck = "Repub. Plat. Medal", ear1 = "Regal Earring", ear2 = "Moonshade Earring",
		ring1 = "Rufescent Ring", ring2 = "Metamor. Ring +1",
		back = "Aurist's Cape +1", waist = "Luminary Sash",
	})

	sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS,
	{
		neck = "Baetyl Pendant", ear1 = "Regal Earring", ear2 = "Friomisi Earring",
		hadns = "Jhakri Cuffs +2", ring2 = "Metamor. Ring +1",
		waist = "Eschan Stone", legs = "Merlinic Shalwar"
	})
	sets.precast.WS['Shining Strike'] = sets.precast.WS['Flash Nova']

	sets.precast.WS['Myrkr'] =
	{
		ammo="Staunch Tathlum +1",
		head = "Amarlic Coif +1", neck = "Dualism Collar +1", ear1 = "Evans Earring", ear2 = "Moonshade Earring",
		body = "Acad. Gown +1", hands = "Peda. Bracers +3", ring1 = "Mephitas's Ring +1", ring2 = "Mephitas's Ring",
		back = "Aurist's Cape +1", waist = "Shinjintsu-no-Obi +1", legs = "Agwu's Slops", feet = gear.amalric.feet.a
	}

	-- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
	sets.MagicBurst =
	{
		main = "Bunzi's Rod", sub = "Ammurapi Shield", ammo = "Ghastly Tathlum +1",
		head = "Agwu's Cap", neck = "Argute Stole +2", ear1 = "Regal Earring", ear2 = "Malignance Earring",
		body = "Agwu's Robe", hands = "Amalric Gages +1", ring1 = "Freke Ring", ring2 = "Mujin Band",
		back = "Aurist's Cape +1", waist = "Sacro Cord", legs = "Agwu's Slops", feet = "Agwu's Pigaches"
	}

	sets.midcast.FastRecast =
	{
		ammo = "Hasty Pinion +1",
		head = "Merlinic Hood", neck = "Orunmila's Torque", ear1 = "Malignance Earring", ear2 = "Loquac. Earring",
		body = "Zendik Robe", hands = "Academic's Bracers +1", ring1 = "Kishar Ring", ring2 = "Rahab Ring",
		back = "Fi Follet Cape +1", waist = "Witful Belt", legs = "Kaykaus Tights +1", feet = "Pedagogy Loafers +3"
	}

	sets.midcast.Cure =
	{
		main = "Raetic Rod +1", sub = "Genmei Shield", ammo = "Hasty Pinion +1",
		head = "Kaykaus Mitra +1", neck = "Incanter's Torque", ear1 = "Malignance Earring", ear2 = "Meili Earring",
		body = "Kaykaus Bliaut +1", hands = "Pedagogy Bracers +3", ring1 = "Menelaus's Ring", ring2 = "Lebeche Ring",
		back = "Fi Follet Cape +1", waist = "Luminary Sash", legs = "Kaykaus Tights +1", feet = "Kaykaus Boots +1"
	}

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure,
	{
		back = "Twilight Cape", waist = "Hachirin-no-Obi"
	})
	sets.midcast.LightDayCure = sets.midcast.LightWeatherCure

	sets.midcast.Curaga = sets.midcast.Cure

	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
	
	sets.midcast.Cursna = {main=gear.grioavolr_fc_staff,sub="Clemency Grip",ammo="Hasty Pinion +1",
		head="Amalric Coif +1",neck="Debilis Medallion",ear1="Meili Earring",ear2="Malignance Earring",
		body="Zendik Robe",hands="Hieros Mittens",ring1="Haoma's Ring",ring2="Menelaus's Ring",
		back="Oretan. Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Vanya Clogs"}
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Enhancing Magic'] =
	{
		main = "Gada", sub = "Ammurapi Shield", ammo = "Savant's Treatise",
		head = "Befouled Crown", neck = "Incantor's Torque", ear1 = "Mimir Earring", ear2 = "Andoaa Earring",
		body = "Telchine Chas.", hands = "Pedagogy Bracers +3", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Fi Follet Cape +1", waist = "Olympus Sash", legs = "Academic's Pants +1", feet = "Kaykaus Boots +1"
	}

	sets.midcast['Enhancing Magic'].Duration =
	{
		main = "Musa", sub = "Umbra Strap", ammo = "Staunch Tathlum +1",
		head = "Telchine Cap", neck = "Twilight Torque", ear1 = "Calamitous Earring", ear2 = "Etiolation Earring",
		body = "Pedagogy Gown +3", hands = gear.telchine.hands.enhancing, ring1 = "Mephitas's Ring +1", ring2 = "Defending Ring",
		back = "Fi Follet Cape +1", waist = "Embla Sash", legs = "Telchine Braconi", feet = "Telchine Pigaches"
	}

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'].Duration,
	{
		head = "Arbatel Bonnet +2",
		back = "Bookworm's Cape",
	})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'].Duration, { head = "Amalric Coif +1" })
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'].Duration,
	{
		main = "Vadose Rod",
		head = "Amalric Coif +1",
		hands = "Regal Cuffs",
		waist = "Emphatikos Rope", legs = "Shedir Seraweels"
	})
	
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'].Duration, { legs = "Shedir Seraweels" })

	sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'].Duration, { feet = "Peda. Loafers +3" })

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'].Duration, { ring2 = "Sheltered Ring" })
	sets.midcast.Protectra = sets.midcast.Protect

	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'].Duration, { ring2 = "Sheltered Ring" })
	sets.midcast.Shellra = sets.midcast.Shell


	-- Custom spell classes
	sets.midcast['Enfeebling Magic'] =
	{
		main = "Bunzi's Rod", sub = "Ammurapi Shield", ammo = "Pemphredo Tathlum",
		head = "Agwu's Cap", neck = "Erra Pendant", ear1 = "Malignance Earring", ear2 = "Regal Earring",
		body = "Agwu's Robe", hands = "Peda. Bracers +3", ring1 = "Kishar Ring", ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1", waist = "Obstin. Sash", legs = "Arbatel Pants +2", feet = "Agwu's Pigaches"
	}

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], { legs = "Agwu's Slops" })
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = sets.midcast['Enfeebling Magic']
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = sets.midcast['Enfeebling Magic']
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Amalric Coif +1",neck="Incanter's Torque",ear1="Regal Earring",ear2="Malignance Earring",
        body="Chironic Doublet",hands="Acad. Bracers +1",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.merlinic_aspir_feet}

	sets.midcast.Drain =
	{
		main = "Rubicundity", sub = "Ammurapi Shield", ammo = "Pemphredo Tathlum",
		head = "Pixie Hairpin +1", neck = "Erra Pendant", ear1 = "Regal Earring", ear2 = "Malignance Earring",
		body = "Merlinic Jubbah", hands = "Agwu's Gages", ring1 = "Evanescence Ring", ring2 = "Archon Ring",
		back = "Bookworm's Cape", waist = "Fucho-no-obi", legs = "Peda. Pants +2", feet = "Agwu's Pigaches"
	}
	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Stun =
		{
			main = "Musa", sub = "Khonsu", ammo = "Pemphredo Tathlum",
			head = "Acad. Mortar. +2", neck = "Argute Stole +2", ear1 = "Regal Earring", ear2 = "Malignance Earring",
			body = "Acad. Gown +1", hands = "Acad. Bracers +1", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
			back = gear.Lughs.Nuke, waist = "Witful Belt", legs = "Acad. Pants +1", feet = "Acad. Loafers +1"
		}

	-- Elemental Magic sets are default for handling low-tier nukes.
	sets.midcast['Elemental Magic'] =
	{
		main = "Bunzi's Rod", sub = "Ammurapi Shield", ammo = "Ghastly Tathlum +1",
		head = "Agwu's Cap", neck = "Argute Stole +2", ear1 = "Regal Earring", ear2 = "Malignance Earring",
		body = "Agwu's Robe", hands = "Agwu's Gages", ring1 = "Freke Ring", ring2 = "Metamor. Ring +1",
		back = gear.Lughs.Nuke, waist = "Sacro Cord", legs = "Agwu's Slops", feet = "Agwu's Pigaches"
	}

	sets.midcast['Elemental Magic'].Proc =
	{
		main = empty, sub = empty, ammo = "Impatiens",
		head = "Vanya Hood", neck = "Voltsurge Torque", ear1 = "Enchntr. Earring +1", ear2 = "Malignance Earring",
		body = "Zendik Robe", hands = "Gende. Gages +1", ring1 = "Kishar Ring", ring2 = "Prolix Ring",
		back = "Swith Cape +1", waist = "Witful Belt", legs = "Psycloth Lappas", feet = "Regal Pumps +1"
	}

	sets.midcast['Elemental Magic'].OccultAcumen = set_combine(sets.midcast['Elemental Magic'], {})

	sets.midcast.Kaustra = set_combine(sets.midcast['Elemental Magic'],
	 {
		head = "Pixie Hairpin",
		ring2 = "Archon Ring",
	})

	sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'],
	{
		hands = "Amalric Gages +1",ring2 = "Mallquis Ring",
		waist = "Acuity Belt +1", feet = gear.amalric.feet.a
	})

	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'],
	{
		main = "Daybreak", ammo = "Pemphredo Tathlum",
		head = empty,
		body = "Crepuscular Cloak", hands = "Acad. Bracers +1", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1", waist = "Acuity Belt +1", legs = "Arbatel Pants +2", feet = "Arbatel Loafers +2"
	})

	sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, { head = empty, body = "Crepuscular Cloak" })

	-- Sets to return to when not performing an action.
	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle =
	{
		main = "Mpaca's Staff", sub = "Khonsu", ammo = "Homiliary",
		head = "Nyame Helm", neck = "Warder's Charm +1", ear1 = "Lugalbanda Earring", ear2 = "Etiolation Earring",
		body = "Arbatel Gown +2", hands = "Nyame Gauntlets", ring1 = "Stikini Ring +1", ring2 = "Defending Ring",
		back = "Solemnity Cape", waist = "Carrier's Sash", legs = "Agwu's Slops", feet = "Nyame Sollerets"
	}

	-- Resting sets
	sets.resting = sets.idle

	sets.Kiting = { ring1 = "Shneddick Ring" }
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged =
	{
		ammo = "Amar Cluster",
		head = "Blistering Sallet +1", neck = "Combatant's Torque", ear1 = "Crep. Earring", ear2 = "Balder Earring +1",
		body = "Nyame Mail", hands = "Gazu Bracelets +1", ring1 = "Chirich Ring +1", ring2 = "Chirich Ring +1",
		back = "Aurist's Cape +1", waist = "Windbuffet Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.engaged['Dual Wield'] = set_combine(sets.engaged,
	{
		ear1 = "Eabani Earring", ear2 = "Suppanomimi",
	})

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Ebullience'] = { head = "Arbatel Bonnet +2" }
	sets.buff['Rapture'] = { head = "Arbatel Bonnet +2" }
	sets.buff['Perpetuance'] = { hands = "Arbatel Bracers +2" }
	sets.buff['Immanence'] = { head = "Nyame Helm", neck = "Warder's Charm +1", body = "Nyame Mail", hands = "Arbatel Bracers +2", back = gear.Lughs.Nuke }
	sets.buff['Penury'] = { legs = "Arbatel Pants +2" }
	sets.buff['Parsimony'] = { legs = "Arbatel Pants +2" }
	sets.buff['Celerity'] = { feet = "Peda. Loafers +3" }
	sets.buff['Alacrity'] = { feet = "Peda. Loafers +3" }
	sets.buff['Klimaform'] = { feet = "Arbatel Loafers +2" }

	sets.HPDown = {}

	sets.HPCure = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff['Light Arts'] = {} --legs="Academic's Pants +3"
	sets.buff['Dark Arts'] = {} --body="Academic's Gown +3"

	sets.buff.Sublimation = { head = "Acad. Mortar. +2", waist = "Embla Sash" }
	sets.buff.DTSublimation = { waist = "Embla Sash" }

	-- Weapons sets
	sets.weapons.Khatvanga = { main = "Khatvanga", sub = "Bloodrain Strap" }
	sets.weapons.Musa = { main = "Musa", sub = "Khonsu" }
	sets.weapons.Maxentius = { main = "Maxentius", sub = "Genmei Shield" }
	sets.weapons.Daybreak = { main = "Daybreak", sub = "Genmei Shield" }
	sets.weapons.DualMaxentius = { main = "Maxentius", sub = "Ternion Dagger +1" }
	sets.weapons.DualDaybreak = { main = "Daybreak", sub = "Ternion Dagger +1" }
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'RDM' then
		set_macro_page(1, 18)
	elseif player.sub_job == 'BLM' then
		set_macro_page(1, 18)
	elseif player.sub_job == 'WHM' then
		set_macro_page(1, 18)
	else
		set_macro_page(1, 18)
	end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 013')
end