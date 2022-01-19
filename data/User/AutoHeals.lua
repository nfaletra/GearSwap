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
function user_setup()
	state.AutoCureMode = M{'Off','Party','Ally'}
	state.AllianceCureMode = M{'Off','Top','Bottom','All'}

	-- Maximum hp percent for cures
	curethreshold = 70
end

function user_tick()
	if state.AutoCureMode.value == 'Off' then return false end

	-- Store off party members that need healing
	local SortedParty = {}
	local PlayersCurrentHP = {}
	for _, v in pairs(alliance[1]) do
		if type(v) == 'table' then
			if v.hpp <= curethreshold then
				table.insert(SortedParty, v)
				PlayersCurrentHP[v.name] = v.hp / (v.hpp / 100) - v.hp
			end
		end
	end

	-- If >= 3 targets need healing, see if they're all in range of a curaga
	local canCuraga = false
	if table.getn(SortedParty) >= 3 then
		-- Find the centroid of the players
		local Centroid = Vector3()
		for _, v in pairs(SortedParty) do
			Centroid = Centroid + Vector3(v.x, v.y, v.z)
		end
		
		-- Divide by number of players needing heals to get the average position
		Centroid = Centroid / healCount

		-- Use the player closest to the average position as our cure target
		local cureTarget = nil
		local closestDistSq = 75 * 75 -- Use a large-ish number for our max distance. Anything outside 50 yalms isn't loaded anyway.
		for _, v in pairs(SortedParty) do
			local ToCentroid = Centroid - Vector3(v.x, v.y, v.z)
			local distSq = ToCentroid:SizeSq()
			if distSq < closestDistSq then
				closestDistSq = distSq
				cureTarget = v
			end
		end

		-- If at least 2 other players are in range of our cure target, we can use a curaga
		if cureTarget then
			local PlayersInRange = {}
			local lowestHP = 0
			for _, v in pairs(SortedParty) do
				if cureTarget ~= v then
					local ToPlayer = Vector3(v.x, v.y, v.z) - Vector3(cureTarget.x, cureTarget.y, cureTarget.z)
					if ToPlayer:SizeSq() <= (15 * 15) then -- Curaga AoE Range (is this in resources somewhere?)
						table.insert(PlayersInRange, v)
						if PlayersCurrentHP[v.name] < lowestHP then
							lowestHP = PlayersCurrentHP[v.name]
						end
					end
				end
			end

			canCuraga = table.getn(PlayersInRange) >= 2
		end
	end

	if canCuraga then
		add_cure(cureTarget, lowestHP, canCuraga)
	else
		-- Queue up cures for everyone
		for _, v in pairs(SortedParty) do
			add_cure(v, PlayersMissingHP[v.name])
		end
	end

	local playerDebuffs = {}

	-- Attempt to heal other alliance parties
	if state.AllianceCureMode.value == 'Top' or state.AllianceCureMode.value == 'All' then
		for k, v in pairs(alliance[2]) do
		end
	end

	if state.AllianceCureMode.value == 'Bottom' or state.AllianceCureMode.value == 'All' then
		for k, v in pairs(alliance[3]) do
		end
	end

	-- return false to allow more tick functions to run
	return false
end

function party_buff_change(affectedPlayer, buffName, gain)
end

function add_cure(cureTarget, missingHP, useCuraga)
	if missingHP < 250 then -- Prioritize Tier 1
		if spell_recasts[1] < spell_latency then
			-- Add Cure to stack for target
		elseif spell_recasts[2] < spell_latency then
			-- Add Cure II to stack for target
		end
	elseif missingHP < 400 then -- Prioritize Tier 2
		if spell_recasts[2] < spell_latency then
			-- Add Cure II to stack for target
		elseif spell_recasts[3] < spell_latency then
			-- Add Cure III to stack for target
		elseif spell_recasts[1] < spell_latency then
			-- Add Cure to stack for target
		end
	elseif missingHP < 1200 then -- Prioritize Tier 3
		if spell_recasts[3] < spell_latency then
			-- Add Cure III to stack for target
		elseif spell_recasts[4] < spell_latency then
			-- Add Cure IV to stack for target
		elseif spell_recasts[5] < spell_latency then
			-- Add Cure V to stack for target
		end
	elseif missingHP < 2000 then -- Prioritize Tier 5
		if spell_recasts[5] < spell_latency then
			-- Add Cure V to stack for target
		elseif spell_recasts[4] < spell_latency then
			-- Add Cure IV to stack for target
		elseif spell_recasts[6] < spell_latency then
			-- Add Cure VI to stack for target
		elseif spell_recasts[3] < spell_latency then
			-- Add Cure III to stack for target
		end
	else
		if spell_recasts[6] < spell_latency then
			-- Add Cure VI to stack for target
		elseif spell_recasts[5] < spell_latency then
			-- Add Cure V to stack for target
		elseif spell_recasts[4] < spell_latency then
			-- Add Cure IV to stack for target
		elseif spell_recasts[3] < spell_latency then
			-- Add Cure III to stack for target
		end
	end
end