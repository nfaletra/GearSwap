-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Acc')
	state.HybridMode:options('Normal', 'DT', 'Cait')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'Proc')
	state.IdleMode:options('Normal', 'Sphere')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Aeneas', 'Aeolian', 'Savage', 'ProcWeapons', 'Evisceration', 'Throwing', 'SwordThrowing', 'Bow')

	state.ExtraMeleeMode = M{ ['description'] = 'Extra Melee Mode', 'None', 'Suppa', 'DWMax', 'Parry'}
	state.AmbushMode = M(false, 'Ambush Mode')

	gear.toutatis_tp = "Toutatis's Cape"
	gear.toutatis_wsd = "Toutatis's Cape"

	-- Additional local binds
	send_command('bind ^` input /ja "Flee" <me>')
	send_command('bind !` input /ra <t>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace input /item "Thief\'s Tools" <t>')
	send_command('bind ^q gs c weapons ProcWeapons;gs c set WeaponSkillMode proc;')
	send_command('bind !q gs c weapons SwordThrowing')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind @r gs c weapons Default;gs c set WeaponSkillMode match') --Requips weapons and gear.
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Special sets (required by rules)
	--------------------------------------
	sets.TreasureHunter = { hands = "Plun. Armlets +2", feet = "Skulk. Poulaines +1" }
	sets.Kiting = { feet = "Trotter Boots" }

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}

	sets.buff['Sneak Attack'] = {}
	sets.buff['Trick Attack'] = { hands = "Pill. Armlets +2" }

	-- Extra Melee sets.  Apply these on top of melee sets.
	sets.Knockback = {}
	sets.Suppa = { ear1 = "Sherida Earring", ear2 = "Suppanomimi" }
	sets.DWEarrings = { ear1 = "Eabani Earring", ear2 = "Suppanomimi" }
	sets.DWMax = { ear1 = "Eabani Earring", ear2 = "Suppanomimi", body = "Adhemar Jacket +1", hands = "Floral Gauntlets", waist = "Reiki Yotai" }
	sets.Parry = {}
	sets.Ambush = {}

	-- Weapons sets
	sets.weapons.Aeneas = { main = "Aeneas", sub = "Gleti's Knife" }
	sets.weapons.Aeolian = { main = "Malevolence", sub = "Malevolence" }
	sets.weapons.Savage = { main = "Naegling", sub = "Gleti's Knife" }
	sets.weapons.ProcWeapons = { main = "Blurred Knife +1", sub = "Atoyac" }
	sets.weapons.Evisceration = { main = "Tauret", sub = "Gleti's Knife" }
	sets.weapons.Throwing = { main = "Aeneas", sub = "Gleti's Knife", range = "Raider's Bmrng.", ammo = empty }
	sets.weapons.SwordThrowing = { main = "Naegling", sub = "Gleti's Knife", range = "Raider's Bmrng.", ammo = empty }
	sets.weapons.Bow = { main = "Aeneas", sub = "Kustawi +1", range = "Kaja Bow", ammo = "Chapuli Arrow" }

	-- Actions we want to use to tag TH.
	sets.precast.Step =
	{
		ammo = "C. Palug Stone",
		head = "Malignance Chapeau", neck = "Combatant's Torque", ear1 = "Mache Earring +1", ear2 = "Odr Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Ramuh Ring +1", ring2 = "Ramuh Ring +1",
		back = gear.toutatis_tp, waist = "Olseni Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.JA['Violent Flourish'] =
	{
		ammo = "C. Palug Stone",
		head = "Malignance Chapeau", neck = "Combatant's Torque", ear1 = "Digni. Earring", ear2 = "Odr Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Ramuh Ring +1", ring2 = "Ramuh Ring +1",
		back = gear.toutatis_tp, waist = "Olseni Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Collaborator'] = {}
	sets.precast.JA['Accomplice'] = {}
	sets.precast.JA['Flee'] = {}
	sets.precast.JA['Hide'] = { body = "Pillager's Vest +2" }
	sets.precast.JA['Conspirator'] = {} 
	sets.precast.JA['Steal'] = {}
	sets.precast.JA['Mug'] = {}
	sets.precast.JA['Despoil'] = { legs = "Raider's Culottes +1", feet = "Skulk. Poulaines +1" }
	sets.precast.JA['Perfect Dodge'] = { hands = "Plun. Armlets +2" }
	sets.precast.JA['Feint'] = {}

	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
	sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

	-- Waltz set (chr and vit)
	sets.precast.Waltz =
	{
		ammo = "Yamarang",
		head = "Mummu Bonnet +2", neck = "Unmoving Collar +1", ear1 = "Enchntr. Earring +1",
		ring2 = "Defending Ring",
	}

	sets.Self_Waltz = { head = "Mummu Bonnet +2" }

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		ammo = "Sapience Orb",
		head = gear.herculean_fc_head, ear1 = "Loquac. Earring",
		hands = "Leyline Gloves", ring2 = "Kishar Ring",
		legs = "Limbo Trousers"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { body = "Passion Jacket", neck = "Magoraga Beads" })

	-- Ranged snapshot gear
	sets.precast.RA = {}

	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Plun. Bonnet +3", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Moonshade Earring",
		body = "Plunderer's Vest +3", hands = "Meg. Gloves +2", ring1 = "Ilabrat Ring", ring2 = "Regal Ring",
		back = gear.toutatis_wsd, feet = "Plun. Poulaines +3",
	}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"],
	{
		ammo = "Yetshila",
		head = "Pill. Bonnet +2", ear1 = "Odr Earring",
		legs = "Pill. Culottes +2"
	})
	sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].SA, {})

	sets.precast.WS["Mandalic Stab"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Mandalic Stab"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Mandalic Stab"].SA = set_combine(sets.precast.WS["Mandalic Stab"],
	{
		ammo = "Yetshila",
		ear1 = "Odr Earring",
		legs = "Pill. Culottes +2"
	})
	sets.precast.WS["Mandalic Stab"].TA = set_combine(sets.precast.WS["Mandalic Stab"], {})
	sets.precast.WS["Mandalic Stab"].SATA = set_combine(sets.precast.WS["Mandalic Stab"].SA, {})

	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Shark Bite"].SA = set_combine(sets.precast.WS["Shark Bite"], {})
	sets.precast.WS["Shark Bite"].TA = set_combine(sets.precast.WS["Shark Bite"], {})
	sets.precast.WS["Shark Bite"].SATA = set_combine(sets.precast.WS["Shark Bite"], {})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS,
	{
		ammo = "Yetshila +1",
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget", ear1 = "Odr Earring",
		hands = "Adhemar Wrist. +1",
		waist = "Fotia Belt", legs = "Pill. Culottes +2", feet = "Mummu Gamash. +2"
	})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {})

	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS,
	{
		neck = "Fotia Gorget",
		waist = "Fotia Belt", legs = "Meg. Chausses +2"
	})

	sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS,
	{
		ear1 = "Ishvara Earring",
		body = "Adhemar Jacket +1", ring1 = "Rufescent Ring",
		waist = "Sailfi Belt +1"
	})
	sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS.Acc, {})

	sets.precast.WS.Proc =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Voltsurge Torque", ear1 = "Digni. Earring", ear2 = "Heartseeker Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Varar Ring +1", ring2 = "Varar Ring +1",
		back = "Ground. Mantle +1", waist = "Olseni Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Last Stand'] =
	{
		head = "Pill. Bonnet +3", neck = "Fotia Gorget", ear1 = "Telos Earring", ear2 = "Enervating Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Apate Ring", ring2 = "Regal Ring",
		back = gear.toutatis_wsd, waist = "Fotia Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Empyreal Arrow'] =
	{
		head = "Pill. Bonnet +3", neck = "Fotia Gorget", ear1 = "Telos Earring", ear2 = "Enervating Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Apate Ring", ring2 = "Regal Ring",
		back = gear.toutatis_wsd, waist = "Fotia Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.precast.WS['Aeolian Edge'] =
	{
		ammo = "Seeth. Bomblet +1",
		head = "Nyame Helm", neck = "Baetyl Pendant", ear1 = "Friomisi Earring", ear2 = "Crematio Earring",
		body = "Nyame Mail", hands = "Nyame Gauntlets", ring1 = "Metamor. Ring +1", ring2 = "Shiva Ring +1",
		back = gear.toutatis_wsd, waist = "Eschan Stone", legs = "Nyame Flanchard", feet = "Nyame Sollerets"
	}

	sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = { ear1 = "Sherida Earring", ear2 = "Ishvara Earring" }
	sets.AccMaxTP = { ear1 = "Sherida Earring +1", ear2 = "Odr Earring" }

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	sets.midcast.FastRecast =
	{
		ammo = "Sapience Orb",
		head = gear.herculean_fc_head, ear1 = "Loquac. Earring",
		hands = "Leyline Gloves",
		legs = "Limbo Trousers", feet = "Malignance Boots"
	}

	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Poisonga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Sleepga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

	-- Ranged gear

	sets.midcast.RA =
	{
		head = "Malignance Chapeau", neck = "Iskur Gorget", ear1 = "Telos Earring", ear2 = "Enervating Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Apate Ring", ring2 = "Regal Ring",
		back = gear.toutatis_tp, waist = "Chaac Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {})

	--------------------------------------
	-- Idle/resting/defense sets
	--------------------------------------
	-- Resting sets
	sets.resting = {}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle =
	{
		ammo = "Staunch Tathlum",
		head = "Malignance Chapeau", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Etiolation Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Gere Ring", ring2 = "Defending Ring",
		back = gear.toutatis_tp, waist = "Reiki Yotai", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	sets.idle.Sphere = set_combine(sets.idle, { body = "Mekosu. Harness" })

	sets.idle.Weak = set_combine(sets.idle, {})

	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.ExtraRegen = { hands = "Turms Mittens +1" }

	-- Defense sets
	sets.defense.PDT =
	{
		ammo = "Staunch Tathlum",
		head = "Malignance Chapeau", neck = "Unmoving Collar +1", ear1 = "Odnowa Earring +1", ear2 = "Etiolation Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Gelatinous Ring +1", ring2 = "Defending Ring",
		back = "Shadow Mantle", waist = "Flume Belt +1", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.defense.MDT =
	{
		ammo = "Staunch Tathlum",
		head = "Malignance Chapeau", neck = "Unmoving Collar +1", ear1 = "Odnowa Earring +1", ear2 = "Etiolation Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Defending Ring", ring2 = "Shadow Ring",
		back = "Engulfer Cape +1", waist = "Engraved Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}

	sets.defense.MEVA =
	{
		ammo = "Staunch Tathlum",
		head = "Malignance Chapeau", neck = "Warder's Charm +1", ear1 = "Odnowa Earring +1", ear2 = "Etiolation Earring",
		body = "Adhemar Jacket +1", hands = "Malignance Gloves", ring1 = "Vengeful Ring", ring2 = "Purity Ring",
		back = "Mujin Mantle", waist = "Engraved Belt", legs = "Malignance Tights", feet = "Malignance Boots"
	}


	--------------------------------------
	-- Melee sets
	--------------------------------------
	-- Normal melee group
	sets.engaged =
	{
		ammo = "Aurgelmir Orb",
		head = "Adhemar Bonnet +1", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Telos Earring",
		body = "Pillager's Vest +2", hands = "Adhemar Wrist. +1", ring1 = "Gere Ring", ring2 = "Epona's Ring",
		back = gear.toutatis_tp, waist = "Reiki Yotai", legs = "Samnuha Tights", feet = "Plun. Poulaines +3"
	}
	sets.engaged.Acc =
	{
		ammo = "Yamarang",
		head = "Malignance Chapeau", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Telos Earring",
		body = "Pillager's Vest +2", hands = "Adhemar Wrist. +1", ring1 = "Gere Ring", ring2 = "Regal Ring",
		back = gear.toutatis_tp, waist = "Reiki Yotai", legs = "Malignance Tights", feet = "Plun. Poulaines +3"
	}

	sets.engaged.DT =
	{
		ammo = "Aurgelmir Orb",
		head = "Malignance Chapeau", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Telos Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Gere Ring", ring2 = "Moonbeam Ring",
		back = gear.toutatis_tp, waist = "Reiki Yotai", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	sets.engaged.Acc.DT = set_combine(sets.engaged.DT, { feet = "Plun. Poulaines +3" })

	sets.engaged.Cait =
	{
		ammo = "Falcon Eye",
		head = "Malignance Chapeau", neck = "Asn. Gorget +2", ear1 = "Sherida Earring", ear2 = "Eabani Earring",
		body = "Malignance Tabard", hands = "Malignance Gloves", ring1 = "Gere Ring", ring2 = "Epona's Ring",
		back = gear.toutatis_tp, waist = "Reiki Yotai", legs = "Malignance Tights", feet = "Malignance Boots"
	}
	sets.engaged.Acc.Cat = set_combine(sets.engaged.Cait, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 2)
	elseif player.sub_job == 'DRK' then
		set_macro_page(3, 2)
	elseif player.sub_job == 'NIN' then
		set_macro_page(2, 2)
	else
		set_macro_page(4, 2)
	end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 002')
end

--Job Specific Trust Override
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()

				if spell_recasts[993] < spell_latency and not have_trust("Lilisette") then
					windower.chat.input('/ma "Lilisette II" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[955] < spell_latency and not have_trust("Yoran-Oran") then
					windower.chat.input('/ma "Yoran-Oran (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.chat.input('/ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.chat.input('/ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.chat.input('/ma "Ulmia" <me>')
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

autows_list = {
	['Aeneas']="Rudra's Storm",['Aeolian']='Aeolian Edge',['Savage']='Savage Blade',['AccSavage']='Savage Blade',
	['AccAeneas']='Savage Blade',['ProcWeapons']='Wasp Sting'
}