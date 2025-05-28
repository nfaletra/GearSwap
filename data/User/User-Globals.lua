--Place for your settings and custom functions that are meant to affect all of your jobs and characters.
latency = .25
--If this is set to true it will prevent you from casting shadows when you have more up than that spell would generate.
conserveshadows = false
--Display related settings.

--Options for automation.
state.ReEquip 		  		= M(true, 'ReEquip Mode')		 --Set this to false if you don't want to equip your current Weapon set when you aren't wearing any weapons.
state.AutoArts 		  		= M(true, 'AutoArts') 		 --Set this to false if you don't want to automatically try to keep up Solace/Arts.
state.AutoLockstyle	 	    = M(true, 'AutoLockstyle Mode') --Set this to false if you don't want gearswap to automatically lockstyle on load and weapon change.
state.CancelStoneskin 		= M(true, 'Cancel Stone Skin') --Set this to false if you don't want to automatically cancel stoneskin when you're slept.
state.SkipProcWeapons 		= M(true, 'Skip Proc Weapons') --Set this to false if you want to display weapon sets fulltime rather than just Aby/Voidwatch.
state.NotifyBuffs	  		= M(false, 'Notify Buffs') 	 --Set this to true if you want to notify your party when you recieve a specific buff/debuff. (List Below)

--[[Binds you may want to change.
	Bind special characters.
	@ = Windows Key
	% = Works only when text bar not up.
	$ = Works only when text bar is up.
	^ = Control Key
	! = Alt Key
	~ = Shift Key
	# = Apps Key
]]
send_command('bind !@^f7 gs c toggle AutoWSMode') --Turns auto-ws mode on and off.
send_command('bind !^f7 gs c toggle AutoFoodMode') --Turns auto-ws mode on and off.
send_command('bind f7 gs c cycle Weapons') --Cycle through weapons sets.
send_command('bind @f8 gs c toggle AutoNukeMode') --Turns auto-nuke mode on and off.
send_command('bind ^f8 gs c toggle AutoStunMode') --Turns auto-stun mode off and on.
send_command('bind !f8 gs c toggle AutoDefenseMode') --Turns auto-defense mode off and on.
send_command('bind ^@!f8 gs c toggle AutoTrustMode') --Summons trusts automatically.
send_command('bind @pause gs c cycle AutoBuffMode') --Automatically keeps certain buffs up, job-dependant.
send_command('bind @scrolllock gs c cycle Passive') --Changes offense settings such as accuracy.
send_command('bind f9 gs c cycle OffenseMode') --Changes offense settings such as accuracy.
send_command('bind ^f9 gs c cycle HybridMode') --Changes defense settings for melee such as PDT.
send_command('bind @f9 gs c cycle RangedMode') --Changes ranged offense settings such as accuracy.
send_command('bind !f9 gs c cycle WeaponskillMode') --Changes weaponskill offense settings such as accuracy.
send_command('bind f10 gs c set DefenseMode Physical') --Turns your physical defense set on.
send_command('bind ^f10 gs c cycle PhysicalDefenseMode') --Changes your physical defense set.
send_command('bind !f10 gs c toggle Kiting') --Keeps your kiting gear on..
send_command('bind f11 gs c set DefenseMode Magical') --Turns your magical defense set on.
send_command('bind ^f11 gs c cycle MagicalDefenseMode') --Changes your magical defense set.
send_command('bind @f11 gs c cycle CastingMode') --Changes your castingmode options such as magic accuracy.
send_command('bind !f11 gs c cycle ExtraMeleeMode') --Adds another set layered on top of your engaged set.
send_command('bind ^f12 gs c cycle ResistDefenseMode') --Changes your resist defense set.
send_command('bind f12 gs c set DefenseMode Resist') --Turns your resist defense set on.
send_command('bind @f12 gs c cycle IdleMode') --Changes your idle mode options such as refresh.
send_command('bind !f12 gs c reset DefenseMode') --Turns your defensive mode off.
send_command('bind ^@!f12 gs reload') --Reloads gearswap.
send_command('bind pause gs c update user') --Runs a quick check to make sure you have the right gear on and checks variables.
send_command('bind ^@!pause gs org') --Runs organizer.
send_command('bind ^@!backspace gs c buffup') --Buffup macro because buffs are love.
send_command('bind ^z gs c toggle Capacity') --Keeps capacity mantle on and uses capacity rings.
send_command('bind ^y gs c toggle AutoCleanupMode') --Uses certain items and tries to clean up inventory.
send_command('bind ^t gs c cycle treasuremode') --Toggles hitting htings with your treasure hunter set.
send_command('bind !t input /target <bt>') --Targets the battle target.
send_command('bind ^o fillmode') --Lets you see through walls.
send_command('bind @m gs c mount Ixion')

NotifyBuffs = S{'doom','petrification'}

-- Haste tiers
totalhaste = 0
function calc_haste()
	totalhaste = 0
	
	if buffactive[33] then -- Haste Spell
		if lasthaste == 2 then
			totalhaste = 30
		else
			totalhaste = 15
		end
	end

	if buffactive[580] then -- Indi/Geo Haste
		totalhaste = totalhaste + 30
	end

	if buffactive['March'] then
		if buffactive['March'] > 1 then
			totalhaste = totalhaste + 45
		elseif buffactive['March'] > 0 then
			totalhaste = totalhaste + 15
		end
	end

	if buffactive['Mighty Guard'] then
		totalhaste = totalhaste + 15
	end
end

function user_job_buff_change(buff, gain, eventArgs)
	if totalhaste then
		if totalhaste < 15 then
			classes.CustomMeleeGroups:append('Haste0')
		elseif totalhaste < 30 then
			classes.CustomMeleeGroups:append('Haste15')
		elseif totalhaste < 45 then
			classes.CustomMeleeGroups:append('Haste30')
		else
			-- Haste 45 or more, intentionally empty
		end
	end
end

function user_setup()
	cure2_threshold = 300
	cure3_threshold = 500
	cure4_threshold = 1000
	cure5_threshold = 1500
	cure6_threshold = 3000

	function handle_smartcure(cmdParams)
		if cmdParams[1] then
			if tonumber(cmdParams[1]) then
				cureTarget = windower.ffxi.get_mob_by_id(tonumber(cmdParams[1]))
			else
				cureTarget = table.concat(cmdParams, ' ')
				cureTarget = windower.ffxi.get_mob_by_target(cureTarget)
				if not cureTarget or not cureTarget.name then cureTarget = player.target end
				if not cureTarget or not cureTarget.name then cureTarget = player end
			end
		elseif player.target.type == "SELF" or player.target.type == 'MONSTER' or player.target.type == 'NONE' then
			cureTarget = player
		else
			cureTarget = player.target
		end

		if cureTarget.status == 2 or cureTarget.status == 3 then
			windower.chat.input('/ma "Arise" '..cureTarget..'')
			return
		end
		
		local missingHP = nil
		local spell_recasts = windower.ffxi.get_spell_recasts()

		if cureTarget.type == 'MONSTER' then
			if silent_can_use(4) and spell_recasts[4] < spell_latency then
				windower.chat.input('/ma "Cure IV" '..cureTarget.id..'')
			elseif spell_recasts[3] < spell_latency then
				windower.chat.input('/ma "Cure III" '..cureTarget.id..'')
			elseif spell_recasts[2] < spell_latency then
				windower.chat.input('/ma "Cure II" '..cureTarget.id..'')
			else
				add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
			end
		elseif cureTarget.in_alliance then
			cureTarget.hp = find_player_in_alliance(cureTarget.name).hp
			local est_max_hp = cureTarget.hp / (cureTarget.hpp / 100)
			missingHP = math.floor(est_max_hp - cureTarget.hp)
		else
			local est_current_hp = 2000 * (cureTarget.hpp / 100)
			missingHP = math.floor(2000 - est_current_hp)
		end

		if missingHP then
			if missingHP < cure2_threshold and spell_recasts[1] then
				if spell_recasts[1] < spell_latency then
					windower.chat.input('/ma "Cure" '..cureTarget.id..'')
				elseif spell_recasts[2] and spell_recasts[2] < spell_latency then
					windower.chat.input('/ma "Cure II" '..cureTarget.id..'')
				else
					add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
				end
			elseif missingHP < cure3_threshold and spell_recasts[2] then
				if spell_recasts[2] < spell_latency then
					windower.chat.input('/ma "Cure II" '..cureTarget.id..'')
				elseif spell_recassts[3] and spell_recasts[3] < spell_latency then
					windower.chat.input('/ma "Cure III" '..cureTarget.id..'')
				elseif spell_recasts[1] < spell_latency then
					windower.chat.input('/ma "Cure" '..cureTarget.id..'')
				else
					add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
				end
			elseif missingHP < cure4_threshold and spell_recasts[3] then
				if spell_recasts[3] < spell_latency then
					windower.chat.input('/ma "Cure III" '..cureTarget.id..'')
				elseif spell_recasts[4] and spell_recasts[4] < spell_latency then
					windower.chat.input('/ma "Cure IV" '..cureTarget.id..'')
				else
					add_to_chat(123, 'Abort: Appropriate cures are on cooldown.')
				end
			elseif missingHP < cure5_threshold and spell_recasts[4] then
				if spell_recasts[4] < spell_latency then
					windower.chat.input('/ma "Cure IV" '..cureTarget.id..'')
				elseif spell_recasts[3] < spell_latency then
					windower.chat.input('/ma "Cure III" '..cureTarget.id..'')
				elseif spell_recasts[5] and spell_recasts[5] < spell_latency then
					windower.chat.input('/ma "Cure V" '..cureTarget.id..'')
				else
					add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
				end
			elseif missingHP < cure6_threshold and spell_recasts[5] then
				if spell_recasts[5] < spell_latency then
					windower.chat.input('/ma "Cure V" '..cureTarget.id..'')
				elseif spell_recasts[4] < spell_latency then
					windower.chat.input('/ma "Cure IV" '..cureTarget.id..'')
				elseif spell_recasts[6] and spell_recasts[6] < spell_latency then
					windower.chat.input('/ma "Cure VI" '..cureTarget.id..'')
				elseif spell_recasts[3] < spell_latency then
					windower.chat.input('/ma "Cure III" '..cureTarget.id..'')
				else
					add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
				end
			else
				if spell_recasts[6] and spell_recasts[6] < spell_latency then
					windower.chat.input('/ma "Cure VI" '..cureTarget.id..'')
				elseif spell_recasts[5] and spell_recasts[5] < spell_latency then
					windower.chat.input('/ma "Cure V" '..cureTarget.id..'')
				elseif spell_recasts[4] and spell_recasts[4] < spell_latency then
					windower.chat.input('/ma "Cure IV" '..cureTarget.id..'')
				elseif spell_recasts[3] and spell_recasts[3] < spell_latency then
					windower.chat.input('/ma "Cure III" '..cureTarget.id..'')
				else
					add_to_chat(123,'Abort: Appropriate cures are on cooldown.')
				end
			end
		end
	end
end