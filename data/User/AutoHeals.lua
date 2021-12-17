-- Handles ticking for automated healing and status removal
-- Include in WHM, SCH, BRD, RDM files
function user_setup()
	state.AutoCureMode = M{'Off','Party','Ally'}
	state.AllianceCureMode = M{'Off','Top','Bottom','All'}
end

function user_tick()
	if not state.AutoCureMode.value == 'Off' then return false end

	local playerMissingHP = {}
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