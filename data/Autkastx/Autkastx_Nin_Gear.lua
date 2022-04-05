-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	state.OffenseMode:options('Normal', 'Tank', 'H2H', 'GKT')
	state.HybridMode:options('Normal', 'DT', 'Evasion')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Match', 'Normal', 'Proc')
	state.CastingMode:options('Normal', 'Proc', 'Resistant')
	state.IdleMode:options('Normal', 'Sphere')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Naegling', 'NaeglingAcc', 'HeishiPhys', 'HeishiMag', 'Magic', 'Tauret', 'GKT', 'Karambit', 'ProcDagger', 'ProcSword', 'ProcGreatSword', 'ProcScythe', 'ProcPolearm', 'ProcGreatKatana', 'ProcKatana', 'ProcClub', 'ProcStaff')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'Haste40', 'Haste35', 'Haste30', 'Haste25', 'Haste20', 'Haste15', 'Haste10' }

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
		ammo = "Date Shuriken",
		head = "Dampening Tam", neck = "Unmoving Collar +1", ear1 = "Cryptic Earring", ear2 = "Trux Earring",
		body = "Emet Harness +1", hands = "Kurys Gloves", ring1 = "Vengeful Ring", ring2 = "Supershear Ring",
		back = gear.andartia_tp, waist = "Trance Belt", legs = "Zoar Subligar +1", feet = "Mochi. Kyahan +2"
	}

	-- Precast sets to enhance JAs
	sets.precast.JA['Mijin Gakure'] = { legs = "Mochi. Hakama +2" }
	sets.precast.JA['Yonin'] = { head = "Mochi. Hatsuburi +3", legs = "Hattori Hakama +1" }
	sets.precast.JA['Innin'] = { head = "Mochi. Hatsuburi +3" }
	sets.precast.JA['Provoke'] = sets.Enmity

	-- Buff sets
	sets.buff['Futae'] = { hands = "Hattori Tekko +1" }

	-- Waltz set (chr and vit)
	sets.precast.Waltz =
	{
		ammo = "Yamarang",
		head = "Mummu Bonnet +2", neck = "Unmoving Collar +1", ear1 = "Enchntr. Earring +1", ear2 = "Handler's Earring +1",
		body = gear.herculean_waltz_body, hands = gear.herculean_waltz_hands, ring1 = "Valseur's Ring", ring2 = "Defending Ring",
		back = "Moonlight Cape", waist = "Chaac Belt", legs = "Dashing Subligar", feet = gear.herculean_waltz_feet
	}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Set for acc on steps, since Yonin drops acc a fair bit
	sets.precast.Step =
	{
		ammo = "Togakushi Shuriken",
		head = "Dampening Tam", neck = "Moonbeam Nodowa", ear1 = "Mache Earring +1", ear2 = "Telos Earring",
		body = "Mummu Jacket +2", hands = gear.adhemar.hands.a, ring1 = "Ramuh Ring +1", ring2 = "Ramuh Ring +1",
		back = "Andartia's Mantle", waist = "Olseni Belt", legs = "Mummu Kecks +2", feet = "Malignance Boots"
	}

	sets.precast.Flourish1 = {ammo="Togakushi Shuriken",
		head="Dampening Tam",neck="Moonbeam Nodowa",ear1="Gwati Earring",ear2="Digni. Earring",
		body="Mekosu. Harness",hands=gear.adhemar.hands.a,ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back="Andartia's Mantle",waist="Olseni Belt",legs="Hattori Hakama +1",feet="Malignance Boots"}

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		ammo = "Sapience Orb",
		head = gear.herculean_fc_head, neck = "Orunmila's Torque", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = gear.adhemar.body.d, hands = "Leyline Gloves", ring1 = "Rahab Ring", ring2 = "Kishar Ring",
		back = gear.andartia_tp, waist = "Flume Belt +1"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC,
	{
		neck = "Magoraga Beads",
		body = "Mochi. Chainmail +3",
	})
	sets.precast.FC.Shadows = set_combine(sets.precast.FC.Utsusemi, {ammo="Staunch Tathlum",ring1="Prolix Ring"})

	-- Snapshot for ranged
	sets.precast.RA = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		ammo = "Voluspa Tathlum",
		head = "Mpaca's Cap", neck = "Caro Necklace", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Sailfi Belt +1", legs = "Mochi. Hakama +2", feet = "Nyame Sollerets"
	}

	sets.precast.WS.Proc =
	{
		ammo = "Togakushi Shuriken",
		head = "Ynglinga Sallet", neck = "Moonbeam Nodowa", ear1 = "Mache Earring +1", ear2 = "Telos Earring",
		body = "Mummu Jacket +2", hands = "Mummu Wrists +2", ring1 = "Ramuh Ring +1", ring2 = "Ramuh Ring +1",
		back = gear.andartia_tp, waist = "Olseni Belt", legs = "Mummu Kecks +2", feet = "Malignance Boots"
	}

	sets.precast.WS['Blade: Shun'] =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Odr Earring",
		body = "Ken. Samue", hands = gear.adhemar.hands.b, ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Jokushu Haidate", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Blade: Ten'] =
	{
		ammo = "Voluspa Tathlum",
		head = "Mpaca's Cap", neck = "Ninja Nodowa", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Sailfi Belt +1", legs = "Mochi. Hakama +2", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Blade: Kamu'] =
	{
		ammo = "Voluspa Tathlum",
		head = "Hachiya Hatsu. +3", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Ishvara Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Mochi. Hakama +2", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Blade: Hi'] =
	{
		ammo = "Yetshila +1",
		head = "Adhemar Bonnet +1", neck = "Ninja Nodowa", ear1 = "Lugra Earring +1", ear2 = "Odr Earring",
		body = "Ken. Samue", hands = "Ryuo Tekko +1", ring1 = "Ilabrat Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Svelt. Gouriz +1", legs = "Mochi. Hakama +2", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Blade: Ku'] =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Mache Earring +1",
		body = "Ken. Samue", hands = gear.adhemar.hands.b, ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Samnuha Tights", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Blade: Chi'] =
	{
		ammo = "Seething Bomblet +1",
		head = "Mochi. Hatsuburi +3", neck = "Fotia Gorget", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Blade: To'] =
	{
		ammo = "Seething Bomblet +1",
		head = "Mochi. Hatsuburi +3", neck = "Fotia Gorget", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Blade: Teki'] =
	{
		ammo = "Seething Bomblet +1",
		head = "Mochi. Hatsuburi +3", neck = "Fotia Gorget", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Blade: Ei'] =
	{
		ammo = "Seething Bomblet +1",
		head = "Pixie Hairpin +1", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Archon Ring", ring2 = "Dingir Ring",
		back = gear.andartia_tp, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Blade: Yu'] =
	{
		ammo = "Seething Bomblet +1",
		head = "Mochi. Hatsuburi +3", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Acumen Ring", ring2 = "Dingir Ring",
		back = gear.andartia_tp, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Blade: Jin'] =
	{
		ammo = "Yetshila +1",
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Odr Earring",
		body = "Ken. Samue", hands = "Ryuo Tekko +1", ring1 = "Ilabrat Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Blade: Rin'] =
	{
		ammo = "Yetshila +1",
		head = "Hachiya Hatsu. +3", neck = "Ninja Nodowa", ear1 = "Lugra Earring +1", ear2 = "Odr Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Sailfi Belt +1", legs = "Mochi. Hakama +2", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Blade: Retsu'] =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Ninja Nodowa", ear1 = "Crep. Earring", ear2 = "Digni. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Etana Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Eschan Stone", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Savage Blade'] =
	{
		ammo = "Voluspa Tathlum",
		head = "Mpaca's Cap", neck = "Caro Necklace", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Sailfi Belt +1", legs = "Mochi. Hakama +2", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Sanguine Blade'] =
	{
		ammo = "Seething Bomblet +1",
		head = "Pixie Hairpin +1", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Archon Ring", ring2 = "Dingir Ring",
		back = gear.andartia_tp, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Red Lotus Blade'] =
	{
		ammo = "Seeting Bomblet +1",
		head = "Mochi. Hatsuburi +3", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Acumen Ring", ring2 = "Dingir Ring",
		back = gear.andartia_tp, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Seraph Blade'] =
	{
		ammo = "Seething Bomblet +1",
		head = "Mochi. Hatsuburi +3", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Acumen Ring", ring2 = "Dingir Ring",
		back = gear.andartia_tp, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Flat Blade'] =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Ninja Nodowa", ear1 = "Crep. Earring", ear2 = "Digni. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Etana Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Eschan Stone", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Vorpal Blade'] =
	{
		ammo = "Yetshila +1",
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Odr Earring",
		body = "Ken. Samue", hands = "Ryuo Tekko +1", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Evisceration'] =
	{
		ammo = "Yetshila +1",
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Odr Earring",
		body = "Ken. Samue", hands = "Ryuo Tekko +1", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Aeolian Edge'] =
	{
		ammo = "Seething Bomblet +1",
		head = "Mochi. Hatsuburi +3", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Acumen Ring", ring2 = "Dingir Ring",
		back = gear.andartia_tp, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Asuran Fists'] =
	{
		ammo = "Voluspa Tathlum",
		head = "Hachiya Hatsu. +3", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Telos Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Mochi. Hakama +2", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Raging Fists'] =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Ken. Samue", hands = gear.adhemar.hands.b, ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Combo'] =
	{
		ammo = "Coiste Bodhar",
		head = "Mpaca's Cap", neck = "Fotia Gorget", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Ken. Samue", hands = gear.adhemar.hands.b, ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	}

	sets.precast.WS['Shoulder Tackle'] =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Ninja Nodowa", ear1 = "Crep. Earring", ear2 = "Digni. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Etana Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Eschan Stone", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Spinning Attack'] =
	{
		ammo = "Voluspa Tathlum",
		head = "Mpaca's Cap", neck = "Caro Necklace", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Sailfi Belt +1", legs = "Mochi. Hakama +2", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Tachi: Kasha'] =
	{
		ammo = "Voluspa Tathlum",
		head = "Mpaca's Cap", neck = "Caro Necklace", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Sailfi Belt +1", legs = "Mochi. Hakama +2", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Tachi: Jinpu'] =
	{
		ammo = "Seething Bomblet +1",
		head = "Mochi. Hastuburi +3", neck = "Fotia Gorget", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Tachi: Ageha'] =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Ninja Nodowa", ear1 = "Crep. Earring", ear2 = "Digni. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Etana Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Eschan Stone", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Tachi: Hobaku'] =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Ninja Nodowa", ear1 = "Crep. Earring", ear2 = "Digni. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Etana Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Eschan Stone", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Tachi: Kagero'] =
	{
		ammo = "Seething Bomblet +1",
		head = "Mochi. Hatsuburi +3", neck = "Fotia Gorget", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Belt", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Tachi: Koki'] =
	{
		ammo = "Seething Bomblet +1",
		head = "Mochi. Hatsuburi +3", neck = "Fotia Gorget", ear1 = "Friomisi Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Fotia Gorget", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Tachi: Enpi'] =
	{
		ammo = "Voluspa Tathlum",
		head = "Mpaca's Cap", neck = "Caro Necklace", ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Sailfi Belt +1", legs = "Mochi. Hakama +2", feet = "Nyame Sollerets"
	}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {}
	sets.AccDayWSEars = {}
	sets.DayWSEars = {}

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	sets.midcast.FastRecast =
	{
		ammo = "Sapience Orb",
		head = gear.herculean_fc_head, neck = "Orunmila's Torque", ear1 = "Enchntr. Earring +1", ear2 = "Loquac. Earring",
		body = gear.adhemar.body.d, hands = "Leyline Gloves", ring1 = "Rahab Ring", ring2 = "Kishar Ring",
		waist = "Flume Belt +1"
	}

	sets.midcast.ElementalNinjutsu =
	{
		ammo = "Pemphredo Tathlum",
		head = "Mochi. Hatsuburi +3", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Crematio Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Acumen Ring", ring2 = "Dingir Ring",
		back = gear.andartia_tp, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Mochi. Kyahan +2"
	}

	sets.midcast.ElementalNinjutsu.Proc = sets.midcast.FastRecast
	sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {})

	sets.MagicBurst =
	{
		ammo = "Pemphredo Tathlum",
		head = "Mochi. Hatsuburi +3", neck = "Baetyl Pendant", ear1 = "Static Earring", ear2 = "Crematio Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Locus Ring", ring2 = "Mujin Band",
		back = gear.andartia_tp, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Mochi. Kyahan +2"
	}

	sets.midcast.NinjutsuDebuff =
	{
		ammo = "Yamarang",
		head = "Hachiya Hatsu. +3", neck = "Sanctity Necklace", ear1 = "Crep. Earring", ear2 = "Digni. Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Stikini Ring", ring2 = "Regal Ring",
		back = gear.andartia_tp, waist = "Eschan Stone", legs = "Malignance Tights", feet = "Mochi. Kyahan +2"
	}

	sets.midcast.NinjutsuBuff =
	{
		ammo = "Sapience Orb",
		head = "Hachiya Hatsu. +3", neck = "Incanter's Torque", ear1 = "Hnoss earring", ear2 = "Stealth Earring",
		body = gear.adhemar.body.d, hands = "Leyline Gloves", ring1 = "Stikini Ring", ring2 = "Stikini Ring",
		back = gear.andartia_tp, waist = "Cimmerian Sash", feet = "Mochi. Kyahan +"
	}

	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, { back = "Andartia's Mantle", feet = "Hattori Kyahan +1" })

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
		body = "Mpaca's Doublet", hands = "Nyame Gauntlets", ring1 = "Warden's Ring", ring2 = "Defending Ring",
		back = gear.andartia_tp, waist = "Carrier's Sash", legs = "Mpaca's Hose", feet = "Nyame Sollerets"
	}

	sets.idle.Sphere = set_combine(sets.idle, { body = "Mekosu. Harness" })

	sets.defense.PDT = {}
	sets.defense.MDT = {}
	sets.defense.MEVA = {}

	sets.Kiting = { feet = "Danzo Sune-Ate" }
	sets.DuskKiting = { feet = "Hachiya Kyahan +3" }
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
		body = "Ken. Samue", hands = gear.adhemar.hands.a, ring1 = "Gere Ring", ring2 = "Epona's Ring",
		back = gear.andartia_tp, waist = "Windbuffet Belt +1", legs = "Samnuha Tights", feet = "Ken. Sune-Ate"
	}
	sets.engaged.Tank = set_combine(sets.engaged,
	{
		ammo = "Date Shuriken",
		ear1 = "Cryptic Earring", --ear2 = "Trux Earring",
		--ring2 = "Eihwaz Ring",
	})
	sets.engaged.H2H = set_combine(sets.engaged,
	{
		head = "Hiza. Somen +2", ear1 = "Mache Earring +1",
		legs = "Mpaca's Hose", feet = "Mpaca's Boots"
	})
	sets.engaged.GKT = set_combine(sets.engaged,
	{
		ear1 = "Crep. Earring",
		hands = "Ken. Tekko",
	})

	sets.engaged.DT =
	{
		ammo = "Happo Shuriken",
		head = "Malignance Chapeau", neck = "Ninja Nodowa", ear1 = "Brutal Earring", ear2 = "Telos Earring",
		body = "Mpaca's Doublet", hands = "Malignance Gloves", ring1 = "Gere Ring", ring2 = "Defending Ring",
		back = gear.andartia_tp, waist = "Carrier's Sash", legs = "Mpaca's Hose", feet = "Malignance Boots"
	}
	sets.engaged.Tank.DT = set_combine(sets.engaged.DT,
	{
		ammo = "Date Shuriken",
		ear1 = "Cryptic Earring", --ear2 = "Trux Earring",
		hands = gear.adhemar.hands.a, --ring1 = "Pernicious Ring",
		feet = "Mpaca's Boots"
	})
	sets.engaged.H2H.DT = set_combine(sets.engaged.DT,
	{
		head = "Hiza. Somen +2", ear1 = "Mache Earring +1",
		waist = "Windbuffet Belt +1", feet = "Mpaca's Boots"
	})
	sets.engaged.GKT.DT = set_combine(sets.engaged.DT,
	{
		ear1 = "Crep. Earring",
		waist = "Windbuffet Belt +1"
	})

	sets.engaged.Evasion =
	{
		ammo = "Happo Shuriken",
		head = "Malignance Chapeau", neck = "Ninja Nodowa", ear1 = "Brutal Earring", ear2 = "Telos Earring",
		body = "Mpaca's Doublet", hands = gear.adhemar.hands.a, ring1 = "Vengeful Ring", ring2 = "Ilabrat Ring",
		back = gear.andartia_tp, waist = "Sailfi Belt +1", legs = "Mpaca's Hose", feet = "Malignance Boots"
	}
	sets.engaged.Tank.Evasion = set_combine(sets.engaged.Evasion,
	{
		ammo = "Date Shuriken",
		neck = "Bathy Choker +1", ear1 = "Eabani Earing", ear2 = "Infused Earring",
		hands = "Nyame Gauntlets", ring2 = "Defending Ring",
		waist = "Svelt. Gouriz +1", feet = "Nyame Sollerets"
	})
	sets.engaged.H2H.Evasion = set_combine(sets.engaged.Evasion,
	{
		head = "Hiza. Somen +2", neck = "Bathy Choker +1", ear1 = "Mache Earring +1",
		hands = "Malignance Gloves",
		waist = "Svelt. Gouriz +1"
	})
	sets.engaged.GKT.Evasion = set_combine(sets.engaged.Evasion,
	{
		ear1 = "Eabani Earring", ear2 = "Infused Earring",
		hands = "Malignance Gloves",
		waist = "Svelt. Gouriz +1"
	})

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
	sets.Haste40 = { waist = "Reiki Yotai" }
	sets.Haste35 = { waist = "Reiki Yotai", feet = "Hiza. Sune-Ate +2" }
	sets.Haste30 = { head = "Ryuo Somen +1", ear1 = "Eabani Earring", waist = "Reiki Yotai" }
	sets.Haste25 = { head = "Ryuo Somen +1", body = "Mochi. Chainmail +3", legs = "Hachiya Hakama +3" }
	sets.Haste20 = { head = "Ryuo Somen +1", ear1 = "Eabani Earring", body = "Mochi. Chainmail +3", legs = "Hachiya Hakama +3" }
	sets.Haste15 = { head = "Ryuo Somen +1", ear1 = "Eabani Earring", body = "Mochi. Chainmail +3", waist = "Reiki Yotai", legs = "Hachiya Hakama +3" }
	sets.Haste10 = { head = "Ryuo Somen +1", ear1 = "Eabani Earring", body = "Mochi. Chainmail +3", waist = "Reiki Yotai", legs = "Mochi. Hakama +2" }
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = { legs = "Ryuo Hakama" }

	-- Weapons sets
	sets.weapons.Naegling = { main = "Naegling", sub = "Uzura +2" }
	sets.weapons.NaeglingAcc = { main = "Naegling", sub = "Kunimitsu" }
	sets.weapons.HeishiPhys = { main = "Heishi Shorinken", sub = "Gleti's Knife" }
	sets.weapons.HeishiMag = { main = "Heishi Shorinken", sub = "Kunimitsu" }
	sets.weapons.Magic = { main = "Kunimitsu", sub = "Ochu" }
	sets.weapons.Tauret = { main = "Tauret", sub = "Kunimitsu" }
	sets.weapons.GKT = { main = "Hachimonji", sub = "Bloodrain Strap" }
	sets.weapons.Karambit = { main = "Karambit" }
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