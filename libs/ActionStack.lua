-- Setup the Action Stack output window
windower.text.create('StackOutput')
windower.text.set_bg_color('StackOutput', 255, 0, 0, 0)
windower.text.set_color('StackOutput', 255, 255, 255, 255)
windower.text.set_font('StackOutput', 'fixedsys', 'consolas', 'courier new', 'monospace')
windower.text.set_font_size('StackOutput', 10)
windower.text.set_text('StackOutput', '')
windower.text.set_visibility('StackOutput', true)
windower.text.set_bg_visibility('StackOutput', true)
windower.text.set_location('StackOutput', 500, 500)

-- Some default variables
local CurablePlayers = {}
local PlayerPriorities = {}
local IgnoreBuffWear = false
local LastRemovedSpell = {}
local OutputMaxLines = 10
local LastValue = 0
local HealerID = 0

-- Cure Thresholds
local Curaga2Threshold = 400
local Curaga3Threshold = 800
local Curaga4Threshold = 1000
local Curaga5Threshold = 1500

local Cure3Threshold = 350
local Cure4Threshold = 850
local Cure5Threshold = 1100
local Cure6Threshold = 1400

info.CastSpeed = 1.0
local RangedDelay = 168
local AutoStrat = true

local Distances =
{
	[2] = 4 * 4,
	[3] = 5 * 5,
	[4] = 6.2 * 6.2,
	[5] = 7.5 * 7.5,
	[6] = 7.8 * 7.8,
	[7] = 8.8 * 8.8,
	[8] = 11 * 11,
	[9] = 13 * 13,
	[10] = 15 * 15,
	[11] = 16.6 * 16.6,
	[12] = 21 * 21
}

-- Helper functions
function GetSpellFromName(spellName)
	for i, v in pairs(gearswap.res.spells) do
		if v.en and v.en == spellName then
			return v
		end
	end

	return nil
end

local NaSpellMap =
{
	sleep = GetSpellFromName('Curaga'),
	silence = GetSpellFromName('Silena'),
	paralysis = GetSpellFromName('Paralyna'),
	plague = GetSpellFromName('Viruna'),
	poison = GetSpellFromName('Poisona'),
	blindness = GetSpellFromName('Blindna'),
	doom = GetSpellFromName('Cursna'),
	curse = GetSpellFromName('Cursna'),
	petrification = GetSpellFromName('Stona')
}

local InverseNaSpellMap =
{
	Curaga = { 'sleep' },
	Silena = { 'silence' },
	Paralyna = { 'paralysis' },
	Viruna = { 'plague' },
	Poisona = { 'poison' },
	Blindna = { 'blindness' },
	Cursna = { 'doom', 'curse' },
	Stona =  { 'petrification' }
}

local Eraseables =
T{
	'elegy', 'requiem', 'bind', 'weight', 'bio', 'dia', 'slow', 'max hp down', 'max mp down',
	'str down', 'dex down', 'vit down', 'agi down', 'int down', 'mnd down', 'chr down',
	'attack down', 'accuracy down', 'defense down', 'magic def. down', 'magic atk. down', 'evasion down', 'magic acc. down', 'magic evasion down',
	'burn', 'frost', 'choke', 'rasp', 'shock', 'drown'
}

local LastStatus = {}
for k, v in pairs(NaSpellMap) do
	LastStatus[k] = 0
end
LastStatus['Sacrifice'] = 0
LastStatus['Erase'] = 0

local MaxStratagems = 2
local StratagemRecast = 120

if player.main_job == 'SCH' then
	MaxStratagems = 5
	local schJPData = windower.ffxi.get_player().job_points.sch.jp_spent
	if schJPData >= 550 then
		StratagemRecast = 33
	else
		StratagemRecast = 48
	end
elseif player.sub_job == 'SCH' and player.sub_job_level >= 50 then
	MaxStratagems = 3
	StratagemRecast = 80
end

function user_unload()
	windower.text.delete('StackOutput')
end

local ActionStack = T{}
local PartyData = windower.ffxi.get_party()

function IsSpellReady(spellName)
	local spellRecasts = windower.ffxi.get_spell_recasts()
	local spell = GetSpellFromName(spellName)
	return spell and spellRecasts[spell.recast_id] and spellRecasts[spell.recast_id] < spell_latency and player.mp >= spell.mp_cost
end

function GetAbilityFromName(abilityName)
	for i, v in pairs(gearswap.res.job_abilities) do
		if v.en and v.en == abilityName then
			return v
		end
	end

	return nil
end

function IsAbilityReady(abilityName)
	local abilityRecasts = windower.ffxi.get_ability_recasts()
	local ability = GetAbilityFromName(abilityName)
	return ability and abilityRecasts[ability.recast_id] and abilityRecasts[ability.recast_id] < latency
end

function GetWSFromName(wsName)
	for i, v in pairs(gearswap.res.weapon_skills) do
		if v.en and v.en == wsName then
			return v
		end
	end

	return nil
end

function CountStratagemsReady()
	if AutoStrat and GetAbilityFromName['Addendum: White'] then
		local recastTime = windower.ffxi.get_ability_recasts()[GetAbilityFromName['Addendum: White'].recast_id]
		if recastTime > MaxStratagemTime then
			return 0
		else
			return MaxStratagems - math.ceil(recastTime / StratagemRecast)
		end

		return 0
	end
end

function IsStratagemReady(stratagemName)
	local stratagem = GetAbilityFromName(stratagemName)
	if stratagem and windower.ffxi.get_ability_recasts()[stratagem.recast_id] <= MaxStratagemTime then
		return true
	end

	return false
end

function CheckTargetExists(action, actionTarget)
	local mob = nil

	if actionTarget == 't' then
		mob = windower.ffxi.get_mob_by_target('t')
	else
		mob = windower.ffxi.get_mob_by_id(actionTarget)
	end

	if not mob or type(mob) ~= 'table' or not mob.distance then
		return false
	end

	if action and action.range then
		if Distances[action.range] and mob.distance > Distances[action.range] then
			return false
		end
	end

	if mob.distance == 0.089004568755627 then
		return false
	end

	if mob.hpp == 0 then
		return false
	end

	if not mob.valid_target then
		return false
	end

	if mob.in_party then
		return false
	end

	if mob.in_alliance then
		return false
	end

	if not mob.is_npc then
		return false
	end

	if mob.charmed then
		return false
	end

	return true
end

function GetCurePriority(hp)
	hp = 100 - tonumber(hp)
	local priority = 0
	if hp == 0 or hp > 85 then
		priority = 0
	else
		priority = (0.0007 * hp * hp * hp * hp) + (0.0028 * hp * hp * hp) + (0.707 * hp * hp) + (2.7944 * hp) + 97.323
	end

	return priority
end

function PartyDistances()
	for ai, av in pairs(alliance) do
		if type(av) == 'table' then
			for i, v in pairs(av) do
				if type(v) == 'table' and v.name then
					if v.buffactive then
						CurablePlayers[v.name] = true
					else
						CurablePlayers[v.name] = false
					end

					if not PlayerPriorities[v.name] then
						PlayerPriorities[v.name] = 1
					end

					if type(v.mob) == 'table' then
						if not v.mob.distance then
							local x = tonumber(v.mob.x) - tonumber(player.mob.x)
							local y = tonumber(v.mob.y) - tonumber(player.mob.y)
							v.mob.distance = math.sqrt(x * x + y * y)
						end
					end
				end
			end
		end
	end
end

PartyDistances()

function CanStatusHeal()
	return (player.main_job == 'WHM' or player.sub_job == 'WHM') or
		((player.main_job == 'SCH' or player.sub_job == 'SCH') and buffactive['Addendum: White'])
end

function ShouldBuff()
	return S{ 'WHM', 'SCH', 'RDM' }:contains(player.main_job)
end

function party_buff_change(affectedPlayer, buffName, gain)
	if state.StatusCureMode.value == 'Off' then return false end
	if not affectedPlayer.buffactive or affectedPlayer.buffactive.charm then
		return false
	end

	buffName = buffName:lower()
	if gain and CanStatusHeal() then
		if NaSpellMap[buffName] and os.clock() - LastStatus[buffName] > 15 then
			AddToStack(NaSpellMap[buffName], affectedPlayer.name,
			{
				partyCheck = true,
				precastCheck = function(this)
					if os.clock() - this.addedAt < 1.5 then
						return true
					end
					if InverseNaSpellMap[this.spell.english] and CheckPlayerForBuff(this.target, InverseNaSpellMap[this.spell.english]) then
						return true
					end

					return 'remove'
				end,
			})
		end

		local erasesNeeded = 0
		for _, v in pairs(eraseables) do
			if buffName == v then
				erasesNeeded = erasesNeeded + 1
			end
		end

		if player.main_job == 'WHM' and erasesNeeded > 1 and os.clock() - LastStatus['Sacrifice'] > 15 then
			AddToStack(GetSpellFromName('Sacrifice'), affectedPlayer.name, { partyCheck = true })
			LastStatus['Sacrifice'] = os.clock()
		elseif erasesNeeded >= 1 and os.clock() - LastStatus['Erase'] > 15 then
			AddToStack(GetSpellFromName('Erase'), affectedPlayer.name, { partyCheck = true })
			LastStatus['Erase'] = os.clock()
		end
	elseif not gain and affectedPlayer.hp > 0 and CanStatusHeal() and NaSpellMap[buffName] then
		RebuildArray(NaSpellMap[buffName], affectedPlayer.name)
	elseif not gain and not buffactive['weakness'] and not IgnoreBuffWear and affectedPlayer.hp > 0 and ShouldBuff() then
		if buffName == 'protect' then
			if player.main_job == 'WHM' and CheckAoERange(affectedPlayer.name) then
				AddToStack(GetSpellFromName('Protectra V'), player.name, { partyCheck = true })
			else
				AddToStack(GetSpellFromName('Protect V'), affectedPlayer.name, { partyCheck = true })
			end
		end

		if buffName == 'shell' then
			if player.main_job == 'WHM' and CheckAoERange(affectedPlayer.name) then
				AddToStack(GetSpellFromName('Shellra V'), player.name, { partyCheck = true })
			else
				AddToStack(GetSpellFromName('Shell V'), affectedPlayer.name, { partyCheck = true })
			end
		end

		if buffName == 'haste' then
			if player.main_job == 'RDM' then
				AddToStack(GetSpellFromName('Haste II'), affectedPlayer.name, { partyCheck = true })
			else
				AddToStack(GetSpellFromName('Haste'), affectedPlayer.name, { partyCheck = true })
			end
		end
	end
end

function GetPlayerBuffsFromAlliance(targetName)
	if alliance then
		for _, v in pairs(alliance) do
			if type(v) == 'table' then
				for __, vv in pairs(v) do
					if type(vv) == 'table' and vv.name and vv.name == targetName and vv.buffactive then
						return vv.buffactive
					end
				end
			end
		end
	end

	return {}
end

function CheckPlayerForBuff(playerName, buffTable)
	local playerBuffs = GetPlayerBuffsFromAlliance(playerName)
	if not playerBuffs then return false end

	if type(buffTable) ~= 'table' then buffTable = { buffTable } end

	for _, v in pairs(buffTable) do
		if playerBuffs[v] then
			return true
		end
	end

	return false
end

function IsSpellTargetingCharmedPlayer(spell)
	if spell.targets and type(spell.target) == 'table' and spell.targets.Enemy then
		return false
	end

	return CheckPlayerForBuff(spell.target, 'charm')
end

function CureProcess()
	ClearCures()
	local curagaCount = 0
	local biggestCuragaWeight = 0
	local biggestCuragaIndex = 0
	local bestCuragaTier = 0
	local biggestCureWeight = 0
	local biggestCureIndex = 0

	-- Calculate missing hp
	for k, v in pairs(PartyData) do
		if type(v) == 'table' then
			if v.name == player.name then
				HealerID = k
			end
			if v.hp and v.hp > 0 then
				v.healNeeded = v.hp / (v.hpp / 100) - v.hp
			end
		end
	end

	-- Calculate cure/curaga weights
	for k, v in pairs(PartyData) do
		if type(v) == 'table' and v.name then
			local curagaWeight = 0
			local curagaTier = 0
			local curagaPriority = 0
			local curagaHealed = 0
			local curagaCount = 0

			-- Fix missing distances
			if k == HealerID then
				if type(v.mob) == 'table' then
					v.mob.distance = 0.1
				else
					v.mob = T{}
					v.mob.distance = 0.1
				end
			else
				if type(v.mob) == 'table' then
					if v.mob.distance then
						local x = tonumber(v.mob.x) - tonumber(PartyData[HealerID].mob.x)
						local y = tonumber(v.mob.y) - tonumber(PartyData[HealerID].mob.y)
						v.mob.distance = math.sqrt(x * x + y * y)
					end
				end
			end

			-- Paranoid checking for a valid party member
			if type(v.mob) == 'table' and v.mob.distance and v.mob.x and v.mob.y and not CheckPlayerForBuff(v.name, 'charm') then
				if k:sub(1, 1) == 'p' then -- Checks that the player is in the same party
					if CurablePlayers[v.name] and v.hp > 0 and v.mob.distance < 420 and v.mob.distance ~= 0.089004568755627 then
						-- Checking for access to curaga spells
						if player.main_job == 'WHM' or player.sub_job == 'WHM' then
							for kk, vv in pairs(PartyData) do
								if type(vv) == 'table' and type(vv.mob) == 'table' and kk:sub(1, 1) == 'p' and vv.mob.x and vv.mob.y and CheckPlayerForBuff(vv.name, 'charm') then
									x = tonumber(v.mob.x) - tonumber(vv.mob.x)
									y = tonumber(v.mob.y) - tonumber(vv.mob.y)

									-- Paranoid checking that we calculated missing hp for this party member
									if not vv.healNeeded then
										if vv.hp > 0 then
											vv.healNeeded = vv.hp / (vv.hpp / 100) - vv.hp
										else
											vv.healNeeded = 0
										end
									end

									-- In range?
									if (x * x + y * y) <= 185 then
										if vv.healNeeded > Curaga2Threshold then
											curagaCount = curagaCount + 1
											curagaPriority = curagaPriority + vv.hpp
											curagaHealed = curagaHealed + vv.healNeeded
										end

										if vv.healNeeded > Curaga5Threshold and curagaTier < 5 then
											curagaTier = 5
										elseif vv.healNeeded > Curaga4Threshold and curagaTier < 4 then
											curagaTier = 4
										elseif vv.healNeeded > Curaga3Threshold and curagaTier < 3 then
											curagaTier = 3
										elseif vv.healNeeded > Curaga2Threshold and curagaTier < 2 then
											curagaTier = 2
										end
									end
								end
							end

							-- Check if we should use a curaga
							if curagaCount > 1 and curagaPriority > 0 then
								curagaWeight = GetCurePriority(curagaPriority / curagaCount) * curagaHealed
								if curagaWeight > biggestCuragaWeight then
									biggestCuragaWeight = curagaWeight
									biggestCuragaIndex = k
									bestCuragaTier = curagaTier
								end
							end
						end
					end

					if v.hp > 0 and v.healNeeded > Cure3Threshold and v.mob.distance < 420 then
						local curePriority = GetCurePriority(v.hpp)
						if curePriority * v.healNeeded > biggestCureWeight then
							biggestCureWeight = curePriority * v.healNeeded * PlayerPriorities[v.name]
							biggestCureIndex = k
						end
					end
				elseif state.AutoCureMode.value == 'Ally' then
					if not v.healNeeded and v.hp > 0 then
						v.healNeeded = v.hp / (v.hpp / 100) - v.hp
					else
						v.healNeeded = 0
					end

					if v.hp > 0 and v.healNeeded > Cure3Threshold and v.mob.distance < 420 then
						local curePriority = GetCurePriority(v.hpp)
						if curePriority * v.healNeeded > biggestCureWeight then
							biggestCureWeight = curePriority * v.healNeeded * PlayerPriorities[v.name]
							biggestCureIndex = k
						end
					end
				end
			end
		end
	end

	local curagaTarget = PartyData[biggestCuragaIndex]
	local cureTarget = PartyData[biggestCureIndex]

	if player.main_job == 'WHM' then
		if bestCuragaTier >= 2 and biggestCuragaWeight >= biggestCureWeight then
			if bestCuragaTier == 5 and IsSpellReady('Curaga V') then
				AddToStack(GetSpellFromName('Curaga V'), curagaTarget.name, { partyCheck = true })
				return true
			end
			if bestCuragaTier == 4 and IsSpellReady('Curaga IV') then
				AddToStack(GetSpellFromName('Curaga IV'), curagaTarget.name, { partyCheck = true })
				return true
			end
			if bestCuragaTier == 3 and IsSpellReady('Curaga III') then
				AddToStack(GetSpellFromName('Curaga III'), curagaTarget.name, { partyCheck = true })
				return true
			end
			if bestCuragaTier == 2 and IsSpellReady('Curaga II') then
				AddToStack(GetSpellFromName('Curaga II'), curagaTarget.name, { partyCheck = true })
				return true
			end
		end
		if biggestCureWeight > 0 and cureTarget then
			if cureTarget.healNeeded > Cure6Threshold and IsSpellReady('Cure VI') then
				AddToStack(GetSpellFromName('Cure VI'), cureTarget.name)
				return true
			end
			if cureTarget.healNeeded > Cure5Threshold and IsSpellReady('Cure V') then
				AddToStack(GetSpellFromName('Cure V'), cureTarget.name)
				return true
			end
			if cureTarget.healNeeded > Cure4Threshold and IsSpellReady('Cure IV') then
				AddToStack(GetSpellFromName('Cure IV'), cureTarget.name)
				return true
			end
			if cureTarget.healNeeded > Cure3Threshold and IsSpellReady('Cure III') then
				AddToStack(GetSpellFromName('Cure III'), cureTarget.name)
				return true
			end
		end
	elseif player.main_job == 'SCH' or player.main_job == 'RDM' then
		if player.sub_job == 'WHM' and bestCuragaTier >= 1 and biggestCuragaWeight >= biggestCureWeight and IsSpellReady('Curaga II') then
			AddToStack(GetSpellFromName('Curaga II'), PcuragaTarget.name, { partyCheck = true })
			return true
		end
		if biggestCureWeight > 0 and cureTarget then
			if cureTarget.healNeeded > Cure4Threshold and IsSpellReady('Cure IV') then
				AddToStack(GetSpellFromName('Cure IV'), cureTarget.name)
				return true
			end
			if cureTarget.healNeeded > Cure3Threshold and IsSpellReady('Cure III') then
				AddToStack(GetSpellFromName('Cure III'), cureTarget.name)
				return true
			end
		end
	elseif player.sub_job == 'WHM' then
		if bestCuragaTier >= 1 and biggestCuragaWeight >= biggestCureWeight and IsSpellReady('Curaga II') then
			AddToStack(GetSpellFromName('Curaga II'), curagaTarget.name, { partyCheck = true })
			return true
		end
		if biggestCureWeight > 0 and cureTarget then
			if cureTarget.healNeeded > Cure4Threshold and IsSpellReady('Cure IV') then
				AddToStack(GetSpellFromName('Cure IV'), cureTarget.name)
				return true
			end
			if cureTarget.healNeeded > Cure3Threshold and IsSpellReady('Cure III') then
				AddToStack(GetSpellFromName('Cure III'), cureTarget.name)
				return true
			end
		end
	elseif player.main_job == 'PLD' or player.sub_job == 'RDM' or player.sub_job == 'SCH' then
		if biggestCureIndex > 0 and cureTarget then
			if cureTarget.healNeeded > Cure4Threshold and IsSpellReady('Cure IV') then
				AddToStack(GetSpellFromName('Cure IV'), cureTarget.name)
				return true
			end
			if curagaTarget.healNeeded > Cure3Threshold and IsSpellReady('Cure III') then
				AddToStack(GetSpellFromName('Cure III'), cureTarget.name)
				return true
			end
		end
	end

	return false
end

function GetDelayFromAction(action)
	if action.type == 'Misc' then
		return math.ceil((RangedDelay / 106) * info.CastSpeed)
	elseif action.type == 'JobAbility' or action.type == 'PetCommand' or action.type == 'Scholar' or not action.cast_time then
		return 0.5
	elseif action.english == 'Stoneskin' then
		return math.ceil(10 * info.CastSpeed)
	end

	return math.ceil(action.cast_time * info.CastSpeed)
end

function user_tick()
	PartyData = windower.ffxi.get_party()
	PartyDistances()

	return false
end

function extra_user_tick()
	if #ActionStack == 0 then
		ShowArrayContents()
		return false
	end

	local result = false

	-- Update the Action Stack Window
	for i = 1, #ActionStack, 1 do
		if not ActionStack[i] then
			ActionStack[i] =
			{
				spell = GetSpellFromName('Raise'),
				target = player.name,
				failCount = 7,
				hasTargetID = false,
				partyCheck = false,
				withStratagem = false,
				skillchainName = '',
				skillchainStep = 0,
				pianissimo = false,
				fixedOrder = false,
				dummySong = false,
			}
		end

		local nextTick = GetDelayFromAction(ActionStack[i].spell)

		if (ActionStack[i].fixedOrder and i == 1) or not ActionStack[i].fixedOrder then
			local canHandle = CanHandleAction(ActionStack[i])
			if not canHandle then
				ActionStack[i].failCount = ActionStack[i].failCount + 1
			elseif canHandle == 'remove' then
				ActionStack[i].failCount = 100
			else
				if ActionStack[i].spell.category and ActionStack[i].spell.category == 'Usable' then
					if ActionStack[i].target == 't' then
						windower.chat.input('/item "'..ActionStack[i].spell.en..'" <t>')
						tickdelay = os.clock() + ActionStack[i].spell.cast_time + 0.75
						ActionStack[i].failCount = ActionStack[i].failCount + 1
						result = true
					elseif ActionStack[i].target == 'bt' then
						windower.chat.input('/item "'..ActionStack[i].spell.en..'" <bt>')
						tickdelay = os.clock() + ActionStack[i].spell.cast_time + 0.75
						ActionStack[i].failCount = ActionStack[i].failCount + 1
						result = true
					elseif tonumber(ActionStack[i].target) then
						if CheckTargetExists(ActionStack[i].spell, ActionStack[i].target) then
							windower.chat.input('/item "'..ActionStack[i].spell.en..'" '..ActionStack[i].target)
							tickdelay = os.clock() + ActionStack[i].spell.cast_time + 0.75
							result = true
						else
							ActionStack[i].failCount = 31
							add_to_chat(55, 'Target '..ActionStack[i].target..' was determined as invalid')
						end
					elseif ActionStack[i].target == player.name or CheckRange(ActionStack[i].target, ActionStack[i].partyCheck) then
						windower.chat.input('/item "'..ActionStack[i].spell.en..'" '..ActionStack[i].target)
						tickdelay = os.clock() + ActionStack.spell.cast_time + 0.75
						result = true
					else
						ActionStack[i].failCount = 31
						add_to_chat(55, 'Unable to use '..ActionStack[i].spell.en..', failed 30 attempts')
					end

					break
				end

				if ActionStack[i].spell.prefix == '/ra' then
					windower.chat.input('/ra')
					tickdelay = os.clock() + nextTime
					ActionStack[i].failCount = ActionStack[i].failCount + 1
					result = true
					break
				elseif ActionStack[i].spell.prefix == '/song' then
					if ActionStack[i].pianissimo and not buffactive['pianissimo'] then
						windower.chat.input('/ja "Pianissimo" <me>')
						tickdelay = os.clock() + 0.5
						result = true
						break
					else
						if ActionStack[i].target == 'self' or (ActionStack[i].target == player.name and CheckRange(ActionStack[i].target, true)) then
							windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" <me>')
							tickdelay = os.clock() + nextTick
							ActionStack[i].failCount = ActionStack[i].failCount + 1
							result = true
							break
						elseif ActionStack[i].target == 'bt' then
							windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" <bt>')
							tickdelay = os.clock() + nextTick
							ActionStack[i].failCount = ActionStack[i].failCount + 1
							result = true
						elseif tonumber(ActionStack[i].target) then
							if CheckTargetExists(ActionStack[i].spell, ActionStack[i].target) then
								windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" '..ActionStack[i].target)
								tickdelay = os.clock() + nextTick
								ActionStack[i].failCount = ActionStack[i].failCount + 1
								result = true
							else
								ActionStack[i].failCount = 31
							end
						elseif CheckRange(ActionStack[i].target, true) then
							windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" '..ActionStack[i].target)
							tickdelay = os.clock() + nextTick
							ActionStack[i].failCount = ActionStack[i].failCount + 1
							result = true
							break
						end
					end
				elseif ActionStack[i].spell.en == 'Arise' or ActionStack[i].spell.en:sub(1, 5) == 'Raise' then
					if CheckRaisable(ActionStack[i].target) then
						windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" '..ActionStack[i].target)
						tickdelay = os.clock() + nextTick
						ActionStack[i].failCount = ActionStack[i].failCount + 1
						result = true
						break
					else
						ActionStack[i].failCount = 31
					end
				elseif ActionStack[i].spell.prefix == '/weaponskill' and player.status == 'Engaged' and player.tp >= 1000 then
					if ActionStack[i].target == 't' then
						windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" <t>')
						tickdelay = os.clock() + nextTick
						ActionStack[i].failCount = ActionStack[i].failCount + 1
						result = true
						break
					elseif ActionStack[i].target == 'bt' then
						windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en'" <bt>')
						tickdelay = os.clock() + nextTick
						ActionStack[i].failCount = ActionStack[i].failCount + 1
						result = true
					elseif tonumber(ActionStack[i].target) then
						if CheckTargetExists(ActionStack[i].spell, ActionStack[i].target) then
							windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" '..ActionStack[i].target)
							tickdelay = os.clock() + nextTick
							ActionStack[i].failCount = ActionStack[i].failCount + 1
							result = true
						else
							ActionStack[i].failCount = 31
						end
					elseif ActionStack[i].target == player.name or CheckRange(ActionStack[i].target, false) then
						windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" '..ActionStack[i].target)
						tickdelay = os.clock() + nextTick
						ActionStack[i].failCount = ActionStack[i].failCount + 1
						result = true
						break
					else
						ActionStack[i].failCount = 31
					end
				elseif ActionStack[i].withStratagem and not buffactive[ActionStack[i].withStratagem] then
					-- Use the correct strategem if the spell requires it
					if IsStratagemReady(ActionStack[i].withStratagem) then
						windower.chat.input('/ja "'..ActionStack[i].withStratagem..'" <me>')
						tickdelay = os.clock() + 0.5
						ActionStack[i].failCount = ActionStack[i].failCount + 1
						result = true
					end
					break
				else
					-- No strat needed or strat is already active
					if ActionStack[i].target == 't' then
						local targetMob = windower.ffxi.get_mob_by_target('t')
						if ActionStack[i].skillchainStep == 1 then
							if targetMob and targetMob.name then
								windower.chat.input('/p Starting '..ActionStack[i].skillchainName..' on '..targetMob.name)
							else
								windower.chat.input('/p Starting '..ActionStack[i].skillchainName)
							end

							windower.chat.input(ActionStack[i].spell/prefix..' "'..ActionStack[i].spell.en..'" <t>')
							tickdelay = os.clock() + nextTick
							ActionStack[i].failCount = ActionStack[i].failCount + 1
							result = true
							break
						elseif ActionStack[i].skillchainStep == 2 then
							if targetMob and targetMob.name then
								windower.chat.input('/p Closing '..ActionStack[i].skillchainName..' on '..targetMob.name)
							else
								windower.chat.input('/p Closing '..AcitonStack[i].skillchainName)
							end
							windower.chat.input('/p '..CountStratagemsReady()..' strats remaining.')
							windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" <t>')
							tickdelay = os.clock() + nextTick
							ActionStack[i].failCount = ActionStack[i].failCount + 1
							result = true
							break
						else
							windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" <t>')
							tickdelay = os.clock() + nextTick
							ActionStack[i].failCount = ActionStack[i].failCount + 1
							result = true
							break
						end
					elseif ActionStack[i].target == 'bt' then
						windower.chat.input('input '..ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" <bt>')
						tickdelay = os.clock() + nextTick
						ActionStack[i].failCount = ActionStack[i]
						result = true
						break
					elseif tonumber(ActionStack[i].target) then
						if CheckTargetExists(ActionStack[i].spell, ActionStack[i].target) then
							local targetMob = windower.ffxi.get_mob_by_id(ActionStack[i].target)
							if ActionStack[i].skillchainStep == 1 then
								if targetMob and targetMob.name then
									windower.chat.input('/p Starting '..ActionStack[i].skillchainName..' on '..targetMob.name)
									windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" '..ActionStack[i].target)
									tickdelay = os.clock() + nextTick
									result = true
								end
								ActionStack[i].failCount = ActionStack[i].failCount + 1
								break
							elseif ActionStack[i].skillchainStep == 2 then
								if targetMob and targetMob.name then
									windower.chat.input('/p Closing '..ActionStack[i].skillchainName..' on '..targetMob.name)
									windower.chat.input('/p '..CountStratagemsReady()..' strats remaining.')
									windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" '..ActionStack[i].target)
									tickdelay = os.clock() + nextTick
									result = true
								end
								ActionStack[i].failCount = ActionStack[i].failCount + 1
								break
							else
								windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" '..ActionStack[i].target)
								tickdelay = os.clock + nextTick
								ActionStack[i].failCount = ActionStack[i].failCount + 1
								result = true
								break
							end

							break
						else
							ActionStack[i].failCount = 31
							windower.add_to_chat(55, 'Target '..ActionStack[i].target..' was determined invalid')
						end
					elseif ActionStack[i].target == player.name or CheckRange(ActionStack[i].target, ActionStack[i].partyCheck) then
						if ActionStack[i].spell.en == 'Arise' or ActionStack[i].spell.en:sub(1, 5) == 'Raise' then
							if CheckRaisable(ActionStack[i].target) then
								windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" '..ActionStack[i].target)
								tickdelay = os.clock() + nextTick
								ActionStack[i].failCount = ActionStack[i].failCount + 1
								result = true
								break
							else
								ActionStack[i].failCount = 31
							end
						else
							windower.chat.input(ActionStack[i].spell.prefix..' "'..ActionStack[i].spell.en..'" '..ActionStack[i].target)
							tickdelay = os.clock() + nextTick
							ActionStack[i].failCount = ActionStack[i].failCount + 1
							result = true
							break
						end
					else
						ActionStack[i].failCount = 31
					end
				end
			end
		end
	end

	for k, v in pairs(ActionStack) do
		if v.failCount and v.failCount > 30 then
			RebuildArray(v.spell, v.target)
		end
	end

	ShowArrayContents()

	return result
end

function CheckRaisable(playerName)
	for k, v in pairs(PartyData) do
		if type(v) == 'table' then
			if v.name and v.name == playerName and v.hp == 0 and type(v.mob) == 'table' then
				if v.mob.distance then
					return v.mob.distance < 420
				else
					local x = tonumber(v.mob.x) - tonumber(player.mob.x)
					local y = tonumber(v.mob.y) - tonumber(player.mob.y)

					return (x * x + y * y) < 420
				end
			end
		end
	end

	return false
end

function CheckRange(playerName, partyOnly)
	for k, v in pairs(PartyData) do
		if type(v) == 'table' then
			if not partyOnly or (partyOnly and k:sub(1, 1) == 'p') then
				if v.name and v.name == playerName and v.hp > 0 then
					return type(v.mob) == 'table' and v.mob.distance and v.mob.distance < 420 and v.mob.distance ~= 0.089004568755627
				end
			end
		end
	end

	return false
end

function CheckInQueue(spellName, spellTarget)
	if type(ActionStack) == 'table' then
		for i = 1, #ActionStack, 1 do
			if type(ActionStack[i]) == 'table' then
				if ActionStack[i].spell.en == spellName and
					(not spellTarget or ActionStack[i].target == spellTarget or (spellTarget == player.name and ActionStack[i].target == 'self'))
				then
					return true
				elseif i == 1 then
					if ActionStack[i].pianissimo and spellName == 'Pianissimo' then
						return true
					elseif ActionStack[i].withStratagem ~= '' and spellName == ActionStack[i].withStratagem then
						return true
					end
				end
			end
		end
	end

	if LastRemovedSpell.spell and
		spellName == LastRemovedSpell.spell.en and
		(LastRemovedSpell.target == spellTarget or (spellTaget == player.name and LastRemovedSpell.target == 'self'))
	then
		return true
	end

	return false
end

function CanHandleAction(action)
	local precastCheck = action.precastCheck(action)
	if not precastCheck then return false end
	if precastCheck == 'remove' then return 'remove' end

	if IsSpellTargetingCharmedPlayer(action.spell) then return false end

	if action.spell.category then
		if action.spell.category == 'Usable' then
			return item_available(action.spell)
		end
		return false
	end

	if action.spell.prefix == '/ra' then return true end

	if action.spell.prefix == '/weaponskill' and not buffactive['impairment'] and not buffactive['amnesia'] and player.tp >= 1000 then
		return true
	end

	if action.spell.type and action.spell.type == 'Scholar' and AutoStrat and not buffactive['impairment'] and not buffactive['amnesia'] and not buffactive[action.spell.en] and IsStratagemReady(action.spell.en) then
		return true
	end


	if (action.spell.prefix == '/jobability' or action.spell.prefix == '/pet') and not buffactive['impairment'] and not buffactive['amnesia'] and IsAbilityReady(action.spell.en) then
		return true
	end

	if (action.spell.prefix == '/ninjutsu' or action.spell.prefix == '/song') and not buffactive['silence'] and not buffactive['omerta'] and IsSpellReady(action.spell.name) then
		return true
	end

	if action.spell.prefix == '/magic' and not buffactive['silence'] and not buffactive['omerta'] and IsSpellReady(action.spell.en) and player.mp >= action.spell.mp_cost then
		return true
	end

	return false
end

function ClearCures()
	if type(ActionStack) == 'table' then
		local tempStack = T{}
		local j = 1
		for i = 1, #ActionStack, 1 do
			if type(ActionStack[i]) == 'table' then
				if ActionStack[i].spell.id > 11 or ActionStack[i].spell.id == 7 then
					tempStack[j] = {}
					table.reassign(tempStack[j], ActionStack[i])
					j = j + 1
				end
			end
		end
		table.clear(ActionStack)
		table.reassign(ActionStack, tempStack)
	end
end

function ClearActionStack()
	if #ActionStack >= 1 then
		table.clear(ActionStack)
	end

	ShowArrayContents()
end

function AddToStack(action, actionTarget, options)
	if action == 'Ranged Attack' then
		action =
		{
			id = 4,
			english = 'Ranged',
			en = 'Ranged',
			prefix = '/ra'
		}
		actionTarget = 't'
	elseif type(action) ~= 'table' then
		windower.add_to_chat(55, tostring(action)..' is not a valid action.')
		return
	end

	if not options or type(options) ~= 'table' then
		options = {}
	end
	options.target = actionTarget

	options.importance = options.importance or 1.00
	options.partyCheck = options.partyCheck or false
	options.withStratagem = options.withStratagem or false
	options.skillchainName = options.skillchainName or ''
	options.skillchainStep = options.skillchainStep or 0
	options.pianissimo = options.pianissimo or false
	options.fixedOrder = options.fixedOrder or false
	options.precastCheck = options.precastCheck or function() return true end
	options.aftercast = options.aftercast or function() return true end
	options.dummySong = options.dummySong or false
	
	options.hasTargetID = tonumber(options.target) ~= nil or options.target == 'bt'

	newStack = GetNewStack(action, options)
	table.clear(ActionStack)
	table.reassign(ActionStack, newStack)
	ShowArrayContents()
end

function GetActionStackAction(action, options)
	return
	{
		spell = action,
		target = options.target,
		failCount = 0,
		hasTargetID = options.hasTargetID,
		partyCheck = options.partyCheck,
		withStratagem = options.withStratagem,
		skillchainName = options.skillchainName,
		skillchainStep = options.skillchainStep,
		pianissimo = options.pianissimo,
		fixedOrder = options.fixedOrder,
		precastCheck = options.precastCheck,
		aftercast = options.aftercast,
		addedAt = os.clock(),
		importance = options.importance,
		dummySong = options.dummySong
	}
end

function GetNewStack(action, options)
	local newStack = T{}
	local newStackIndex = 1
	local addedNewAction = false

	-- TODO: Setup spell priorities
	if action.cast_time then
	end

	if PlayerPriorities[options.target] then
		options.importance = options.importance * PlayerPriorities[options.target]
	end

	if #ActionStack > 0 then
		for i = 1, #ActionStack, 1 do
			if not addedNewAction and ShouldInsertNewAction(ActionStack[i], options.importance) then
				newStack[newStackIndex] = GetActionStackAction(action, options)
				addedNewAction = true
				newStackIndex = newStackIndex + 1
			end

			if KeepExistingAction(ActionStack[i], action, options) then
				newStack[newStackIndex] = {}
				table.reassign(newStack[newStackIndex], ActionStack[i])
				newStackIndex = newStackIndex + 1
			end
		end
	end

	if not addedNewAction then
		newStack[newStackIndex] = GetActionStackAction(action, options)
	end

	return newStack
end

function ShouldInsertNewAction(existingAction, newImportance)
	if type(existingAction) ~= 'table' then return false end

	return existingAction.importance < newImportance
end

function KeepExistingAction(existingAction, newAction, options)
	if type(existingAction) ~= 'table' then return false end

	if newAction.prefix == '/weaponskill' and existingAction.spell.prefix == '/weaponskill' then
		return false
	end

	if existingAction.target ~= options.target then
		return true
	end

	if existingAction.spell.prefix ~= newAction.prefix then
		return true
	end

	if existingAction.spell.id ~= newAction.id then
		return true
	end

	if existingAction.spell.prefix == '/song' and existingAction.dummySong ~= newAction.dummySong then
		return true
	end

	return false
end

function RebuildArray(actionToRemove, target)
	if type(ActionStack) == 'table' then
		local tempStack = T{}
		local j = 1
		removedActionOnce = false
		for i = 1, #ActionStack, 1 do
			if type(ActionStack[i])== 'table' then
				if not removedActionOnce and
					((ActionStack[i].spell.category and actionToRemove.category and ActionStack[i].spell.category == actionToRemove.category) or
					(ActionStack[i].spell.prefix == actionToRemove.prefix and ActionStack[i].spell.id == actionToRemove.id and ActionStack[i].target == target))
				then
					if (ActionStack[i].spell.type and ActionStack[i].spell.type == 'Scholar') or
						(ActionStack[i].spell.prefix == '/song' and ActionStack[i].dummySong)
					then
						removedActionOnce = true
					end
					table.reassign(LastRemovedSpell, ActionStack[i])
				else
					tempStack[j] = {}
					table.reassign(tempStack[j], ActionStack[i])
					j = j + 1
				end
			end
		end

		table.clear(ActionStack)
		table.reassign(ActionStack, tempStack)
	end
end

function ShowArrayContents()
	local outputString = ''
	if type(ActionStack) == 'table' and #ActionStack > 0 then
		outputString = 'Pos Spell                Target        Tries\n'
		local j = #ActionStack
		if j > OutputMaxLines then
			j = OutputMaxLines
		end

		local num = 0
		local target = ''
		for i = 1, j, 1 do
			if type(ActionStack[i]) == 'table' then
				num = tostring(i)
				target = tostring(ActionStack[i].target)
				outputString = outputString..num:rpad(' ', 3)..' '..ActionStack[i].spell.en:rpad(' ', 20)..' '..target:rpad(' ', 12)..' '..ActionStack[i].failCount..'\n'
			end
		end
	end

	windower.text.set_text('StackOutput', outputString)
end

function CheckAoERange(playerName)
	for k, v in pairs(PartyData) do
		if type(v) == 'table' then
			if k:sub(1, 1) == 'p' then
				if v.name and v.name == playerName then
					if type(v.mob) == 'table' then
						if v.mob.distance then
							return v.mob.distance < 100 and v.mob.distance ~= 0.089004568755627
						else
							local x = tonumber(v.mob.x) - tonumber(player.mob.x)
							local y = tonumber(v.mob.y) - tonumber(player.mob.y)

							return (x * x + y * y) < 100
						end
					end
				end
			end
		end
	end

	return false
end

function user_aftercast(spell, spellMap, eventArgs)
	if spell.interrupted or spell.action_type == 'Interruption' then
		if #ActionStack > 0 then
			eventArgs.handled = true
			local targetId = tostring(spell.target.id)
			for i = 1, #ActionStack, 1 do
				if spell.english == ActionStack[i].spell.en and
					(ActionStack[i].target == 't' or
					ActionStack[i].target == 'bt' or
					targetId == tostring(ActionStack[i].target) or
					spell.target.name == ActionStack[i].target or
					(ActionStack[i].target == 'self' and spell.target.name == player.name) or
					(ActionStack[i].target == player.name and spell.target.name == 'Luopan'))
				then
					tickdelay = os.clock() + 0.1

					ShowArrayContents()
					break
				end
			end
		end
	else
		if spell.value and spell.type == 'CorsairRoll' then
			LastValue = tonumber(spell.value)
		end

		if #ActionStack > 0 then
			eventArgs.handled = true
			local targetId = tostring(spell.target.id)
			for i = 1, #ActionStack, 1 do
				if spell.english == ActionStack[i].spell.english and
					(ActionStack[i].target == 't' or
					ActionStack[i].target == 'bt' or
					targetId == tostring(ActionStack[i].target) or
					spell.target.name == ActionStack[i].target or
					(ActionStack[i].target == 'self' and spell.target.name == player.name) or
					(ActionStack[i].target == player.name and spell.target.name == 'Luopan'))
				then
					-- Aftercast callback
					ActionStack[i].aftercast()

					if spell.type == 'Misc' then
						tickdelay = os.clock() + 1.5
					elseif not spell.cast_time or spell.type == 'JobAbility' or spell.type == 'Scholar' or spell.type == 'Item' or spell.type == 'PetCommand' or (spell.type == 'CorsairRoll' and ActionStack[i].spell.en == 'Double-Up') then
						tickdelay = os.clock() + 0.8
					elseif ActionStack[i].dummySong then
						tickdelay = os.clock() + 8
					else
						tickdelay = os.clock() + 2.5
					end

					RebuildArray(ActionStack[i].spell, ActionStack[i].target)
					ShowArrayContents()
					break
				elseif spell.type == 'CorsairRoll' and ActionStack[i].spell.en == 'Double-Up' then
					RebuildArray(ActionStack[i].spell, ActionStack[i].target)
					tickdelay = os.clock() + 0.8
					ShowArrayContents()
					break
				end
			end
		end
	end
end

windower.raw_register_event("action", function(act)
	if act.category == 5 then
		if #ActionStack > 0 then
			local targetId = tostring(act.targets[1].id)
			for i = 1, #ActionStack, 1 do
				if ActionStack[i].spell.category and act['param'] == ActionStack[i].spell.id and
					(ActionStack[i].target == 't' or ActionStack[i].target == 'bt' or
					targetId == tostring(ActionStack[i].target) or
					(ActionStack[i].target == player.name and player.id == targetId))
				then
					RebuildArray(ActionStack[i].spell, ActionStack[i].target)
					tickdelay = os.clock() + 1.5
					ShowArrayContents()
					break
				end
			end
		end
	end
end)

windower.raw_register_event("chat message", function(message, sender, mode, gm)
	if not process_chat_message then return end

	if mode == 3 or mode == 4 then
		if type(message) == 'string' then
			process_chat_message(message, sender)
		end
	end
end)