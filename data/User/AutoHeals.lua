-- Handles ticking for automated healing and status removal
-- Include in WHM, SCH, BRD, RDM, GEO files

----------------------------------------------------------------------------------
-- Logic flow
--
-- Prioritize Party
-- Track all party HPP
-- Prioritize status heals over cures at certain HPP thresholds (per status type, e.g. doom removal should be priority over most cures)
-- Use Divine Seal if more than 1 party member shares same status
-- If >= 3 party members are below cure threshold and are within AoE range of each other, Curaga (tier based on most hp missing)
-- If < 3 party members are below cure threshold, prioritize cures by lowest HPP (TODO: weight by hpp, missing hp, job, weakened)
----------------------------------------------------------------------------------
include('Vector3.lua')

function user_setup()
	-- Maximum hp percent for cures
	cure_threshold = 70
	cure_tick_delay = 1 / 30 -- 30 fps
	cure_last_tick = os.clock()

	cures =
	L{
		'Cure',
		'Cure II',
		'Cure III',
		'Cure IV',
		'Cure V',
	}

	curagas =
	L{
		'Curaga',
		'Curaga II',
		'Curaga III',
		'Curaga IV',
	}
end

function user_self_command(commandArgs, eventArgs)
	if commandArgs[1]:lower() == 'curethreshold' then
		cure_threshold = tonumber(commandArgs[2])
		add_to_chat(122, "Cure Threshold set to: "..cure_threshold.."%.")
		eventArgs.handled = true
	elseif commandArgs[1]:lower() == 'tickdelay' then
		cure_tick_delay = tonumber(commandArgs[2])
		add_to_chat(122, "Tick Delay set to: "..cure_tick_delay..".")
		eventArgs.handled = true
	end
end

function user_tick()
	if cure_tick() then return true end

	return false
end

function cure_tick()
	-- Cure Tick
	if state.AutoCureMode.value ~= 'Off' then
		if (os.clock() - cure_last_tick) >= cure_tick_delay then
			cure_last_tick = os.clock()

			-- Store off party members that need healing
			local SortedParty = T{}
			local PlayersCurrentHP = T{}
			local players = table.copy(alliance[1])
			if state.AllianceCureMode.value == 'Top' or state.AllianceCureMode.value == 'All' then
				table.insert(players, table.copy(alliance[2]))
			end
			if state.AllianceCureMode.value == 'Bottom' or state.AllianceCureMode.value == 'All' then
				table.insert(players, table.copy(alliance[3]))
			end

			for _, v in pairs(players) do
				if type(v) == 'table' then
					if v.hpp <= cure_threshold then
						table.insert(SortedParty, v)
						PlayersCurrentHP[v.name] = v.hp / (v.hpp / 100) - v.hp
					end
				end
			end

			-- If >= 3 targets need healing, see if they're all in range of a curaga
			if #SortedParty >= 3 then
				-- Find the centroid of the players
				local Centroid = Vector3(0, 0, 0)
				local healCount = 0
				for _, v in pairs(SortedParty) do
					if v.in_party then
						Centroid = Centroid + Vector3(v.x, v.y, v.z)
						healCount = healCount + 1
					end
				end

				-- Divide by number of players needing heals to get the average position
				if healCount >= 1 then
					Centroid = Centroid / healCount

					-- Use the player closest to the average position as our cure target
					local cureTarget = nil
					local closestDistSq = 5000 -- Use a large-ish number for our max distance. Anything outside 50 yalms isn't loaded anyway.
					for _, v in pairs(SortedParty) do
						if v.in_party then
							local ToCentroid = Centroid - Vector3(v.x, v.y, v.z)
							local distSq = ToCentroid:SizeSq()
							if distSq < closestDistSq then
								closestDistSq = distSq
								cureTarget = v
							end
						end
					end

					-- If at least 2 other players are in range of our cure target, we can use a curaga
					if cureTarget then
						local playersInRange = 0
						local lowestHP = 10000 -- Start at an impossible amount of hp
						for _, v in pairs(SortedParty) do
							if v.in_party then
								if cureTarget ~= v then
									local ToPlayer = Vector3(v.x, v.y, v.z) - Vector3(cureTarget.x, cureTarget.y, cureTarget.z)
									if ToPlayer:SizeSq() <= math.pow(15, 2) then
										playersInRange = playersInRange + 1
										if PlayersCurrentHP[v.name] < lowestHP then
											lowestHP = PlayersCurrentHP[v.name]
										end
									end
								end
							end
						end

						if playersInRange >= 2 then
							do_cure(cureTarget, lowestHP, true)
							return true
						end
					end
				end
			end

			-- Cure lowest hp party member
			local cureTarget = nil
			local lowestHP = 10000 -- Start at an impossible amount of hp
			for _, v in pairs(SortedParty) do
				if PlayersCurrentHP[v.name] and PlayersCurrentHP[v.name] < lowestHP then
					lowestHP = PlayersCurrentHP[v.name]
					cureTarget = v
				end
			end

			if cureTarget then
				do_cure(cureTarget, lowestHP)
				return true
			end
		end
	end

	-- return false to allow more tick functions to run
	return false
end

function party_buff_change(affectedPlayer, buffName, gain)
end

function do_cure(cureTarget, missingHP, useCuraga)
	local cureTier = 1
	local spell_recasts = windower.ffxi.get_spell_recasts()
	if missingHP < 250 then -- Prioritize Tier 1
		if spell_recasts[2] and spell_recasts[2] < spell_latency then
			cureTier = 2
		end
	elseif missingHP < 400 then -- Prioritize Tier 2
		if spell_recasts[2] and spell_recasts[2] < spell_latency then
			cureTier = 2
		elseif spell_recasts[3] and spell_recasts[3] < spell_latency then
			cureTier = 3
		end
	elseif missingHP < 1200 then -- Prioritize Tier 3
		if spell_recasts[3] and  spell_recasts[3] < spell_latency then
			cureTier = 3
		elseif spell_recasts[4] and spell_recasts[4] < spell_latency then
			cureTier = 4
		elseif spell_recasts[5] and spell_recasts[5] < spell_latency then
			cureTier = 5
		else
			cureTier = 2
		end
	elseif missingHP < 2000 then -- Prioritize Tier 5
		if spell_recasts[4] and spell_recasts[4] < spell_latency then
			cureTier = 4
		elseif spell_recasts[5] and spell_recasts[5] < spell_latency then
			cureTier = 5
		elseif spell_recasts[3] and spell_recasts[3] < spell_latency then
			cureTier = 3
		end
	else
		if spell_recasts[5] and spell_recasts[5] < spell_latency then
			cureTier = 5
		elseif spell_recasts[4] and spell_recasts[4] < spell_latency then
			cureTier = 4
		elseif spell_recasts[3] and spell_recasts[3] < spell_latency then
			cureTier = 3
		end
	end

	if useCuraga then
		windower.chat.input('/ma "'..curagas[math.max(1, cureTier - 1)]..'" '..cureTarget.name)
	else
		windower.chat.input('/ma "'..cures[cureTier]..'" '..cureTarget.name)
	end

	tickdelay = os.clock() + 2
end