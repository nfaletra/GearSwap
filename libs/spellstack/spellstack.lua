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

-- @return Spell resource from spell name
function GetSpellFromName(spellName)
	return SpellMap[spellName]
end

-- @return Ability resource from ability name
function GetAbilityFromName(abilityName)
	return AbilityMap[abilityName]
end



function AddSpellToStack(spellToAdd, spellTarget, options)
	options = options or {}

	if spellToAdd == 'Ranged Attack' then
		spellToAdd = {
			id = 4,
			english = 'Ranged',
			en = 'Ranged',
			prefix = '/ra',
		}
		spellTarget = 't'
	elseif not IsSpellAddable(spellToAdd) then
		return
	elseif type(spellToAdd) ~= 'table' then
		windower.add_to_chat(055, tostring(spellToAdd).." is not a valid spell, use spells/abilities/weaponskill windower resource.")
		return
	end

	if not IsValidTarget(spellTarget) then
		return
	end

	local sanitizedOptions = {
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

function IsSpellAddable(spell)
	if spell.category == 'Usable' then
		return DoesItemExist(spell)
	end

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

	return true
end

windower.raw_register_Event('zone change', function(new_zone, old_zone)
	ClearSpellStack()
	UpdateSpellStackDisplay()
end)