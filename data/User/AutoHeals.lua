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
	local healCount = 0
	for k, v in pairs(alliance[1]) do
		if type(v) == 'table' then
			if v.hpp <= curethreshold then
				table.insert(SortedParty, v)
				healCount = healCount + 1
			end
		end
	end

	-- Sort by lowest HP Percent
	table.sort(SortedParty, function(a, b) return a.hpp < b.hpp end)

	-- If >= 3 targets need healing, see if they're all in range of a curaga
	local canCuraga = false
	if healCount >= 3 then
		-- Find the average position of the players
		for _, v in ipairs(SortedParty) do

		end
	end

	-- Calculate how much hp is missing
	local playerMissingHP = {}
	for _, v in ipairs(SortedParty) do
		-- Store off missing hp by name
		playerMissingHP[v.name] = v.hp / (v.hpp / 100) - v.hp
		if v.hpp <= curethreshold then
			healCount = v + 1
		end
	end

	

	
	local playerDebuffs = {}

	-- Prioritize local party healing
	for k, v in pairs(alliance[1]) do
		if type(v) == 'table' then
			if v.name == player.name then
				healerKey = k
			end

			if v.hp ~= nil and v.hp > 0 then
				playerMissingHP[v.name] = v.hp / (v.hpp / 100) - v.hp
			end
		end
	end

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

function add_cure(cureTarget)
	local missingHP = cureTarget.hp / (cureTaget.hpp / 100) - cureTarget.hp
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