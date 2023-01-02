packets = require('packets')

-- Include default settings
if file_exists('spellstack/settings/default.lua') then
	include('spellstack/settings/default.lua')
end

-- Settings file load priority: Name_JOB.lua, Name.lua, JOB.lua
local NameJobFile = 'spellstack/settings/'..player.name..'_'..player.main_job..'.lua'
local NameFile = 'spellstack/settings/'..player.name..'.lua'
local JobFile = 'spellstack/settings/'..player.main_job..'.lua'

-- Include any override settings
if file_exists(NameJobFile) then
	include(NameJobFile)
elseif file_exists(NameFile) then
	include(NameFile)
elseif file_exists(JobFile) then
	include(JobFile)
end

local SpellPriority = require('spellstack/spellpriorities.lua')
local AbilityPriority = require('spellstack/abilitypriorities.lua')

windower.text.create('StackWindow')
windower.text.set_bg_color('StackWindow', TextSettings.BackgroundColor.A, TextSettings.BackgroundColor.R, TextSettings.BackgroundColor.G, TextSettings.BackgroundColor.B)
windower.text.set_color('StackWindow', TextSettings.FontColor.A, TextSettings.FontColor.R, TextSettings.FontColor.G, TextSettings.FontColor.B)
windower.text.set_font('StackWindow', 'fixedsys', 'consolas', 'courier new', 'monospace')
windower.text.set_font_size('StackWindow', TextSettings.FontSize)
windower.text.set_text('StackWindow', '')
windower.text.set_visibility('StackWindow', true)
windower.text.set_bg_visibility('StackWindow', TextSettings.ShowBackground)
windower.text.set_location('StackWindow', TextSettings.Position.X, TextSettings.Position.Y)

function user_unload()
	windower.text.delete('StackWindow')
end

-- Need to do some fancy detection to determine strategem usage
local StratagemCooldownTimes =
{
	[0] = 0,
	[1] = 240,
	[2] = 120,
	[3] = 80,
	[4] = 60,
	[5] = 48,
}

-- @return MaxStratagems, StratagemCooldown, TotalStratagemCooldown
function GetStratagemsData()
	-- A Strategem is gained every 20 levels starting at level 10 to a maximum of 5 at Level 90+
	local schLevel = player.main_job == 'SCH' and player.main_job_level or player.sub_job == 'SCH' and player.sub_job_level or 0
	local maxStrats = math.floor((schLevel + 10) / 20)

	-- 15 second cooldown reduction for 550 JP Gift
	local jpBonus = player.main_job == 'SCH' and player.main_job_level >= 99 and player.job_points.sc.jp_spent >= 550 and 15 or 0

	-- Table lookup for cooldown time
	local stratCooldown = StratagemCooldownTimes[maxStrats] - jpBonus
	local totalCooldown = math.max(0, (maxStrats - 1) * stratCooldown)

	return maxStrats, stratCooldown, totalCooldown
end

local MaxStratagems, StratagemCooldown, TotalStratagemCooldown = GetStratagemsData()

-- Initialize Party and Recasts
local party = windower.ffxi.get_party()
local recasts = windower.ffxi.get_spell_recasts()

-- The SpellStack
SpellStack = T{}

-- @return Spell resource from spell name
function GetSpellFromName(spellName)
	return SpellMap[spellName]
end

-- @return Ability resource from ability name
function GetAbilityFromName(abilityName)
	return AbilityMap[abilityName]
end

function GetWeaponskillFromName(wsName)
	return WeaponskillMap[wsName]
end

function GetCurePriority(hpp)
	hpp = 100 - tonumber(hpp)
	if hpp == 0 or hpp > 99 then
		return 0
	end

	return 0.0007 * math.pow(hpp, 4) + 0.0028 * math.pow(hpp, 3) - 0.707 * math.pow(hpp, 2) + 2.7944 * hpp + 97.323
end

function AddSpellToStack(spellToAdd, spellTarget, options)
	options = options or {}

	if spellToAdd == 'Ranged Attack' then
		spellToAdd =
		{
			id = 4,
			english = 'Ranged',
			en = 'Ranged',
			prefix = '/ra',
		}
		spellTarget = 't'
	elseif not CanAddSpell(spellToAdd) then
		return
	elseif type(spellToAdd) ~= 'table' then
		windower.add_to_chat(055, tostring(spellToAdd).." is not a valid spell, use spells/abilities/weaponskill windower resource.")
		return
	end

	if not IsValidTarget(spellTarget) then
		return
	end

	local sanitizedOptions =
	{
		priority = options.priority or 1,
		partyCheck = options.partyCheck or false,
		withStrategem = options.withStrategem or false,
		skillchainName = options.skillchainName or '',
		skillchainStep = options.skillchainStep or 0,
		pianissimo = options.pianissimo or false,
		fixedOrder = options.fixedOrder or false,
		target = spellTarget,
		precastCheck = options.precastCheck or function() return true end,
		aftercast = options.aftercast or function() return true end,
	}
end

function IsSpellTargetingCharmedPlayer(spell)
	if spell.targets and type(spell.targets) == 'tables' and spell.targets.Enemy then
		return false
	end

	return DoesPlayerHaveBuff(spell.target, 'charm')
end

function CanAddSpell(spell)
	if IsSpellTargetingCharmedPlayer(spell) then return false end

	if spell.category == 'Usable' then return DoesItemExist(spell) end

	-- TODO: Check strategems are available

	-- Can't use weaponskills, job abilities, or pet abilities with impairment or amnesia up
	if (spell.prefix == '/weaponskill' or spell.prefix == '/jobability' or spell.prefix == '/pet') and (buffactive['impairment'] or buffactive['amnesia']) then
		return false
	end

	--- Can't use ninjutsu, magic, or songs while silenced
	if (spell.prefix == '/ninjutsu' or spell.prefix == '/magic' or spell.prefix == '/song') and (buffactive['silence'] or buffactive['omerta']) then
		return false
	end

	return true
end

function IsValidTarget(spell, spellTarget)
	local mob = nil
	if spellTarget == 't' then
		mob = windower.ffxi.get_mob_by_target('t')
	else
		mob = windower.ffxi.get_mob_by_id(spellTarget)
	end

	-- Mob target status is invalid
	if not mob.valid_target then
		return false
	end

	-- Mob is dead
	if mob.hpp == 0 then
		return false
	end

	-- Check mob is valid
	if not mob or type(mob) ~= 'table' then
		-- Could not find the target
		return false
	end

	-- Check distance variable is valid
	if not mob.distance or mob.distance == 0 then
		return false
	end

	-- Check that the mob is in range
	if spell and spell.range then
		-- Pad distance check by size of self and target models
		local testRange = mob.mode_size + RangeMap[spell.range] + player.model_size
		if mob.distance > (testRange * testRange) then
			return false
		end
	end

	if spell.en == 'Arise' or spell.en:sub(1, 5) == 'Raise' then
		local mob = windower.get_mob_by_target(spellTarget)
		if not mob then return false end

		if mob.hpp ~= 0 then
			return false
		end
	end

	return true
end

function GetPlayerBuffsFromAlliance(targetName)
	if alliance then
		for _, parties in pairs(alliance) do
			if type(parties) == 'table' then
				for party, player in pairs(parties) do
					if type(player) == 'table' and player.name == targetName and player.buffactive then
						return player.buffactive
					end
				end
			end
		end
	end

	return {}
end

function DoesPlayerHaveBuff(playerName, buffName)
	return GetPlayerBuffsFromAlliance(playerName)[buffName]
end

function CanCastSpell(StackSpell)
	if IsSpellTargetingCharmedPlayer(StackSpell.spell) then return false end

	local precastCheck = StackSpell.precastCheck(StackSpell)
	if not precastCheck then
		return false
	end

	if precastCheck == 'remove' then
		return 'remove'
	end

	-- Can't use weaponskills, job abilities, or pet abilities with impairment or amnesia up
	if (spell.prefix == '/weaponskill' or spell.prefix == '/jobability' or spell.prefix == '/pet') and (buffactive['impairment'] or buffactive['amnesia']) then
		return false
	end

	--- Can't use ninjutsu, magic, or songs while silenced
	if (spell.prefix == '/ninjutsu' or spell.prefix == '/magic' or spell.prefix == '/song') and (buffactive['silence'] or buffactive['omerta']) then
		return false
	end

	if spell.prefix == '/weaponskill' and player.tp < 1000 then
		return false
	end



	return true
end

function ProcessStack()
	if #SpellStack == 0 then
		UpdateSpellStackDisplay()
	end

	-- Find the first spell we can cast in the stack
	for StackIndex = 1, #SpellStack, 1 do
		if (SpellStack[StackIndex].fixedOrder and StackIndex == 1) or not SpellStack[StackIndex].fixedOrder) then
			local canCast = CanCastSpell(SpellStack[StackIndex])
			if not canCast then
				SpellStack[StackIndex].failCount = SpellStack[StackIndex].failCount + 1
			elseif canCast == 'remove' then
				SpellStack[StackIndex].failCount = 100
			else
				local prefix = SpellStack[StackIndex].spell.category == 'Usable' and '/item' or SpellStack[StackIndex].spell.prefix
				local spell = SpellStack[StackIndex].spell
				local target = SpellStack[StackIndex].target
				local targetValid = true

				-- Sanitize the target
				if target == 'bt' then
					if party_target and IsValidTarget(spell, party_target) then
						target = party_target
					else
						target = '<bt>'
					end
				elseif target == 't' then
					target = '<t>'
				else
					targetValid = IsValidTaret(spell, target)
				end

				if targetValid then
					windower.send_command('input '..prefix..' "'..spell.en..'" '..target..';')
				else
					SpellStack[StackIndex].failCount = SpellStack[StackIndex].failCount + 1
				end

				if SpellStack[StackIndex].spell.category == 'Usable' then
					if SpellStack[StackIndex].target == 't' then
						windower.send_command('input /item "'..SpellStack[StackIndex].spell.en..'" <t>;')
						SpellStack[StackIndex].failCount = SpellStack[StackIndex].failCount + 1
						break
					elseif SpellStack[StackIndex].target == 'bt' then
						if party_target and IsValidTaret(SpellStack[StackIndex].spell, party_target) then
							windower.send_command('input /item "'..SpellStack[StackIndex].spell.en..'" '..party_target..';')
						else
							windower.send_command('input /item "'..SpellStack[StackIndex].spell.en..'" <bt>;')
						end
						SpellStack[StackIndex].failCount = SpellStack[StackIndex].failCount + 1
						break
					elseif tonumber(SpellStack[StackIndex].target]) then
						if IsValidTarget(StackSpell[StackIndex].spell, StackSpell[StackIndex].target) then
							windower.send_command('input /item "'..SpellStack[StackIndex].spell.en..'" '..SpellStack[StackIndex].target..';')
						else
							SpellStack[StackIndex].failCount = SpellStack[StackIndex].failCount + 1
						end
						break
					elseif SpellStack[StackIndex].target == player.name or IsValidTarget(SpellStack[StackIndex].spell, StackSpell[StackIndex].target) then
						windower.send_command('input /item "'..SpellStack[StackIndex].spell.en..'" '..SpellStack[StackIndex].target..';')
						break
					else
						SpellStack[StackIndex].failCount = 31
					end
				end

				if SpellStack[StackIndex].spell.prefix == '/ra' then
					if party_target and IsValidTarget(SpellStack[StackIndex].spell, party_target) then
						windower.send_command('input /ra '..party_target..';')
					else
						windower.send_command('input /ra;')
					end
					SpellStack[StackIndex].failCount = SpellStack[StackIndex].failCount + 1
					break
				elseif SpellStack[StackIndex].spell.prefix == '/song' then
					if SpellStack[StackIndex].pianissimo and not buffactive['pianissimo'] then
						windower.send_command('input /ja Pianissimo '..player.name..';')
						break
					else
						if SpellStack[StackIndex].target == 'self' or SpellStack[StackIndex].target == player.name then
							windower.send_command('input '..SpellStack[StackIndex].spell.prefix..' "'..SpellStack[StackIndex].spell.end..'" '..player.name..';')
							SpellStack[StackIndex].failCount = SpellStack[StackIndex].failCount + 1
							break
						elseif SpellStack[StackIndex].target == 'bt' then
							if party_target and IsValidTarget(SpellStack[StackIndex].spell, party_target) then
								windower.send_command('input '..SpellStack[StackIndex].spell.prefix..' "'..Spellstack[StackIndex].spell.en..'" '..party_target..';')
							else
								windower.send_command('input '..SpellStack[StackIndex].spell.prefix..' "'..SpellStack[StackIndex].spell.en..'" <bt>;')
							end
							SpellStack[StackIndex].failCount = SpellStack[StackIndex].failCount + 1
							break
						elseif tonumber(SpellStack[StackIndex].target) then
							if IsValidTaret(SpellStack[StackIndex].target) then
								windower.send_command('input '..SpellStack[StackIndex].spell.prefix..' "'..SpellStack[StackIndex].spell.en..'" '..SpellStack[StackIndex].target..';')
							end
						end
					end
				end
			end
		end
	end
end

function PushSpell(spellToAdd, options)
	local TempStack = T{}
	local TempStackIndex = 1
	local addedNewSpell = false
	local priority = 1.00

	if spellToAdd.cast_time then
		priority = SpellPriority[spellToAdd.id] or 1.00
	elseif not spellToAdd.tp_cost then
		prioirity = AbilityPriority[spellToAdd.id] or 1.00
	end

	if PriorityPlayers[options.target] then
		priority = priority * PriorityPlayers[options.target]
	end

	if #SpellStack > 0 then
		for StackIndex = 1, #SpellStack, 1 do
			if not addedNewSpell and priority > SpellStack[StackIndex].priority then
				TempStack[TempStackIndex] = GetSpellForSpellStack(spellToAdd, options)
				addedNewSpell = true
				TempStackIndex = TempStackIndex + 1
			end

			if CanKeepExistingSpell(SpellStack[StackIndex], spellToAdd, options) then
				TempStack[TempStackIndex] = {}
				table.reassign(TempStack[TempStackIndex], SpellStack[StackIndex])
				TempStackIndex = TempStackIndex + 1
			end
		end
	end

	if not addedNewSpell then
		TempStack[TempStackIndex] = GetSpellForSpellStack(spellToAdd, options)
	end

	table.clear(SpellStack)
	table.reassign(SpellStack, TempStack)
	UpdateSpellStackDisplay()
end

function GetSpellForSpellStack(spellToAdd, options)
	return {
		spell = spellToAdd,
		target = options.target,
		failCount = 0,
		hasTargetID = options.hasTargetID,
		partyCheck = options.partyCheck,
		withStratagem = options.withStratagem,
		painissimo = options.pianissimo,
		fixedOrder = options.fixedOrder,
		precastCheck = options.precastCheck,
		aftercast = options.aftercast,
		addedAt = os.clock(),
		priority = options.priority
	}
end

function CanKeepExistingSpell(existingSpell, spellToAdd, options)
	if type(existingSpell ~= 'table' then
		return false
	end

	-- Only 1 Weaponskill allowed at a time
	if spellToAdd.prefix == '/weaponskill' and existingSpell.spell.prefix == 'weaponskill' then
		return false
	end

	if spellToAdd.type == 'Scholar' then
		return true
	end

	if existingSpell.target ~= options.target then
		return true
	end

	if existingSpell.spell.prefix ~= spellToAdd.prefix then
		return true
	end

	if existingSpell.spell.id ~= spellToAdd.id then
		return true
	end

	return false
end

windower.raw_register_Event('zone change', function(new_zone, old_zone)
	ClearSpellStack()
	UpdateSpellStackDisplay()
end)