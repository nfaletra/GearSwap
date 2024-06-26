--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- __________.__                                ________                          __               .__.__  __      __  .__    .__           _____.__.__              
-- \______   |  |   ____ _____    ______ ____   \______ \   ____     ____   _____/  |_    ____   __| _|___/  |_  _/  |_|  |__ |__| ______ _/ ____|__|  |   ____      
--  |     ___|  | _/ __ \\__  \  /  ____/ __ \   |    |  \ /  _ \   /    \ /  _ \   __\ _/ __ \ / __ ||  \   __\ \   __|  |  \|  |/  ___/ \   __\|  |  | _/ __ \     
--  |    |   |  |_\  ___/ / __ \_\___ \\  ___/   |    `   (  <_> ) |   |  (  <_> |  |   \  ___// /_/ ||  ||  |    |  | |   Y  |  |\___ \   |  |  |  |  |_\  ___/     
--  |____|   |____/\___  (____  /____  >\___  > /_______  /\____/  |___|  /\____/|__|    \___  \____ ||__||__|    |__| |___|  |__/____  >  |__|  |__|____/\___  > /\ 
--                     \/     \/     \/     \/          \/              \/                   \/     \/                      \/        \/                      \/  \/ 
--
--	Please do not edit this file!							Please do not edit this file!							Please do not edit this file!
--
--	Editing this file will cause you to be unable to use Github Desktop to update!
--
--	Any changes you wish to make in this file you should be able to make by overloading. That is Re-Defining the same variables or functions in another file, by copying and
--	pasting them to a file that is loaded after the original file, all of my library files, and then job files are loaded first.
--	The last files to load are the ones unique to you. User-Globals, Charactername-Globals, Charactername_Job_Gear, in that order, so these changes will take precedence.
--
--	You may wish to "hook" into existing functions, to add functionality without losing access to updates or fixes I make, for example, instead of copying and editing
--	status_change(), you can instead use the function user_status_change() in the same manner, which is called by status_change() if it exists, most of the important 
--  gearswap functions work like this in my files, and if it's unique to a specific job, user_job_status_change() would be appropriate instead.
--
--  Variables and tables can be easily redefined just by defining them in one of the later loaded files: autofood = 'Miso Ramen' for example.
--  States can be redefined as well: state.HybridMode:options('Normal','PDT') though most of these are already redefined in the gear files for editing there.
--	Commands can be added easily with: user_self_command(commandArgs, eventArgs) or user_job_self_command(commandArgs, eventArgs)
--
--	If you're not sure where is appropriate to copy and paste variables, tables and functions to make changes or add them:
--		User-Globals.lua - 			This file loads with all characters, all jobs, so it's ideal for settings and rules you want to be the same no matter what.
--		Charactername-Globals.lua -	This file loads with one character, all jobs, so it's ideal for gear settings that are usable on all jobs, but unique to this character.
--		Charactername_Job_Gear.lua-	This file loads only on one character, one job, so it's ideal for things that are specific only to that job and character.
--
--
--	If you still need help, feel free to contact me on discord or ask in my chat for help: https://discord.gg/ug6xtvQ
--  !Please do NOT message me in game about anything third party related, though you're welcome to message me there and ask me to talk on another medium.
--
--  Please do not edit this file!							Please do not edit this file!							Please do not edit this file!
-- __________.__                                ________                          __               .__.__  __      __  .__    .__           _____.__.__              
-- \______   |  |   ____ _____    ______ ____   \______ \   ____     ____   _____/  |_    ____   __| _|___/  |_  _/  |_|  |__ |__| ______ _/ ____|__|  |   ____      
--  |     ___|  | _/ __ \\__  \  /  ____/ __ \   |    |  \ /  _ \   /    \ /  _ \   __\ _/ __ \ / __ ||  \   __\ \   __|  |  \|  |/  ___/ \   __\|  |  | _/ __ \     
--  |    |   |  |_\  ___/ / __ \_\___ \\  ___/   |    `   (  <_> ) |   |  (  <_> |  |   \  ___// /_/ ||  ||  |    |  | |   Y  |  |\___ \   |  |  |  |  |_\  ___/     
--  |____|   |____/\___  (____  /____  >\___  > /_______  /\____/  |___|  /\____/|__|    \___  \____ ||__||__|    |__| |___|  |__/____  >  |__|  |__|____/\___  > /\ 
--                     \/     \/     \/     \/          \/              \/                   \/     \/                      \/        \/                      \/  \/ 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:

    ExtraSongsMode may take one of three values: None, Dummy, FullLength

    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle ExtraSongsMode
    gs c set ExtraSongsMode Dummy

    The Dummy state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.


    Simple macro to cast a dummy Daurdabla song:
    /console gs c set ExtraSongsMode Dummy
    /ma "Mage's Ballad" <me>

    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    -- Load and initialize the include file.
    include('Sel-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

    state.ExtraSongsMode = M{['description']='Extra Songs','None','Dummy','DummyLock','FullLength','FullLengthLock'}

	state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
    state.Buff['Pianissimo'] = buffactive['Pianissimo'] or false
	state.Buff['Nightingale'] = buffactive['Nightingale'] or false
	state.RecoverMode = M('35%', '60%', 'Always', 'Never')

	autows = "Rudra's Storm"
	autofood = 'Pear Crepe'
	
	state.AutoSongMode = M(false, 'Auto Song Mode')

	update_melee_groups()
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoNukeMode","AutoWSMode","AutoShadowMode","AutoFoodMode","AutoStunMode","AutoDefenseMode","AutoSongMode",},{"AutoBuffMode","AutoSambaMode","Weapons","OffenseMode","WeaponskillMode","IdleMode","Passive","RuneElement","ExtraSongsMode","CastingMode","TreasureMode",})

	SongMap =
	T{
		march = { --[["Honor March", ]]"Victory March", "Advancing March" },
		hmarch = { "Honor March" },
		prelude = { "Hunter's Prelude", "Archer's Prelude" },
		mambo = { "Dragonfoe Mambo", "Sheepfoe Mambo" },
		lcarol = { "Light Carol II", "Light Carol" },
		lcarol1 = { "Light Carol" },
		dcarol = { "Dark Carol II", "Dark Carol" },
		dcarol1 = { "Dark Carol" },
		fcarol = { "Fire Carol II", "Fire Carol" },
		fcarol1 = { "Fire Carol" },
		scarol = { "Earth Carol II", "Earth Carol" },
		scarol1 = { "Earth Carol" },
		wcarol = { "Water Carol II", "Water Carol" },
		wcarol1 = { "Water Carol" },
		acarol = { "Wind Carol II", "Wind Carol" },
		acarol1 = { "Wind Carol" },
		bcarol = { "Ice Carol II", "Ice Carol" },
		bcarol1 = { "Ice Carol" },
		tcarol = { "Lightning Carol II", "Lightning Carol" },
		tcarol1 = { "Lightning Carol" },
		mad = { "Blade Madrigal", "Sword Madrigal" },
		scherzo = { "Sentinel's Scherzo" },
		min = { "Valor Minuet V", "Valor Minuet IV", "Valor Minuet III", "Valor Minuet II", "Valor Minuet" },
		ballad = { "Mage's Ballad III", "Mage's Ballad II", "Mage's Ballad" },
		minne = { "Knight's Minne V", "Knight's Minne IV", "Knight's Minne III", "Knight's Minne II", "Knight's Minne" },
		paeon = { "Army's Paeon VI", "Army's Paeon V", "Army's Paeon IV", "Army's Paeon III", "Army's Paeon II", "Army's Paeon" },
		hymnus = { "Goddess's Hymnus" },
		mazurka = { "Chocobo Mazurka" },
		str = { "Herculean Etude", "Sinewy Etude" },
		dex = { "Uncanny Etude", "Dextrous Etude" },
		vit = { "Vital Etude", "Vivacious Etude" },
		agi = { "Swift Etude", "Quick Etude" },
		int = { "Sage Etude", "Learned Etude" },
		mnd = { "Logical Etude", "Spirited Etude" },
		chr = { "Bewitching Etude", "Enchanting Etude" },
		dirge = { "Adventurer's Dirge" },
		sirvente = { "Foe Sirvente" }
	}

	BuffMap =
	T{
		["Honor March"] = 'March', ["Victory March"] = 'March', ["Advancing March"] = 'March',
		["Hunter's Prelude"] = 'Prelude', ["Archer's Prelude"] = 'Prelude',
		["Dragonfoe Mambo"] = 'Mambo', ["Sheepfoe Mambo"] = 'Mambo',
		["Light Carol"] = 'Carol', ["Light Carol II"] = 'Carol', ["Dark Carol"] = 'Carol', ["Dark Carol II"] = 'Carol',
		["Fire Carol"] = 'Carol', ["Fire Carol II"] = 'Carol', ["Earth Carol II"] = 'Carol', ["Earth Carol II"] = 'Carol',
		["Water Carol"] = 'Carol', ["Water Carol II"] = 'Carol', ["Wind Carol"] = 'Carol', ["Wind Carol II"] = 'Carol',
		["Ice Carol"] = 'Carol', ["Ice Carol II"] = 'Carol', ["Lightning Carol"] = 'Carol', ["Lightning Carol II"] = 'Carol',
		["Blade Madrigal"] = 'Madrigal', ["Sword Madrigal"] = 'Madrigal',
		["Sentinel's Scherzo"] = 'Scherzo',
		["Valor Minuet V"] = 'Minuet', ["Valor Minuet IV"] = 'Minuet', ["Valor Minuet III"] = 'Minuet', ["Valor Minuet II"] = 'Minuet', ["Valor Minuet"] = 'Minuet',
		["Mage's Ballad III"] = 'Ballad', ["Mage's Ballad II"] = 'Ballad', ["Mage's Ballad"] = 'Ballad',
		["Knight's Minne V"] = 'Minne', ["Knight's Minne IV"] = 'Minne', ["Knight's Minne III"] = 'Minne', ["Knight's Minne II"] = 'Minne', ["Knight's Minne"] = 'Minne',
		["Army's Paeon VI"] = 'Paeon', ["Army's Paeon V"] = 'Paeon', ["Army's Paeon IV"] = 'Paeon', ["Army's Paeon III"] = 'Paeon', ["Army's Paeon II"] = 'Paeon', ["Army's Paeon"] = 'Paeon',
		["Goddess's Hymnus"] = 'Hymnus',
		["Chocobo Mazurka"] = 'Mazurka',
		["Herculean Etude"] = 'Etude', ["Sinewy Etude"] = 'Etude', ["Uncanny Etude"] = 'Etude', ["Dextrous Etude"] = 'Etude',
		["Vital Etude"] = 'Etude', ["Vivacious Etude"] = 'Etude', ["Swift Etude"] = 'Etude', ["Quick Etude"] = 'Etude',
		["Sage Etude"] = 'Etude', ["Learned Etude"] = 'Etude', ["Logical Etude"] = 'Etude', ["Spirited Etude"] = 'Etude',
		["Betwitching Etude"] = 'Etude', ["Enchanting Etude"] = 'Etude',
		["Adventurer's Dirge"] = 'Dirge',
		["Foe Sirvente"] = 'Sirvente'
	}

	TotalSongs = 2
	Songs = T{}
	NextAutoSong = 0
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.

function job_filtered_action(spell, eventArgs)
	if spell.type == 'WeaponSkill' then
		local available_ws = S(windower.ffxi.get_abilities().weapon_skills)
		-- WS 112 is Double Thrust, meaning a Spear is equipped.
		if available_ws:contains(32) then
            if spell.english == "Rudra's Storm" then
				windower.chat.input('/ws "Savage Blade" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            end
        end
	end
end

function job_pretarget(spell, spellMap, eventArgs)
    if spell.type == 'BardSong' and not spell.targets.Enemy then
		if state.Buff['Pianissimo'] and spell.target.raw == '<t>' and (player.target.type == 'NONE' or spell.target.type == 'MONSTER') then
			eventArgs.cancel = true
			windower.chat.input('/ma "'..spell.name..'" <stpt>')
		elseif spell.target.raw == '<t>' and (player.target.type == 'NONE' or player.target.type == "MONSTER") and not state.Buff['Pianissimo'] then
			change_target('<me>')
			return
		end
    end
end

function job_precast(spell, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		if not sets.precast.FC[spell.english] and (spell.type == 'BardSong' and spell.targets.Enemy) then
			classes.CustomClass = 'SongDebuff'
		end
	end
end

function job_filter_precast(spell, spellMap, eventArgs)
    if spell.type == 'BardSong' and not spell.targets.Enemy then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		
        -- Auto-Pianissimo
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC')) and spell.target.in_party and not state.Buff['Pianissimo'] then
            if spell_recasts[spell.recast_id] < 1.5 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.1; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.type == 'BardSong' then
            -- layer general gear on first, then let default handler add song-specific gear.
            local generalClass = get_song_class(spell)
			if generalClass and sets.midcast[generalClass] then
				if sets.midcast[generalClass][state.CastingMode.value] then
					equip(sets.midcast[generalClass][state.CastingMode.value])
				else
					equip(sets.midcast[generalClass])
				end
            end
        end
    end
end

function job_post_precast(spell, spellMap, eventArgs)
	if spell.type == 'BardSong' then
	
		if state.Buff['Nightingale'] then
		
			-- Replicate midcast in precast for nightingale including layering.
            local generalClass = get_song_class(spell)
			if generalClass and sets.midcast[generalClass] then
				if sets.midcast[generalClass][state.CastingMode.value] then
					equip(sets.midcast[generalClass][state.CastingMode.value])
				else 
					equip(sets.midcast[generalClass])
				end
            end

			if sets.midcast[spell.english] then
				if sets.midcast[spell.english][state.CastingMode.value] then
					equip(sets.midcast[spell.english][state.CastingMode.value])
				else
					equip(sets.midcast[spell.english])
				end
			elseif sets.midcast[get_spell_map(spell, default_spell_map)] then
				if sets.midcast[get_spell_map(spell, default_spell_map)][state.CastingMode.Value]
					then equip(sets.midcast[get_spell_map(spell, default_spell_map)][state.CastingMode.Value])
				else
					equip(sets.midcast[get_spell_map(spell, default_spell_map)])
				end
			end
			
			if not spell.targets.Enemy and state.ExtraSongsMode.value:contains('FullLength') then
				equip(sets.midcast.Daurdabla)
			end
		
		end

	elseif spell.type == 'WeaponSkill' then
		local WSset = standardize_set(get_precast_set(spell, spellMap))
		local wsacc = check_ws_acc()
		
		if (WSset.ear1 == "Moonshade Earring" or WSset.ear2 == "Moonshade Earring") then
			-- Replace Moonshade Earring if we're at cap TP
			if get_effective_player_tp(spell, WSset) > 3200 then
				if wsacc:contains('Acc') and not buffactive['Sneak Attack'] and sets.AccMaxTP then
					equip(sets.AccMaxTP[spell.english] or sets.AccMaxTP)
				elseif sets.MaxTP then
					equip(sets.MaxTP[spell.english] or sets.MaxTP)
				else
				end
			end
		end
	end
end

function job_post_midcast(spell, spellMap, eventArgs)
    if spell.type == 'BardSong' then
		if spell.targets.Enemy then
			if sets.midcast[spell.english] then
				if sets.midcast[spell.english][state.CastingMode.value] then
					equip(sets.midcast[spell.english][state.CastingMode.value])
				else
					equip(sets.midcast[spell.english])
				end
			elseif sets.midcast[spellMap] then
				if sets.midcast[spellMap][state.CastingMode.value] then
					equip(sets.midcast[spellMap][state.CastingMode.value])
				else
					equip(sets.midcast[spellMap])
				end
			end
			
			if can_dual_wield and sets.midcast.SongDebuff.DW then
				equip(sets.midcast.SongDebuff.DW)
			end
		else
			if can_dual_wield and sets.midcast.SongEffect.DW then
				equip(sets.midcast.SongEffect.DW)
			end
		end
		
		if state.ExtraSongsMode.value:contains('FullLength') then
            equip(sets.midcast.Daurdabla)
        end

        if not state.ExtraSongsMode.value:contains('Lock') then
			state.ExtraSongsMode:reset()
		end

		if state.DisplayMode.value then update_job_states()	end

    elseif spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        if state.MagicBurstMode.value ~= 'Off' then equip(sets.MagicBurst) end
		if spell.element == world.weather_element or spell.element == world.day_element then
			if state.CastingMode.value == 'Fodder' then
				if spell.element == world.day_element then
					if item_available('Zodiac Ring') then
						sets.ZodiacRing = {ring2="Zodiac Ring"}
						equip(sets.ZodiacRing)
					end
				end
			end
		end

		if spell.element == 'Wind' and sets.WindNuke then
			equip(sets.WindNuke)
		elseif spell.element == 'Ice' and sets.IceNuke then
			equip(sets.IceNuke)
		end

		if state.RecoverMode.value ~= 'Never' and (state.RecoverMode.value == 'Always' or tonumber(state.RecoverMode.value:sub(1, -2)) > player.mpp) then
			equip(sets.RecoverMP)
		end
    end
end

-- Set eventArgs.handled to true if we don't want automatic gear equipping to be done.
function job_aftercast(spell, spellMap, eventArgs)
	if spell.skill == 'Elemental Magic' and state.MagicBurstMode.value == 'Single' then
		state.MagicBurstMode:reset()
		if state.DisplayMode.value then update_job_states()	end
    end
end

function job_buff_change(buff, gain)
	update_melee_groups()
end

function job_get_spell_map(spell, default_spell_map)

	if  default_spell_map == 'Cure' or default_spell_map == 'Curaga'  then
		if world.weather_element == 'Light' then
                return 'LightWeatherCure'
		elseif world.day_element == 'Light' then
                return 'LightDayCure'
        end

	elseif spell.skill == "Enfeebling Magic" then
		if spell.english:startswith('Dia') then
			return "Dia"
		elseif spell.type == "WhiteMagic" or spell.english:startswith('Frazzle') or spell.english:startswith('Distract') then
			return 'MndEnfeebles'
		else
			return 'IntEnfeebles'
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_zone_change(new_id,old_id)
	state.AutoSongMode:reset()
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	update_melee_groups()
end


-- Modify the default idle set after it was constructed.
function job_customize_idle_set(idleSet)
    if buffactive['Sublimation: Activated'] then
        if (state.IdleMode.value == 'Normal' or state.IdleMode.value:contains('Sphere')) and sets.buff.Sublimation then
            idleSet = set_combine(idleSet, sets.buff.Sublimation)
        elseif state.IdleMode.value:contains('DT') and sets.buff.DTSublimation then
            idleSet = set_combine(idleSet, sets.buff.DTSublimation)
        end
    end

    if state.IdleMode.value == 'Normal' or state.IdleMode.value:contains('Sphere') then
		if player.mpp < 51 then
			if sets.latent_refresh then
				idleSet = set_combine(idleSet, sets.latent_refresh)
			end
			
			if (state.Weapons.value == 'None' or state.UnlockWeapons.value) and idleSet.main then
				local main_table = get_item_table(idleSet.main)

				if  main_table and main_table.skill == 12 and sets.latent_refresh_grip then
					idleSet = set_combine(idleSet, sets.latent_refresh_grip)
				end
				
				if player.tp > 10 and sets.TPEat then
					idleSet = set_combine(idleSet, sets.TPEat)
				end
			end
		end
   end

    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if spell.targets.Enemy then
		return 'SongDebuff'
    elseif state.ExtraSongsMode.value:contains('Dummy') then
        return 'DaurdablaDummy'
    else
        return 'SongEffect'
    end
end

-- Examine equipment to determine what our current TP weapon is.
function update_melee_groups()
	if player.equipment.main then
		classes.CustomMeleeGroups:clear()

		if player.equipment.main == "Carnwenhan" and state.Buff['Aftermath: Lv.3'] then
				classes.CustomMeleeGroups:append('AM')
		end
	end
end

    -- Allow jobs to override this code
function job_self_command(commandArgs, eventArgs)
	if commandArgs[1]:lower() == 'sing' then
		handle_songs(commandArgs)
		eventArgs.handled = true
	end
end

function job_tick()
	if check_auto_song() then return true end
	if check_buff() then return true end
	if check_buffup() then return true end
	return false
end

function check_auto_song()
	if not state.AutoSongMode.value then return false end
	if os.clock() < NextAutoSong then return false end

	windower.send_command('gs c sing '..info.AutoSongs)
	NextAutoSong = os.clock() + info.AutoSongDelay
	return true
end

function check_buff()
	if state.AutoBuffMode.value ~= 'Off' and not data.areas.cities:contains(world.area) then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		for i in pairs(buff_spell_lists[state.AutoBuffMode.Value]) do
			if not buffactive[buff_spell_lists[state.AutoBuffMode.Value][i].Buff] and (buff_spell_lists[state.AutoBuffMode.Value][i].When == 'Always' or (buff_spell_lists[state.AutoBuffMode.Value][i].When == 'Combat' and (player.in_combat or being_attacked)) or (buff_spell_lists[state.AutoBuffMode.Value][i].When == 'Engaged' and player.status == 'Engaged') or (buff_spell_lists[state.AutoBuffMode.Value][i].When == 'Idle' and player.status == 'Idle') or (buff_spell_lists[state.AutoBuffMode.Value][i].When == 'OutOfCombat' and not (player.in_combat or being_attacked))) and spell_recasts[buff_spell_lists[state.AutoBuffMode.Value][i].SpellID] < spell_latency and silent_can_use(buff_spell_lists[state.AutoBuffMode.Value][i].SpellID) then
				windower.chat.input('/ma "'..buff_spell_lists[state.AutoBuffMode.Value][i].Name..'" <me>')
				tickdelay = os.clock() + 2
				return true
			end
		end
	else
		return false
	end
end

function check_buffup()
	if buffup ~= '' then
		local needsbuff = false
		for i in pairs(buff_spell_lists[buffup]) do
			if not buffactive[buff_spell_lists[buffup][i].Buff] and silent_can_use(buff_spell_lists[buffup][i].SpellID) then
				needsbuff = true
				break
			end
		end
	
		if not needsbuff then
			add_to_chat(217, 'All '..buffup..' buffs are up!')
			buffup = ''
			return false
		end
		
		local spell_recasts = windower.ffxi.get_spell_recasts()
		
		for i in pairs(buff_spell_lists[buffup]) do
			if not buffactive[buff_spell_lists[buffup][i].Buff] and silent_can_use(buff_spell_lists[buffup][i].SpellID) and spell_recasts[buff_spell_lists[buffup][i].SpellID] < spell_latency then
				windower.chat.input('/ma "'..buff_spell_lists[buffup][i].Name..'" <me>')
				tickdelay = os.clock() + 2
				return true
			end
		end
		
		return false
	else
		return false
	end
end

function handle_songs(cmdParams)
	if not cmdParams[2] then
		add_to_chat(123, "Error: No songs given.")
		return
	end

	TotalSongs = 2 + info.ExtraSongs

	-- Track how many of each buff type we want so we can check for dummy songs
	-- NOTE: 
	local buffCounts =
	T{
		March = 0,
		Prelude = 0,
		Mambo = 0,
		Carol = 0,
		Madrigal = 0,
		Scherzo = 0,
		Minuet = 0,
		Ballad = 0,
		Minne = 0,
		Paeon = 0,
		Hymnus = 0,
		Mazurka = 0,
		Etude = 0
	}

	-- Reset tracking variables
	table.clear(Songs)
	local SingDummies = false
	local numSongs = 0
	local do1HR = false
	local doJA = false
	
	-- Parse song commands
	for i = 2, #cmdParams, 1 do
		if cmdParams[i]:lower() == '1hr' then
			do1HR = true
		elseif cmdParams[i]:lower() == 'ja' then
			doJA = true
		else
			if parse_song(Songs, cmdParams[i], buffCounts) then
				numSongs = numSongs + 1
			else
				add_to_chat(123, "Error: Failed to parse song")
			end
		end
	end

	if #Songs < 1 then
		add_to_chat(123, "Error: No songs given.")
		return
	end

	if doJA and not buffactive['encumberance'] and
				not buffactive['paralysis'] and
				not buffactive['amnesia'] and
				not buffactive['impairment'] and
				IsAbilityReady('Troubadour') and
				IsAbilityReady('Nightingale')
	then
		if do1HR and
			IsAbilityReady('Soul Voice') and
			IsAbilityReady('Clarion Call')
		then
			TotalSongs = TotalSongs + 1
			AddToStack(GetAbilityFromName('Troubadour'), player.name, { fixedOrder = true })
			AddToStack(GetAbilityFromName('Nightingale'), player.name, { fixedOrder = true })
			AddToStack(GetAbilityFromName('Soul Voice'), player.name, { fixedOrder = true })
			AddToStack(GetAbilityFromName('Clarion Call'), player.name, { fixedOrder = true })
		elseif IsAbilityReady('Marcato') then
			AddToStack(GetAbilityFromName('Troubadour'), player.name, { fixedOrder = true })
			AddToStack(GetAbilityFromName('Nightingale'), player.name, { fixedOrder = true })
			AddToStack(GetAbilityFromName('Marcato'), player.name, { fixedOrder = true })
		end
	end

	-- Determine if dummy songs are needed
	if numSongs > 2 then
		if alliance[1] then
			for _, partyMember in pairs(alliance[1]) do
				if type(partyMember) == 'table' and partyMember.name ~= nil and type(partyMember.mob) == 'table' and
					partyMember.mob.distance ~= nil and partyMember.mob.distance ~= 0.089004568755627 and
					partyMember.mob.distance < 100 and partyMember.buffactive ~= nil
				then
					for buff, count in pairs(buffCounts) do
						if partyMember.buffactive[buff] == nil or partyMember.buffactive[buff] < count then
							SingDummies = true
							break
						end
					end
				end
				if SingDummies then
					break
				end
			end
		end
	end

	local dummyToggle = function()
		windower.send_command('gs c set ExtraSongsMode Dummy')
		return true
	end
	local dummyReset = function()
		windower.send_command('gs c reset ExtraSongsMode')
		return true
	end

	for i = 1, numSongs do
		if i > 2 and SingDummies then
			-- Add the song with dummy toggle
			AddToStack(GetSpellFromName(Songs[i]), player.name, { partyCheck = true, dummySong = true, precastCheck = dummyToggle, aftercast = dummyReset })
		end

		AddToStack(GetSpellFromName(Songs[i]), player.name, { partyCheck = true })
	end
end

function parse_song(songs, command, counts)
	if not SongMap:containskey(command) then
		return false
	end

	for _, v in ipairs(SongMap[command]) do
		if not songs:contains(v) then
			songs:append(v)
			counts[BuffMap[v]] = counts[BuffMap[v]] + 1
			return true
		end
	end

	return false
end

buff_spell_lists = {
	Auto = {--Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
		{Name='Refresh',			Buff='Refresh',			SpellID=109,	When='Idle'},
		{Name='Phalanx',			Buff='Phalanx',			SpellID=106,	When='Idle'},
		{Name='Stoneskin',			Buff='Stoneskin',		SpellID=54,		When='Idle'},
		{Name='Blink',				Buff='Blink',			SpellID=53,		When='Idle'},
	},
	Default = {
		{Name='Refresh',			Buff='Refresh',			SpellID=109,	Reapply=false},
		{Name='Phalanx',			Buff='Phalanx',			SpellID=106,	Reapply=false},
		{Name='Stoneskin',			Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',				Buff='Blink',			SpellID=53,		Reapply=false},
	},
}
