function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal')
	state.HybridMode:options('Perfect', 'Perfect2', 'Priwen', 'Aegis', 'MEvaAegis', 'Ochain', 'DD', 'DW')
	state.WeaponskillMode:options('Match', 'Normal', 'Acc')
	state.CastingMode:options('Normal', 'SIRD')
	state.Passive:options('None', 'AbsorbMP')
	state.PhysicalDefenseMode:options('Normal')
	state.MagicalDefenseMode:options('Normal')
	state.ResistDefenseMode:options('Normal')
	state.IdleMode:options('Perfect', 'Perfect2', 'Priwen', 'Aegis', 'MEvaAegis', 'Ochain', 'DD', 'DW')
	state.Weapons:options('Excalibur', 'Caballarius', 'Malignance', 'Naegling')
	
	state.ExtraDefenseMode = M{ ['description'] = 'Extra Defense Mode', 'None', 'MP', 'Twilight' }
	
	gear.ruidanos_fc = "Rudianos's Mantle" --{ name="Rudianos's Mantle", augments={'HP+60','"Fast Cast"+10',}}
	gear.rudianos_tp = "Rudianos's Mantle" --{ name = "Rudianos's Mantle", augments={ 'HP+60','Accuracy+20 Attack+20','HP+20','"Store TP"+10','Phys. dmg. taken-10%' }}
	gear.rudianos_wsd = "Rudianos's Mantle" -- { name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	gear.rudianos_enmity = "Ruianos's Mantle" -- { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}}
	gear.rudianos_shield = { name = "Rudianos's Mantle", augments = { 'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Chance of successful block +5' }}
	gear.rudianos_counter = "Rudianos's Mantle" -- { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','System: 1 ID: 640 Val: 4',}}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind ^backspace input /ja "Shield Bash" <t>')
	send_command('bind @backspace input /ja "Cover" <stpt>')
	send_command('bind !backspace input /ja "Sentinel" <me>')
	send_command('bind @= input /ja "Chivalry" <me>')
	send_command('bind != input /ja "Palisade" <me>')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
	send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^pause gs c toggle AutoRuneMode')
	send_command('bind ^q gs c set IdleMode Kiting')
	send_command('bind !q gs c set IdleMode Perfect')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')

	select_default_macro_book()
	update_defense_mode()
end

function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	sets.Enmity =
	{
		ammo = "Sapience Orb",
		head = "Souv. Schaller +1", neck = "Unmoving Collar +1", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Souv. Cuirass +1", hands = "Macabre Gaunt. +1", ring1 = "Apeile Ring +1", ring2 = "Apeile Ring",
		back = gear.rudianos_shield, waist = "Creed Baudrier", legs = "Souv. Diechlings +1", feet = "Souv. Schuhs +1"
	}

	sets.Enmity.SIRD = set_combine(sets.Enmity,
	{
		ammo = "Staunch Tathlum",
		head = "Souv. Schaller +1", neck = "Moonbeam Necklace",
		waist = "Rumination Sash", legs = "Founder's Hose", feet = "Odyssean Greaves"
	})

	-- Precast sets to enhance JAs
	sets.precast.JA['Invincible'] = set_combine(sets.Enmity, { legs = "Cab. Breeches +1" })
	sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity, { feet = "Rev. Leggings +3" })
	sets.precast.JA['Sentinel'] = set_combine(sets.Enmity, { feet = "Cab. Leggings +1" })
	sets.precast.JA['Rampart'] = set_combine(sets.Enmity, {}) --head="Valor Coronet" (Also Vit?)
	sets.precast.JA['Fealty'] = set_combine(sets.Enmity, { body = "Cab. Surcoat +1" })
	sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity, { feet = "Chev. Sabatons +1" })
	sets.precast.JA['Cover'] = set_combine(sets.Enmity, { body = "Cab. Surcoat +1" }) --head="Rev. Coronet +1",

	-- add mnd for Chivalry
	sets.precast.JA['Chivalry'] = {}

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, { hands = "Cab. Gauntlets +3" })
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}

	sets.precast.JA['Violent Flourish'] = {}

	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

	-- Fast cast sets for spells

	sets.precast.FC =
	{
		ammo = "Sapience Orb",
		head = "Carmine Mask +1", neck = "Unmoving Collar +1", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Rev. Surcoat +3", hands = "Leyline Gloves", ring1 = "Kishar Ring", ring2 = "Gelatinous Ring +1",
		back = gear.rudianos_fc, waist = "Creed Baudrier", legs = "Souv. Diechlings +1", feet = "Odyssean Greaves"
	}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
	-- TODO: Complete this set and hook it up in PLD.lua (trigger when Cure IV is cast on self)
	sets.precast.FC.CureCheat = set_combine(sets.precast.FC,
	{
		ammo = "Sapience Orb",
		head = "Carmine Mask +1", neck = "Orunmila's Torque", ear1 = "Loquac. Earring", ear2 = "Enchanter's Earring +1",
		body = "Odyssean Chestplate", hands = "Leyline Gloves", ring1 = "Mephitas's Ring +1", ring2 = "Mephitas's Ring",
		back  = gear.rudianos_fc, waist = "Carrier's Sash", legs = "Eschite Cuisses", feet = "Carmine Greaves +1"
	})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}
	sets.precast.WS.Acc = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS,
	{
		ammo = "Aurgelmir Orb",
		head = "Sakpata's Helm", neck="Fotia Gorget", ear1 = "Ishvara Earring", ear2 = "Moonshade Earring",
		body = "Sakpata's Breastplate", hands = "Sakpata's Gauntlets", ring1 = "Regal Ring", ring2 = "Rufescent Ring",
		back = gear.rudianos_tp, waist = "Fotia Belt", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS,
	{
		ammo = "Aurgelmir Orb",
		head = "Flamma Zuchetto +2", neck = "Fotia Gorget", ear1 = "Mache Earring +1", ear2 = "Moonshade Earring",
		body = "Hjarrandi Breastplate", hands = "Flamma Manopolas +2", 	ring1 = "Regal Ring", ring2 = "Hetairoi Ring",
		back = gear.rudianos_wsd, waist = "Fotia Belt", legs = "Lustratio Subligar +1", feet = "Valorous Greaves"
	})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,
	{
		ammo = "Amar Cluster",
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Thrud Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Odyssean Gauntlets", ring1 = "Regal Ring", ring2 = "Rufescent Ring",
		back = gear.rudianos_wsd, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Valorous Greaves"
	})

	sets.precast.WS['Flat Blade'] = {}

	sets.precast.WS['Sanguine Blade'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Pixie Hairpin +1", neck = "Baetyl Pendant", ear1 = "Thrud Earring", ear2 = "Friomisi Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Archon Ring", ring2 = "Rufescent Ring",
		back = "Moonbeam Cape", waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Atonement'] =
	{
		ammo = "Sapience Orb",
		head = "Souv. Schaller +1", neck = "Unmoving Collar +1", ear1 = "Trux Earring", ear2 = "Moonshade Earring",
		body = "Souv. Cuirass +1", hands = "Cab. Gauntlets +3", ring1 = "Apeile Ring +1", ring2 = "Apeile Ring",
		back = gear.rudianos_shield, waist = "Fotia Belt", legs = "Souv. Diechlings +1", feet = "Eschite Greaves"
	}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = { ear2 = "Brutal Earring" }
	sets.AccMaxTP = { ear2 = "Telos Earring" }


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
	sets.midcast.FastRecast.DT = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

	sets.midcast.Cure =
	{
		ammo = "Staunch Tathlum",
		head = "Souv. Schaller +1", neck = "Moonbeam Necklace", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Souv. Cuirass +1", hands = "Macabre Gaunt. +1", ring1 = "Eiwhaz Ring", ring2 = "Gelatinous Ring +1",
		back = gear.rudianos_cure, waist = "Rumination Sash", legs = "Founder's Hose", feet = "Odyssean Greaves"
	}
	sets.midcast.Cure.SIRD = set_combine(sets.midcast.Cure, {})

	sets.Self_Healing =
	{
		ammo = "Staunch Tathlum",
		head = "Souv. Schaller +1", neck = "Moonbeam Necklace", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Souv. Cuirass +1", hands = "Macabre Gaunt. +1", ring1 = "Eiwhaz Ring", ring2 = "Gelatinous Ring +1",
		back = gear.rudianos_cure, waist = "Rumination Sash", legs = "Founder's Hose", feet = "Odyssean Greaves"
	}
	sets.Self_Healing.SIRD = set_combine(sets.Self_Healing, {})

	sets.midcast.Reprisal =
	{
		ammo = "Staunch Tathlum",
		head = "Souv. Schaller +1", neck = "Unmoving Collar +1", ear1 = "Etiolation Earring", ear2 = "Odnowa Earring +1",
		body = "Reverence Surcoat +2", hands = "Regal Gauntlets", ring1 = "Kishar Ring", ring2 = "Rahab Ring",
		back = gear.rudianos_fc, waist = "Creed Baudrier", legs = "Souv. Diechlings +1", feet = "Souv. Schuhs +1"
	}
	sets.midcast.Reprisal.SIRD = set_combine(sets.midcast.Reprisal,
	{
		neck = "Moonbeam Necklace",
		waist = "Rumination Sash", legs = "Founder's Hose", feet = "Odyssean Greaves"
	})

	sets.Cure_Received = { hands = "Souv. Handsch. +1", feet = "Souveran Schuhs +1" }
	sets.Self_Refresh = { waist = "Gishdubar Sash" }

	sets.midcast['Enhancing Magic'] =
	{
		ammo = "Sapience Orb",
		head = "Carmine Mask +1", neck = "Incanter's Torque", ear1 = "Mimir Earring", ear2 = "Andoaa Earring",
		body = "Shab. Cuirass +1", hands = "Regal Gauntlets", ring1 = "Stikini Ring", ring2 = "Stikini Ring",
		back = "Moonbeam Cape", waist = "Olympus Sash", legs = "Carmine Cuisses +1", feet = "Carmine Greaves +1"
	}

	sets.midcast['Enhancing Magic'].SIRD =
	{
		ammo = "Staunch Tathlum",
		head = "Souv. Schaller +1", neck = "Moonbeam Necklace", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Reverence Surcoat +2", hands = "Regal Gauntlets", ring1 = "Moonbeam Ring", ring2 = "Gelatinous Ring +1",
		back = "Moonbeam Cape", waist = "Rumination Sash", legs = "Founder's Hose", feet = "Odyssean Greaves"
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], { waist = "Siegel Sash" })

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],
	{
		ammo = "Staunch Tathlum",
		head = "Odyssean Helm", neck = "Unmoving Collar +1", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Odyssean Chestplate", hands = "Souv. Handsch. +1", ring1 = "Stikini Ring", ring2 = "Stikini Ring",
		back = "Weard Mantle", waist = "Creed Baudrier", legs = "Sakpata's Cuisses", feet = "Souveran Schuhs +1"
	})
	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast.Phalanx,
	{
		head = "Souv. Schaller +1", neck = "Moonbeam Necklace",
		waist = "Rumination Sash", legs = "Founder's Hose", feet = "Odyssean Greaves"
	})

	sets.Phalanx_Received = sets.midcast.Phalanx
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.resting =
	{
		ammo="Homiliary",
		head="Jumalik Helm",neck="Coatl Gorget +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Jumalik Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Moonlight Cape",waist="Fucho-no-obi",legs="Sulev. Cuisses +2",feet="Cab. Leggings +1"
	}

	-- Idle sets
	sets.idle = {}

	-- Excalibur R15 / Priwen - Capped block
	sets.idle.Perfect =
	{
		sub = "Priwen", ammo = "Staunch Tathlum",
		head = "Sakpata's Helm", neck = "Unmoving Collar +1", ear1 = "Foresti Earring", ear2 = "Odnowa Earring +1",
		body = "Sakpata's Breastplate", hands = "Souv. Handschuhs +1", ring1 = "Moonbeam Ring", ring2 = "Defending Ring",
		back = gear.rudianos_shield, waist = "Carrier's Sash", legs = "Sakpata's Cuisses", feet = "Reverence Leggings +2"
	}

	-- Brilliance / Srivatsa
	sets.idle.Perfect2 =
	{
		sub = "Srivatsa", ammo = "Staunch Tathlum",
		head = "Sakpata's Helm", neck = "Unmoving Collar +1", ear1 = "Foresti Earring", ear2 = "Odnowa Earring +1",
		body = "Sakpata's Breastplate", hands = "Souv. Handschuhs +1", ring1 = "Moonbeam Ring", ring2 = "Defending Ring",
		back = gear.rudianos_shield, waist = "Carrier's Sash", legs = "Sakpata's Cuisses", feet = "Reverence Leggings +2"
	}

	-- MEva/Lower content block
	sets.idle.Priwen =
	{
		sub = "Priwen", ammo = "Staunch Tathlum",
		head = "Sakpata's Helm", neck = "Unmoving Collar", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Sakpata's Breastplate", hands = "Macabre Gaunt. +1", ring1 = "Moonbeam Ring", ring2 = "Defending Ring",
		back = gear.rudianos_shield, waist = "Carrier's Sash", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	}

	-- MDT
	sets.idle.Aegis =
	{
		sub = "Aegis", ammo = "Staunch Tathlum",
		head = "Sakpata's Helm", neck = "Unmoving Collar +1", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Reverence Surcoat +2", hands = "Sakpata's Gauntlets", ring1 = "Moonbeam Ring", ring2 = "Defending Ring",
		back = gear.rudianos_counter, waist = "Carrier's Sash", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	}

	-- Brilliance or Sakpata Sword - Highest Magic Protection
	sets.idle.MEvaAegis =
	{
		sub = "Aegis", ammo = "Staunch Tathlum",
		head = "Sakpata's Helm", neck = "Unmoving Collar", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Sacro Breastplate", hands = "Sakpata's Gauntlets", ring1 = "Moonbeam Ring", ring2 = "Defending Ring",
		back = gear.rudianos_counter, waist = "Carrier's Sash", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	}

	-- MP Restore
	sets.idle.Ochain =
	{
		sub = "Ochain", ammo = "Staunch Tathlum",
		head = "Chev. Armet +1", neck = "Unmoving Collar +1", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Sakpata's Breastplate", hands = "Souv. Handschuhs +1", ring1 = "Moonbeam Ring", ring2 = "Defending Ring",
		back = gear.rudianos_shield, waist = "Flume Belt +1", legs = "Chev. Cuisses +1", feet = "Reverence Leggings +2"
	}

	sets.idle.DD =
	{
		sub = "Blurred Shield +1", ammo = "Aurgelmir Orb",
		head = "Sakpata's Helm", neck = "Combatant's Torque", ear1 = "Cessance Earring", ear2 = "Brutal Earring",
		body = "Sakpata's Breastplate", hands = "Acro Gauntlets", ring1 = "Chirich Ring", ring2 = "Chirich Ring",
		back = gear.rudianos_tp, waist = "Sailfi Belt +1", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	}

	sets.idle.DW =
	{
		ammo = "Aurgelmir Orb",
		head = "Flamma Zucchetto +2", neck = "Vim Torque +1", ear1 = "Suppanomimi", ear2 = "Eabani Earring",
		body = "Dagon Breastplate", hands = "Sakpata's Gauntlets", ring1 = "Petrov Ring", ring2 = "Hetairoi Ring",
		back = gear.rudianos_tp, waist = "Sailfi Belt +1", legs = "Sakpata's Cuisses", feet = "Flamma Gambieras +2"
	}

	sets.Kiting = { legs = "Carmine Cuisses +1" }

	sets.latent_refresh = { waist = "Fucho-no-obi" }
	sets.latent_refresh_grip = { sub = "Oneiros Grip" }
	sets.latent_regen = { ring1 = "Apeile Ring +1", ring2 = "Apeile Ring" }
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
	-- Defense sets
	--------------------------------------

	-- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
	sets.MP = {}
	sets.passive.AbsorbMP = {}
	sets.MP_Knockback = {}
	sets.Twilight = { head = "Twilight Helm", body = "Twilight Mail" }
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Weapons sets
	sets.weapons.Excalibur = { main = "Excalibur" }
	sets.weapons.Caballarius = { main = "Caballarius Sword" }
	sets.weapons.Malignance = { main = "Malignance Sword" }
	sets.weapons.Naegling = { main = "Naegling" }

	-- I don't use defense sets
	sets.defense.Normal = {}

	--------------------------------------
	-- Engaged sets
	--------------------------------------
	-- 'Perfect', 'Perfect2', 'Priwen', 'Aegis', 'MEvaAegis', 'Ochain', 'DD', 'DW'

	sets.engaged = {}

	-- Excalibur R15 / Priwen - Capped block
	sets.engaged.Perfect =
	{
		sub = "Priwen", ammo = "Staunch Tathlum",
		head = "Sakpata's Helm", neck = "Unmoving Collar +1", ear1 = "Foresti Earring", ear2 = "Odnowa Earring +1",
		body = "Sakpata's Breastplate", hands = "Souv. Handschuhs +1", ring1 = "Moonbeam Ring", ring2 = "Defending Ring",
		back = gear.rudianos_shield, waist = "Carrier's Sash", legs = "Sakpata's Cuisses", feet = "Reverence Leggings +2"
	}

	-- Brilliance / Srivatsa
	sets.engaged.Perfect2 =
	{
		sub = "Srivatsa", ammo = "Staunch Tathlum",
		head = "Sakpata's Helm", neck = "Unmoving Collar +1", ear1 = "Foresti Earring", ear2 = "Odnowa Earring +1",
		body = "Sakpata's Breastplate", hands = "Souv. Handschuhs +1", ring1 = "Moonbeam Ring", ring2 = "Defending Ring",
		back = gear.rudianos_shield, waist = "Carrier's Sash", legs = "Sakpata's Cuisses", feet = "Reverence Leggings +2"
	}

	-- MEva/Lower content block
	sets.engaged.Priwen =
	{
		sub = "Priwen", ammo = "Staunch Tathlum",
		head = "Sakpata's Helm", neck = "Unmoving Collar", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Sakpata's Breastplate", hands = "Macabre Gaunt. +1", ring1 = "Moonbeam Ring", ring2 = "Defending Ring",
		back = gear.rudianos_shield, waist = "Carrier's Sash", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	}

	-- MDT
	sets.engaged.Aegis =
	{
		sub = "Aegis", ammo = "Staunch Tathlum",
		head = "Sakpata's Helm", neck = "Unmoving Collar +1", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Reverence Surcoat +2", hands = "Sakpata's Gauntlets", ring1 = "Moonbeam Ring", ring2 = "Defending Ring",
		back = gear.rudianos_counter, waist = "Carrier's Sash", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	}

	-- Brilliance or Sakpata Sword - Highest Magic Protection
	sets.engaged.MEvaAegis =
	{
		sub = "Aegis", ammo = "Staunch Tathlum",
		head = "Sakpata's Helm", neck = "Unmoving Collar", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Sacro Breastplate", hands = "Sakpata's Gauntlets", ring1 = "Moonbeam Ring", ring2 = "Defending Ring",
		back = gear.rudianos_counter, waist = "Carrier's Sash", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	}

	-- MP Restore
	sets.engaged.Ochain =
	{
		sub = "Ochain", ammo = "Staunch Tathlum",
		head = "Chev. Armet +1", neck = "Unmoving Collar +1", ear1 = "Tuisto Earring", ear2 = "Odnowa Earring +1",
		body = "Sakpata's Breastplate", hands = "Souv. Handschuhs +1", ring1 = "Moonbeam Ring", ring2 = "Defending Ring",
		back = gear.rudianos_shield, waist = "Flume Belt +1", legs = "Chev. Cuisses +1", feet = "Reverence Leggings +2"
	}

	sets.engaged.DD =
	{
		sub = "Blurred Shield +1", ammo = "Aurgelmir Orb",
		head = "Sakpata's Helm", neck = "Combatant's Torque", ear1 = "Cessance Earring", ear2 = "Brutal Earring",
		body = "Sakpata's Breastplate", hands = "Acro Gauntlets", ring1 = "Chirich Ring", ring2 = "Chirich Ring",
		back = gear.rudianos_tp, waist = "Sailfi Belt +1", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	}

	sets.engaged.DW =
	{
		ammo = "Aurgelmir Orb",
		head = "Flamma Zucchetto +2", neck = "Vim Torque +1", ear1 = "Suppanomimi", ear2 = "Eabani Earring",
		body = "Dagon Breastplate", hands = "Sakpata's Gauntlets", ring1 = "Petrov Ring", ring2 = "Hetairoi Ring",
		back = gear.rudianos_tp, waist = "Sailfi Belt +1", legs = "Sakpata's Cuisses", feet = "Flamma Gambieras +2"
	}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = { neck = "Vim Torque +1" }
	sets.buff.Cover = { body = "Cab. Surcoat +3" }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'NIN' then
		set_macro_page(2, 4)
 	elseif player.sub_job == 'RUN' then
		set_macro_page(9, 4)
	elseif player.sub_job == 'RDM' then
		set_macro_page(6, 4)
	elseif player.sub_job == 'BLU' then
		set_macro_page(8, 4)
	elseif player.sub_job == 'DNC' then
		set_macro_page(4, 4)
	else
		set_macro_page(1, 4) --War/Etc
	end
end