function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal')
	state.HybridMode:options('Perfect', 'Perfect2', 'Priwen', 'Aegis', 'MEvaAegis', 'Ochain', 'DD', 'DW', 'TwoHanded')
	state.WeaponskillMode:options('Match', 'Normal', 'Acc')
	state.CastingMode:options('SIRD', 'Normal')
	state.Passive:options('None', 'AbsorbMP')
	state.PhysicalDefenseMode:options('Normal')
	state.MagicalDefenseMode:options('Normal')
	state.ResistDefenseMode:options('Normal')
	state.IdleMode:options('Perfect', 'Perfect2', 'Priwen', 'Aegis', 'MEvaAegis', 'Ochain', 'DD', 'DW', 'TwoHanded')
	state.Weapons:options('Excalibur', 'Sakpata', 'Naegling', 'Staff', "ShiningOne", 'GS', 'DualWeapons', 'DualNaegling')
	
	state.ExtraDefenseMode = M{ ['description'] = 'Extra Defense Mode', 'None', 'MP', 'Twilight' }

	gear.Rudianos =
	{
		FC = { name = "Rudianos's Mantle", augments = { 'HP+60', '"Fast Cast"+10' } },
		TP = { name = "Rudianos's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%' } },
		VIT_WSD = { name = "Rudianos's Mantle", augments = { 'VIT+20', 'Accuracy+20 Attack+20', 'VIT+10', 'Weapon skill damage +10%', 'Damage taken-5%' } },
		Emnity = { name = "Rudianos's Mantle", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'HP+20', 'Enmity+10', 'Phys. dmg. taken-10%' } },
		Shield = { name = "Rudianos's Mantle", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10', 'Chance of successful block +5' } },
		Counter = { name = "Rudianos's Mantle", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10', 'System: 1 ID: 640 Val: 4' } }
	}

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
		head = "Loess Barbuta +1", neck = "Unmoving Collar +1", ear1 = "Odnowa Earring +1", ear2 = "Tuisto Earring",
		body = "Souv. Cuirass +1", hands = "Cab. Gauntlets +3", ring1 = "Eihwaz Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Rudianos.Enmity, waist = "Creed Baudrier", legs = "Souv. Diechlings +1", feet = "Chev. Sabatons +2"
	}

	sets.Enmity.SIRD = set_combine(sets.Enmity,
	{
		ammo = "Staunch Tathlum +1",
		head = "Souv. Schaller +1", neck = "Moonlight Necklace",
		body = "Chev. Cuirass +2",
		waist = "Rumination Sash", legs = "Founder's Hose",
	})

	-- Precast sets to enhance JAs
	sets.precast.JA['Invincible'] = set_combine(sets.Enmity, { legs = "Cab. Breeches +3" })
	sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity, { feet = "Rev. Leggings +3" })
	sets.precast.JA['Sentinel'] = set_combine(sets.Enmity, { feet = "Cab. Leggings +3" })
	sets.precast.JA['Rampart'] = set_combine(sets.Enmity,
	{
		ammo = "Staunch Tathlum +1",
		head = "Cab. Coronet +3",
		body = "Rev. Surcoat +3", "Cab. Gauntlets +3", ring2 = "Supershear Ring",
	})
	sets.precast.JA['Fealty'] = set_combine(sets.Enmity, { body = "Cab. Surcoat +3" })
	sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity, { feet = "Chev. Sabatons +2" })
	sets.precast.JA['Cover'] = set_combine(sets.Enmity, { head = "Rev. Coronet +2", body = "Cab. Surcoat +3" })

	-- add mnd for Chivalry
	sets.precast.JA['Chivalry'] =
	{
		ammo = "Staunch Tathlum +1",
		head = "Sakpata's Helm", neck = "Kgt. Beads +2", ear1 = "Odnowa Earring +1", ear2 = "Etiolation Earring",
		body = "Rev. Surcoat +3", hands = "Cab. Gauntlets +3", ring1 = "Moonlight Ring", ring2 = "Gelatinous Ring +1",
		back = "Moonlight Cape", waist = "Luminary Sash", legs = "Souv. Diechlings +1", feet = "Carmine Greaves +1"
	}

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
		head = "Carmine Mask +1", neck = "Unmoving Collar +1", ear1 = "Odnowa Earring +1", ear2 = "Tuisto Earring",
		body = "Rev. Surcoat +3", hands = "Leyline Gloves", ring1 = "Kishar Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Rudianos.FC, waist = "Creed Baudrier", legs = "Souv. Diechlings +1", feet = "Chev. Sabatons +2"
	}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
	-- TODO: Complete this set and hook it up in PLD.lua (trigger when Cure IV is cast on self)
	sets.precast.FC.CureCheat = set_combine(sets.precast.FC,
	{
		ammo = "Sapience Orb",
		head = "Carmine Mask +1", neck = "Orunmila's Torque", ear1 = "Loquac. Earring", ear2 = "Enchanter's Earring +1",
		body = "Odyssean Chestplate", hands = "Leyline Gloves", ring1 = "Mephitas's Ring +1", ring2 = "Mephitas's Ring",
		back  = gear.Rudianos.FC, waist = "Carrier's Sash", legs = "Eschite Cuisses", feet = "Carmine Greaves +1"
	})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		ammo = "Oshasha's Treatise",
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Thrud Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Epaminondas's Ring",
		back = gear.Rudianos.VIT_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}
	sets.precast.WS.Acc = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS,
	{
		ammo = "Aurgelmir Orb",
		head = "Sakpata's Helm", neck="Fotia Gorget", ear1 = "Ishvara Earring", ear2 = "Moonshade Earring",
		body = "Sakpata's Breastplate", hands = "Sakpata's Gauntlets", ring1 = "Regal Ring", ring2 = "Epaminondas's Ring",
		back = gear.Rudianos.TP, waist = "Fotia Belt", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS,
	{
		ammo = "Aurgelmir Orb",
		head = "Flamma Zucchetto +2", neck = "Fotia Gorget", ear1 = "Mache Earring +1", ear2 = "Moonshade Earring",
		body = "Hjarrandi Breast.", hands = "Flamma Manopolas +2", 	ring1 = "Regal Ring", ring2 = "Hetairoi Ring",
		back = gear.Rudianos.VIT_WSD, waist = "Fotia Belt", legs = "Lustratio Subligar +1", feet = "Nyame Sollerets"
	})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,
	{
		head = "Nyame Helm", neck = "Kgt. Beads +2", ear1 = "Thrud Earring", ear2 = "Moonshade Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Epaminondas's Ring",
		back = gear.Rudianos.VIT_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	})

	sets.precast.WS['Knights of Round'] =
	{
		ammo = "Oshasha's Treatise",
		head = "Nyame Helm", neck = "Kgt. Beads +2", ear1 = "Thrud Earring", ear2 = "Ishvara Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Epaminondas's Ring",
		back = gear.Rudianos.VIT_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Flat Blade'] = {}

	sets.precast.WS['Sanguine Blade'] =
	{
		ammo = "Pemphredo Tathlum",
		head = "Pixie Hairpin +1", neck = "Baetyl Pendant", ear1 = "Thrud Earring", ear2 = "Friomisi Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Archon Ring", ring2 = "Epaminondas's Ring",
		back = "Moonlight Cape", waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Atonement'] =
	{
		ammo = "Sapience Orb",
		head = "Souv. Schaller +1", neck = "Unmoving Collar +1", ear1 = "Trux Earring", ear2 = "Moonshade Earring",
		body = "Souv. Cuirass +1", hands = "Cab. Gauntlets +3", ring1 = "Eihwaz Ring", ring2 = "Supershear Ring",
		back = gear.Rudianos.Enmity, waist = "Fotia Belt", legs = "Souv. Diechlings +1", feet = "Chev. Sabatons +2"
	}

	sets.precast.WS['Impulse Drive'] =
	{
		ammo = "Coiste Bodhar",
		head = "Nyame Helm", neck = "Fotia Gorget", ear1 = "Thrud Earring", ear2 = "Moonshade Earring",
		body = "Hjarrandi Breast.", hands = "Nyame Gauntlets", ring1 = "Regal Ring", ring2 = "Epaminondas's Ring",
		back = gear.Rudianos.VIT_WSD, waist = "Sailfi Belt +1", legs = "Nyame Flanchard", feet = "Sulevia's Leggings +2"
	}

	sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS['Savage Blade'], {})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = { ear2 = "Brutal Earring" }
	sets.AccMaxTP = { ear2 = "Telos Earring" }


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
	sets.midcast.FastRecast.DT = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Flash = set_combine(sets.Enmity, { head = "Carmine Mask +1" })
	sets.midcast.Flash.SIRD = set_combine(sets.midcast.Flash, sets.Enmity.SIRD, {})
	sets.midcast.Stun = set_combine(sets.Enmity, { head = "Carmine Mask +1" })
	sets.midcast.Stun.SIRD = set_combine(sets.midcast.Stun, sets.Enmity.SIRD, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})

	sets.midcast.Cure =
	{
		ammo = "Staunch Tathlum +1",
		head = "Souv. Schaller +1", neck = "Unmoving Collar +1", ear1 = "Odnowa Earring +1", ear2 = "Tuisto Earring",
		body = "Souv. Cuirass +1", hands = "Macabre Gaunt. +1", ring1 = "Eihwaz Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Rudianos.FC, waist = "Rumination Sash", legs = "Founder's Hose", feet = "Odyssean Greaves"
	}
	sets.midcast.Cure.SIRD = set_combine(sets.midcast.Cure, { hands = "Regal Gauntlets" })

	sets.Self_Healing = set_combine(sets.midcast.Cure, {})
	sets.Self_Healing.SIRD = set_combine(sets.Self_Healing, { hands = "Regal Gauntlets" })

	sets.midcast.Reprisal =
	{
		ammo = "Staunch Tathlum +1",
		head = "Souv. Schaller +1", neck = "Unmoving Collar +1", ear1 = "Odnowa Earring +1", ear2 = "Etiolation Earring",
		body = "Rev. Surcoat +3", hands = "Regal Gauntlets", ring1 = "Kishar Ring", ring2 = "Rahab Ring",
		back = gear.Rudianos.FC, waist = "Creed Baudrier", legs = "Souv. Diechlings +1", feet = "Chev. Sabatons +2"
	}
	sets.midcast.Reprisal.SIRD = set_combine(sets.midcast.Reprisal,
	{
		body = "Chev. Cuirass +2",
		waist = "Rumination Sash", legs = "Founder's Hose",
	})

	sets.Cure_Received = { hands = "Souv. Handsch. +1", feet = "Souveran Schuhs +1" }
	sets.Self_Refresh = { waist = "Gishdubar Sash" }

	sets.midcast['Enhancing Magic'] =
	{
		ammo = "Sapience Orb",
		head = "Carmine Mask +1", neck = "Unmoving Collar +1", ear1 = "Odnowa Earring +1", ear2 = "Tuisto Earring",
		body = "Shab. Cuirass +1", hands = "Regal Gauntlets", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Moonlight Cape", waist = "Olympus Sash", legs = "Carmine Cuisses +1", feet = "Carmine Greaves +1"
	}
	sets.midcast['Enhancing Magic'].SIRD =
	{
		ammo = "Staunch Tathlum +1",
		head = "Souv. Schaller +1", neck = "Unmoving Collar +1", ear1 = "Odnowa Earring +1", ear2 = "Tuisto Earring",
		body = "Rev. Surcoat +3", hands = "Regal Gauntlets", ring1 = "Moonlight Ring", ring2 = "Stikini Ring +1",
		back = "Moonlight Cape", waist = "Rumination Sash", legs = "Founder's Hose", feet = "Odyssean Greaves"
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], { waist = "Siegel Sash" })

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],
	{
		ammo = "Staunch Tathlum +1",
		head = "Odyssean Helm", neck = "Unmoving Collar +1", ear1 = "Odnowa Earring +1", ear2 = "Tuisto Earring",
		body = "Odyssean Chestplate", hands = "Souv. Handsch. +1", ring1 = "Stikini Ring +1", ring2 = "Stikini Ring +1",
		back = "Weard Mantle", waist = "Creed Baudrier", legs = "Sakpata's Cuisses", feet = "Souveran Schuhs +1"
	})
	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast.Phalanx,
	{
		head = "Souv. Schaller +1", neck = "Moonlight Necklace",
		waist = "Rumination Sash", legs = "Founder's Hose", feet = "Odyssean Greaves"
	})
	sets.Phalanx_Received = sets.midcast.Phalanx

	sets.midcast['Enlight II'] = sets.midcast['Enhancing Magic']
	sets.midcast['Enlight II'].SIRD = sets.midcast['Enhancing Magic'].SIRD

	sets.midcast.Cocoon = sets.midcast['Enhancing Magic']
	sets.midcast.Cocoon.SIRD = sets.midcast['Enhancing Magic'].SIRD

	sets.midcast['Banishga'] = sets.Enmity
	sets.midcast['Banishga'].SIRD = sets.Enmity.SIRD
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.resting = {}

	-- Idle sets
	sets.idle = {}

	-- Excalibur R15 / Priwen - Capped block
	sets.idle.Perfect =
	{
		sub = "Priwen", ammo = "Staunch Tathlum +1",
		head = "Chev. Armet +3", neck = "Unmoving Collar +1", ear1 = "Odnowa Earring +1", ear2 = "Chev. Earring +1",
		body = "Sakpata's Breastplate", hands = "Macabre Gauntlets +1", ring1 = "Eihwaz Ring", ring2 = "Shadow Ring",
		back = gear.Rudianos.Shield, waist = "Carrier's Sash", legs = "Chev. Cuisses +2", feet = "Rev. Leggings +3"
	}

	-- Brilliance / Srivatsa
	sets.idle.Perfect2 =
	{
		sub = "Srivatsa", ammo = "Staunch Tathlum +1",
		head = "Chev. Armet +3", neck = "Combatant's Torque", ear1 = "Foresti Earring", ear2 = "Chev. Earring +1",
		body = "Sakpata's Breastplate", hands = "Souv. Handsch. +1", ring1 = "Eihwaz Ring", ring2 = "Moonlight Ring",
		back = gear.Rudianos.Shield, waist = "Carrier's Sash", legs = "Chev. Cuisses +2", feet = "Rev. Leggings +3"
	}

	-- MEva/Lower content block
	sets.idle.Priwen =
	{
		sub = "Priwen", ammo = "Staunch Tathlum +1",
		head = "Sakpata's Helm", neck = "Unmoving Collar +1", ear1 = "Odnowa Earring +1", ear2 = "Tuisto Earring",
		body = "Sakpata's Breastplate", hands = "Macabre Gaunt. +1", ring1 = "Eihwaz Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Rudianos.Shield, waist = "Carrier's Sash", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	}

	-- MDT
	sets.idle.Aegis =
	{
		sub = "Aegis", ammo = "Staunch Tathlum +1",
		head = "Sakpata's Helm", neck = "Unmoving Collar +1", ear1 = "Odnowa Earring +1", ear2 = "Tuisto Earring",
		body = "Rev. Surcoat +3", hands = "Sakpata's Gauntlets", ring1 = "Eihwaz Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Rudianos.Counter, waist = "Carrier's Sash", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	}

	-- Brilliance or Sakpata Sword - Highest Magic Protection
	sets.idle.MEvaAegis =
	{
		sub = "Aegis", ammo = "Staunch Tathlum +1",
		head = "Sakpata's Helm", neck = "Unmoving Collar +1", ear1 = "Odnowa Earring +1", ear2 = "Tuisto Earring",
		body = "Sacro Breastplate", hands = "Sakpata's Gauntlets", ring1 = "Moonlight Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Rudianos.Counter, waist = "Carrier's Sash", legs = "Sakpata's Cuisses", feet = "Sakpata's Leggings"
	}

	-- MP Restore
	sets.idle.Ochain =
	{
		sub = "Ochain", ammo = "Staunch Tathlum +1",
		head = "Chev. Armet +3", neck = "Unmoving Collar +1", ear1 = "Odnowa Earring +1", ear2 = "Tuisto Earring",
		body = "Sakpata's Breastplate", hands = "Souv. Handsch. +1", ring1 = "Moonlight Ring", ring2 = "Gelatinous Ring +1",
		back = gear.Rudianos.Enmity, waist = "Flume Belt +1", legs = "Chev. Cuisses +2", feet = "Rev. Leggings +3"
	}

	sets.idle.DD =
	{
		sub = "Blurred Shield +1", ammo = "Coiste Bodhar",
		head = "Flam. Zucchetto +2", neck = "Vim Torque +1", ear1 = "Telos Earring", ear2 = "Balder Earring +1",
		body = "Sakpata's Plate", hands = "Sakpata's Gauntlets", ring1 = "Petrov Ring", ring2 = "Chirich Ring +1",
		back = gear.Rudianos.TP, waist = "Sailfi Belt +1", legs = "Odyssean Cuisses", feet = "Flam. Gambieras +2"
	}

	sets.idle.DW =
	{
		ammo = "Coiste Bodhar",
		head = "Flam. Zucchetto +2", neck = "Vim Torque +1", ear1 = "Telos Earring", ear2 = "Eabani Earring",
		body = "Sakpata's Plate", hands = "Sakpata's Gauntlets", ring1 = "Chirich Ring +1", ring2 = "Chirich Ring +1",
		back = gear.Rudianos.TP, waist = "Reiki Yotai", legs = "Odyssean Cuisses", feet = "Flam. Gambieras +2"
	}

	sets.idle.TwoHanded =
	{
		ammo = "Coiste Bodhar",
		head = "Flam. Zucchetto +2", neck = "Vim Torque +1", ear1 = "Telos Earring", ear2 = "Balder Earring +1",
		body = "Sakpata's Plate", hands = "Sakpata's Gauntlets", ring1 = "Petrov Ring", ring2 = "Epona's Ring",
		back = gear.Rudianos.TP, waist = "Sailfi Belt +1", legs = "Odyssean Cuisses", feet = "Flam. Gambieras +2"
	}

	sets.Kiting = { ring1 = "Shneddick Ring", legs = "Carmine Cuisses +1" }

	sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.latent_regen = {}
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
	sets.Twilight = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Weapons sets
	sets.weapons.Excalibur = { main = "Excalibur" }
	sets.weapons.Sakpata = { main = "Sakpata's Sword" }
	sets.weapons.Naegling = { main = "Naegling" }
	sets.weapons.Staff = { main = "Malignance Pole", sub = "Bloodrain Strap" }
	sets.weapons.ShiningOne = { main = "Shining One", sub = "Bloodrain Strap" }
	sets.weapons.GS = { main = "Montante +1", sub = "Bloodrain Strap" }
	sets.weapons.DualWeapons = { main = "Excalibur", sub = "Ternion Dagger +1" }
	sets.weapons.DualNaegling = { main = "Naegling", sub = "Ternion Dagger +1" }

	-- I don't use defense sets
	sets.defense.Normal = {}

	--------------------------------------
	-- Engaged sets
	--------------------------------------
	-- 'Perfect', 'Perfect2', 'Priwen', 'Aegis', 'MEvaAegis', 'Ochain', 'DD', 'DW'

	sets.engaged = {}

	-- Excalibur R15 / Priwen - Capped block
	sets.engaged.Perfect = set_combine(sets.idle.Perfect, {})

	-- Brilliance / Srivatsa
	sets.engaged.Perfect2 = set_combine(sets.idle.Perfect2, {})

	-- MEva/Lower content block
	sets.engaged.Priwen = set_combine(sets.idle.Priwen, {})

	-- MDT
	sets.engaged.Aegis = set_combine(sets.idle.Aegis, {})

	-- Brilliance or Sakpata Sword - Highest Magic Protection
	sets.engaged.MEvaAegis = set_combine(sets.idle.MEvaAegis, {})

	-- MP Restore
	sets.engaged.Ochain = set_combine(sets.idle.Ochain, {})

	sets.engaged.DD = set_combine(sets.idle.DD, {})

	sets.engaged.DW = set_combine(sets.idle.DW, {})

	sets.engaged.TwoHanded = set_combine(sets.idle.TwoHanded, {})

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
	set_macro_page(1, 8)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 006')
end

function user_job_state_change(stateField, newValue, oldValue)
	if stateField == "Hybrid Mode" then
		-- Update Idle Mode along with HybridMode
		state.IdleMode:set(newValue)
	end
end