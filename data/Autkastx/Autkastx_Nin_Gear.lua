-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	state.OffenseMode:options('Normal', 'Acc')
	state.HybridMode:options('Normal', 'DT', 'Tank')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'Proc')
	state.CastingMode:options('Normal', 'Proc', 'Resistant')
	state.IdleMode:options('Normal', 'Sphere')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Heishi', 'Savage', 'Evisceration', 'Karambit', 'MagicWeapons', 'ProcDagger', 'ProcSword', 'ProcGreatSword', 'ProcScythe', 'ProcPolearm', 'ProcGreatKatana', 'ProcKatana', 'ProcClub', 'ProcStaff')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'SuppaBrutal', 'DWEarrings', 'DWMax'}

	gear.andartia_tp = { name="Andartia's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10' } }
	gear.andartia_wsd = { name="Andartia's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10' } }

	send_command('bind ^` input /ja "Innin" <me>')
	send_command('bind !` input /ja "Yonin" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !@^` gs c cycle Stance')
	send_command('bind ^r gs c weapons Default;gs c set WeaponskillMode Normal;gs c set CastingMode Normal;gs c update')

	utsusemi_cancel_delay = .3
	utsusemi_ni_cancel_delay = .06

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	sets.Enmity =
	{
		ammo = "Paeapua",
		head = "Dampening Tam", neck = "Unmoving Collar +1", ear1 = "Friomisi Earring", ear2 = "Trux Earring",
		body = "Emet Harness +1", hands = "Kurys Gloves", ring1 = "Petrov Ring", ring2 = "Vengeful Ring",
		back = "Moonlight Cape", waist = "Goading Belt", legs = "Nyame Flanchard", feet = "Amm Greaves"
	}

	-- Precast sets to enhance JAs
	sets.precast.JA['Mijin Gakure'] = {} --legs="Mochizuki Hakama",--main="Nagi"
	sets.precast.JA['Futae'] = {hands="Hattori Tekko +1"}
	sets.precast.JA['Sange'] = {} --legs="Mochizuki Chainmail"
	sets.precast.JA['Provoke'] = sets.Enmity
	sets.precast.JA['Warcry'] = sets.Enmity

	-- Waltz set (chr and vit)
	sets.precast.Waltz =
	{
		ammo = "Yamarang",
		head = "Mummu Bonnet +2", neck = "Unmoving Collar +1", ear1 = "Enchntr. Earring +1", ear2 = "Handler's Earring +1",
		body = gear.herculean_waltz_body, hands = gear.herculean_waltz_hands, ring1 = "Defending Ring", ring2 = "Valseur's Ring",
		back = "Moonlight Cape", waist = "Chaac Belt", legs = "Dashing Subligar", feet = gear.herculean_waltz_feet
	}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Set for acc on steps, since Yonin drops acc a fair bit
	sets.precast.Step =
	{
		ammo = "Togakushi Shuriken",
		head = "Dampening Tam", neck = "Moonbeam Nodowa", ear1 = "Mache Earring +1", ear2 = "Telos Earring",
		body = "Mummu Jacket +2", hands = "Adhemar Wrist. +1", ring1 = "Ramuh Ring +1", ring2 = "Ramuh Ring +1",
		back = "Andartia's Mantle", waist = "Olseni Belt", legs = "Mummu Kecks +2", feet = "Malignance Boots"
	}

	sets.precast.Flourish1 = {ammo="Togakushi Shuriken",
		head="Dampening Tam",neck="Moonbeam Nodowa",ear1="Gwati Earring",ear2="Digni. Earring",
		body="Mekosu. Harness",hands="Adhemar Wrist. +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back="Andartia's Mantle",waist="Olseni Belt",legs="Hattori Hakama +1",feet="Malignance Boots"}

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		ammo = "Impatiens",
		head = gear.herculean_fc_head, neck = "Voltsurge Torque", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = "Dread Jupon", hands = "Leyline Gloves", ring1 = "Lebeche Ring", ring2 = "Kishar Ring",
		legs = "Rawhide Trousers", feet = "Mochi. Kyahan +1"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC,
	{
		neck = "Magoraga Beads",
		body = "Mochi. Chainmail +3",
		feet = "Hattori Kyahan +1"
	})
	sets.precast.FC.Shadows = set_combine(sets.precast.FC.Utsusemi, {ammo="Staunch Tathlum",ring1="Prolix Ring"})

	-- Snapshot for ranged
	sets.precast.RA = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		ammo = "Voluspa Tathlum",
		head = "Lilitu Headpiece", neck = "Fotia Gorget", ear1 = "Brutal Earring", ear2 = "Telos Earring",
		body = "Adhemar Jacket +1", hands = "Adhemar Wrist. +1", ring1 = "Ilabrat Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Hiza. Hizaroyoi +2", feet = gear.herculean_ta_feet
	}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	sets.precast.WS.Proc =
	{
		ammo = "Togakushi Shuriken",
		head = "Ynglinga Sallet", neck = "Moonbeam Nodowa", ear1 = "Mache Earring +1", ear2 = "Telos Earring",
		body = "Mummu Jacket +2", hands = "Mummu Wrists +2", ring1 = "Ramuh Ring +1", ring2 = "Ramuh Ring +1",
		back = gear.andartia_tp, waist = "Olseni Belt", legs = "Mummu Kecks +2", feet = "Malignance Boots"
	}

	sets.precast.WS['Savage Blade'] =
	{
		head = "Mpaca's Cap", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		waist = "Sailfi Belt +1", legs = "Hiza. Hizayoroi +2", feet = "Nyame Sollerets"
	}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Blade: Jin'] =
	{
		ammo = "Yeshila",
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget", ear1 = "Brutal Earring", ear2 = "Odr Earring",
		body = "Ken. Samue", hands = "Ryuo Tekko", ring1 = "Ilabrat Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}
	sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS['Blade: Jin'], {})

	sets.precast.WS['Blade: Hi'] =
	{
		ammo = "Yetshila",
		head = "Adhemar Bonnet +1", neck = "Ninja Nodowa", ear1 = "Brutal Earring", ear2 = "Odr Earring",
		body = "Ken. Samue", hands = "Ryuo Tekko +1", ring1 = "Ilabrat Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Hiza. Hizayoroi +2", feet = "Mpaca's Boots"
	}
	sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'], {})

	sets.precast.WS['Blade: Shun'] =
	{
		ammo = "Aurgelmir Orb",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Brutal Earring", ear2 = "Odr Earring",
		body = "Ken. Samue", hands = "Adhemar Wrist. +1", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Hiza. Hizayoroi +2", feet = "Mpaca's Boots"
	}
	sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS['Blade: Shun'], {})

	sets.precast.WS['Blade: Ten'] =
	{
		ammo = "Aurgelmir Orb",
		head = "Mpaca's Cap", neck = "Ninja Nodowa", ear1 = "Brutal Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Sailfi Belt +1", legs = "Hiza. Hizayoroi +2", feet = "Nyame Sollerets"
	}
	sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS['Blade: Ten'], {})

    sets.precast.WS['Aeolian Edge'] = {ammo="Ghastly Tathlum +1",
        head="Dampening Tam",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Shiva Ring +1",ring2="Metamor. Ring +1",
        back="Toro Cape",waist="Chaac Belt",legs="Nyame Flanchard",feet="Malignance Boots"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Lugra Earring",ear2="Lugra Earring +1",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.AccDayWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayWSEars = {ear1="Moonshade Earring",ear2="Brutal Earring",}


	--------------------------------------
	-- Midcast sets
	--------------------------------------
	sets.midcast.FastRecast =
	{
		head = gear.herculean_fc_head, neck = "Voltsurge Torque", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = "Dread Jupon", hands = "Mochizuki Tekko +1", ring1 = "Defending Ring", ring2 = "Kishar Ring",
		legs = "Rawhide Trousers", feet = "Malignance Boots"
	}

	sets.midcast.ElementalNinjutsu =
	{
		ammo = "Pemphredo Tathlum",
		head = gear.herculean_nuke_head, neck = "Baetyl Pendant", ear1 = "Crematio Earring", ear2 = "Friomisi Earring",
		body = "Samnuha Coat", hands = "Hattori Tekko +1", ring1 = "Shiva Ring +1", ring2 = "Metamor. Ring +1",
		back = "Toro Cape", waist = "Eschan Stone", legs = "Gyve Trousers", feet = gear.herculean_nuke_feet
	}

	sets.midcast.ElementalNinjutsu.Proc = sets.midcast.FastRecast
	sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {})

	sets.MagicBurst = { ring1 = "Mujin Band", ring2 = "Locus Ring" }

	sets.midcast.NinjutsuDebuff =
	{
		ammo = "Ghastly Tathlum +1",
		head = "Dampening Tam", neck = "Incanter's Torque", ear1 = "Gwati Earring", ear2 = "Digni. Earring",
		body = "Mekosu. Harness", hands = "Mochizuki Tekko +1", ring1 = "Stikini Ring +1", ring2 = "Metamor. Ring +1",
		back = "Andartia's Mantle", waist = "Chaac Belt", legs = "Rawhide Trousers", feet = "Mochi. Kyahan +1"
	}

	sets.midcast.NinjutsuBuff = set_combine(sets.midcast.FastRecast, { back = "Mujin Mantle" })

	sets.midcast.Utsusemi = set_combine(sets.midcast.NinjutsuBuff, { back = "Andartia's Mantle", feet = "Hattori Kyahan +1" })

	sets.midcast.RA =
	{
		head = "Malignance Chapeau", neck = "Iskur Gorget", ear1 = "Enervating Earring", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Apate Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Chaac Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------
	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle =
	{
		ammo = "Staunch Tathlum",
		head = "Nyame Helm", neck = "Ninja Nodowa", ear1 = "Eabani Earring", ear2 = "Etiolation Earring",
		body = "Mpaca's Doublet", hands = "Nyame Gauntlets", ring1 = "Defending Ring", ring2 = "Warden's Ring",
		back = gear.andartia_tp, waist = "Carrier's Sash", legs = "Mpaca's Hose", feet = "Nyame Sollerets"
	}

	sets.idle.Sphere = set_combine(sets.idle, { body = "Mekosu. Harness" })

	sets.defense.PDT = {}
	sets.defense.MDT = {}
	sets.defense.MEVA = {}

	sets.Kiting = { feet = "Danzo Sune-Ate" }
	sets.DuskKiting = {}
	sets.DuskIdle = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged =
	{
		ammo = "Happo Shuriken",
		head = "Dampening Tam", neck = "Ninja Nodowa", ear1 = "Brutal Earring", ear2 = "Telos Earring",
		body = "Ken. Samue", hands = "Adhemar Wrist. +1", ring1 = "Gere Ring", ring2 = "Epona's Ring",
		back = gear.andartia_tp, waist = "Windbuffet Belt +1", legs = "Samnuha Tights", feet = gear.herculean_ta_feet
	}
	sets.engaged.Acc = set_combine(sets.engaged, {})

	sets.engaged.DT =
	{
		ammo = "Happo Shuriken",
		head = "Malignance Chapeau", neck = "Ninja Nodowa", ear1 = "Brutal Earring", ear2 = "Telos Earring",
		body = "Mpaca's Doublet", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Epona's Ring",
		back = gear.andartia_tp, waist = "Windbuffet Belt +1", legs = "Mpaca's Hose", feet = "Malignance Boots"
	}
	sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {})

	sets.engaged.Tank =
	{
		ammo = "Date Shuriken",
		head = "Malignance Chapeau", neck = "Ninja Nodowa", ear1 = "Cryptic Earring", ear2 = "Trux Earring",
		body = "Mpaca's Doublet", hands = "Adhemar Wrist. +1", ring1 = "Gere Ring", ring2 = "Defending Ring",
		back = gear.andartia_tp, waist = "Windbuffet Belt +1", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}
	sets.engaged.Acc.Tank = set_combine(sets.engaged.Tank, {})

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Migawari = {} -- body = "Hattori Ningi +1"
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Futae = {}
	sets.buff.Yonin = { legs = "Hattori Hakama +1" }
	sets.buff.Innin = {} --head = "Hattori Zukin +1"

	-- Extra Melee sets.  Apply these on top of melee sets.
	sets.Knockback = {}
	sets.SuppaBrutal = { ear1 = "Suppanomimi", ear2 = "Brutal Earring" }
	sets.DWEarrings = {ear1 = "Dudgeon Earring", ear2 = "Heartseeker Earring" }
	sets.DWMax = { ear1 = "Dudgeon Earring", ear2 = "Heartseeker Earring", body = "Adhemar Jacket +1", hands = "Floral Gauntlets", waist = "Shetal Stone" }
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = { legs = "Ryuo Hakama" }

	-- Weapons sets
	sets.weapons.Heishi = { main = "Heishi Shorinken", sub = "Kunimitsu" }
	sets.weapons.Savage = { main = "Naegling", sub = "Kunimitsu" }
	sets.weapons.Evisceration = { main = "Tauret", sub = "Kunimitsu" }
	sets.weapons.Karambit = { main = "Karambit" }
	sets.weapons.MagicWeapons = { main = "Kunimitsu", sub = "Tauret" }
	sets.weapons.ProcDagger = { main = "Chicken Knife II", sub = empty }
	sets.weapons.ProcSword = { main = "Ark Sword", sub = empty }
	sets.weapons.ProcGreatSword = { main = "Lament", sub = empty }
	sets.weapons.ProcScythe = { main = "Ark Scythe", sub = empty }
	sets.weapons.ProcPolearm = { main = "Pitchfork +1", sub = empty }
	sets.weapons.ProcGreatKatana = { main = "Hardwood Katana", sub = empty }
	sets.weapons.ProcKatana = { main = "Kanaria", sub = empty }
	sets.weapons.ProcClub = { main = "Dream Bell +1", sub = empty }
	sets.weapons.ProcStaff = { main = "Chatoyant Staff", sub = empty }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 3)
	elseif player.sub_job == 'RNG' then
		set_macro_page(1, 3)
	elseif player.sub_job == 'RDM' then
		set_macro_page(1, 3)
	else
		set_macro_page(1, 3)
	end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 004')
end