-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal', 'DT')
	state.WeaponskillMode:options('Match', 'Normal', 'Proc')
	state.IdleMode:options('Normal', 'Sphere')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Aeneas', 'Tauret')
	state.ExtraMeleeMode = M{ ['description'] = 'Extra Melee Mode', 'None' }

	gear.senuna_tp = { name = "Senuna's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%' } }
	gear.wsd_jse_back = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	
	-- Additional local binds
	send_command('bind @` gs c step')
	send_command('bind ^!@` gs c toggle usealtstep')
	send_command('bind ^@` gs c cycle mainstep')
	send_command('bind !@` gs c cycle altstep')
	send_command('bind ^` input /ja "Saber Dance" <me>')
	send_command('bind !` input /ja "Fan Dance" <me>')
	send_command('bind ^\\\\ input /ja "Chocobo Jig II" <me>')
	send_command('bind !\\\\ input /ja "Spectral Jig" <me>')
	send_command('bind !backspace input /ja "Reverse Flourish" <me>')
	send_command('bind ^backspace input /ja "No Foot Rise" <me>')
	send_command('bind %~` gs c cycle SkillchainMode')

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	sets.buff.Elvorseal =
	{
		head = "Heidrek Mask",
		body = "Heidrek Harness", hands = "Heidrek Gloves",
		legs = "Heidrek Brais", feet = "Heidrek Boots"
	}

	-- Weapons sets
	sets.weapons.Aeneas = { main = "Aeneas", sub = "Ternion Dagger +1" }
	sets.weapons.Tauret = { main = "Tauret", sub = "Ternion Dagger +1" }
	
	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['No Foot Rise'] = {} --body="Horos Casaque +1"

	sets.precast.JA['Trance'] = {} --head="Horos Tiara +1"

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		ammo="Yamarang",
		head="Etoile Tiara",neck="Unmoving Collar +1",ear1="Enchntr. Earring +1",ear2="Handler's Earring +1",
		body = "Maxixi Casaque +1",hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
		back="Toetapper Mantle",waist="Chaac Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet
	}

	sets.Self_Waltz = {
		head="Etoile Tiara",
		body="Dancer's Casaque",ring1="Asklepian Ring"
	}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Samba = {head="Dancer's Tiara",back=gear.stp_jse_back}

	sets.precast.Jig = {feet="Dancer's Shoes"}

	sets.precast.Step = {
		ammo="C. Palug Stone",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Telos Earring",ear2="Digni. Earring",
		body="Mummu Jacket +2",hands="Dancer's Bangles",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back=gear.stp_jse_back,waist="Olseni Belt",legs="Meg. Chausses +2",feet="Malignance Boots"
	}

	sets.Enmity = {
		ammo="Paeapua",
		head="Nyame Helm",neck="Unmoving Collar +1",ear1="Friomisi Earring",ear2="Trux Earring",
		body="Emet Harness +1",hands="Malignance Gloves",ring1="Petrov Ring",ring2="Vengeful Ring",
		back="Solemnity Cape",waist="Goading Belt",legs="Nyame Flanchard",feet="Malignance Boots"
	}

	sets.precast.JA.Provoke = sets.Enmity

	sets.precast.Flourish1 = {}
	sets.precast.Flourish1['Violent Flourish'] = {
		ammo="C. Palug Stone",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Telos Earring",ear2="Digni. Earring",
		body="Mummu Jacket +2",hands="Adhemar Wrist. +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back=gear.stp_jse_back,waist="Olseni Belt",legs="Meg. Chausses +2",feet="Malignance Boots"
	}

	sets.precast.Flourish1['Animated Flourish'] = sets.Enmity

	sets.precast.Flourish1['Desperate Flourish'] = {
		ammo="C. Palug Stone",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Telos Earring",ear2="Digni. Earring",
		body="Mummu Jacket +2",hands="Adhemar Wrist. +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back=gear.stp_jse_back,waist="Olseni Belt",legs="Meg. Chausses +2",feet="Malignance Boots"
	}

	sets.precast.Flourish2 = {}
	sets.precast.Flourish2['Reverse Flourish'] = {back="Toetapper Mantle"} --hands="Charis Bangles +2"

	sets.precast.Flourish3 = {}
	sets.precast.Flourish3['Striking Flourish'] = {} --body="Charis Casaque +2"
	sets.precast.Flourish3['Climactic Flourish'] = {}

	-- Fast cast sets for spells

	sets.precast.FC = {
		ammo="Impatiens",
		head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
		legs="Rawhide Trousers"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Voluspa Tathlum",
		head="Dampening Tam",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Adhemar Jacket +1",hands="Meg. Gloves +2",ring1="Ilabrat Ring",ring2="Regal Ring",
		back=gear.wsd_jse_back,waist="Grunfeld Rope",legs="Samnuha Tights",feet=gear.herculean_wsd_feet
	}
	sets.precast.WS.Proc = {
		ammo="Yamarang",
		head="Wh. Rarab Cap +1",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Sanare Earring",
		body="Dread Jupon",hands="Kurys Gloves",ring1="Defending Ring",ring2="Dark Ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Dashing Subligar",feet="Ahosi Leggings"
	}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		ammo="C. Palug Stone",
		head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",
		body=gear.herculean_wsd_body,
		legs=gear.herculean_wsd_legs
	})
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",body="Meg. Cuirie +2"})

	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
		head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",
		body=gear.herculean_wsd_body,
		legs=gear.herculean_wsd_legs
	})
	sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",body="Meg. Cuirie +2"})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS,
	{
		ammo = "Charis Feather",
		head = "Adhemar Bonnet +1", neck = "Fotia Gorget",
		body = "Mummu Jacket +2", hands = "Mummu Wrists +2", ring1 = "Begrudging Ring",
		waist = "Fotia Belt", legs = "Mummu Kecks +2", feet = "Mummu Gamash. +2"
	})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {
		head="Mummu Bonnet +2",ring1="Begrudging Ring",neck="Fotia Gorget",
		body="Sayadio's Kaftan",hands="Mummu Wrists +2",
		waist="Fotia Belt",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"
	})

	sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {
		head="Adhemar Bonnet +1",
		hands="Adhemar Wrist. +1",
		feet=gear.herculean_ta_feet
	})
	sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS.Acc, {})

	sets.precast.WS['Aeolian Edge'] = {
		ammo="Seeth. Bomblet +1",
		head=gear.herculean_nuke_head,neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Metamor. Ring +1",ring2="Shiva Ring +1",
		back=gear.wsd_jse_back,waist="Chaac Belt",legs=gear.herculean_wsd_legs,feet=gear.herculean_nuke_feet
	}
	sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Sherida Earring"}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Sherida Earring"}
	
	sets.Skillchain = {} --hands="Charis Bangles +2"

	-- Midcast Sets
	sets.midcast.FastRecast = {
		head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Rawhide Trousers",feet="Malignance Boots"
	}

	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {}
	sets.ExtraRegen = {}

	-- Idle sets
	sets.idle =
	{
		ammo = "Aurgelmir Orb",
		head = "Adhemar Bonnet +1", neck = "Anu Torque", ear1 = "Brutal Earring", ear2 = "Dedition Earring",
		body = "Mummu Jacket +2", hands = "Adhemar Wrist. +1", ring1 = "Chirich Ring +1", ring2 = "Petrov Ring",
		back = gear.senuna_tp, waist = "Windbuffet Belt +1", legs = "Meg. Chausses +2", feet = "Horos Toe Shoes +1"
	}

	sets.idle.Sphere = set_combine(sets.idle, {body="Mekosu. Harness"})

	-- Defense sets

	sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Meg. Cuirie +2",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Dark Ring",
		back="Shadow Mantle",waist="Flume Belt +1",legs="Nyame Flanchard",feet="Malignance Boots"
	}

	sets.defense.MDT = {
		ammo="Staunch Tathlum +1",
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Meg. Cuirie +2",hands="Floral Gauntlets",ring1="Defending Ring",ring2="Dark Ring",
		back="Engulfer Cape +1",waist="Engraved Belt",legs="Nyame Flanchard",feet="Ahosi Leggings"
	}
		
	sets.defense.MEVA = {ammo="Staunch Tathlum +1",
		head=gear.herculean_fc_head,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Adhemar Jacket +1",hands="Leyline Gloves",ring1="Vengeful Ring",ring2="Purity Ring",
		back="Mujin Mantle",waist="Engraved Belt",legs="Meg. Chausses +2",feet="Ahosi Leggings"}

	sets.Kiting = { ring2 = "Shneddick Ring" }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged =
	{
		ammo = "Aurgelmir Orb",
		head = "Adhemar Bonnet +1", neck = "Anu Torque", ear1 = "Brutal Earring", ear2 = "Dedition Earring",
		body = "Mummu Jacket +2", hands = "Adhemar Wrist. +1", ring1 = "Chirich Ring +1", ring2 = "Petrov Ring",
		back = gear.senuna_tp, waist = "Windbuffet Belt +1", legs = "Meg. Chausses +2", feet = "Horos Toe Shoes +1"
	}

	sets.engaged.DT = set_combine(sets.engaged, {})

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Saber Dance'] = {} --legs="Horos Tights"
	sets.buff['Climactic Flourish'] = {ammo="Charis Feather",head="Adhemar Bonnet +1",body="Meg. Cuirie +2"} --head="Charis Tiara +2"
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 2)
	elseif player.sub_job == 'NIN' then
		set_macro_page(2, 2)
	elseif player.sub_job == 'SAM' then
		set_macro_page(3, 2)
	elseif player.sub_job == 'THF' then
		set_macro_page(4, 2)
	else
		set_macro_page(5, 2)
	end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 001')
end