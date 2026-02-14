-- Global spell / utility aliases shared across all profiles.
-- Loaded from gcmage.lua and gcmelee.lua so aliases persist when swapping jobs.

local gcaliases = {}

local STATE_KEY = '__gcaliases_state'
_G[STATE_KEY] = _G[STATE_KEY] or { installed = false }
local state = _G[STATE_KEY]

-- We cannot reliably query the client for all built-in slash command abbreviations.
-- This is a conservative blocklist for the most common FFXI chat/system commands so we
-- avoid overriding expected behavior (e.g. /s for say, /inv for invite).
local ReservedGameAliases = T{
    -- Chat modes / messaging
    's','say','p','party','a','alliance','l','linkshell','ls','l2','linkshell2','sh','shout','yell',
    't','tell','r','reply','em','emote','echo',

    -- Party / system
    'invite','join','leave','kick',

    -- Common system
    'help','logout','shutdown',
}

local function romanNumeral(tier)
    if (tier == 1) then return '' end
    if (tier == 2) then return 'II' end
    if (tier == 3) then return 'III' end
    if (tier == 4) then return 'IV' end
    if (tier == 5) then return 'V' end
    return tostring(tier)
end

local function spellNameWithTier(baseName, tier)
    if (tier == 1) then return baseName end
    return baseName .. ' ' .. romanNumeral(tier)
end

local function spellCommand(spellName, target)
    return '/ma "' .. spellName .. '" ' .. (target or '<t>')
end

function gcaliases.BuildSpellAliases_CoP()
    local aliases = {}

    local function add(alias, name, target)
        table.insert(aliases, { Alias = alias, Command = spellCommand(name, target) })
    end

    -- Core self utility (avoid /s which is Say)
    add('snk', 'Sneak', '<me>')
    add('inv', 'Invisible', '<me>')
    add('deo', 'Deodorize', '<me>')
    add('wp', 'Warp', '<me>')
    add('esc', 'Escape', '<me>')

    -- Elemental magic shorthands (CoP era tiers)
    local elements = {
        { key = 'f',  base = 'Fire',     ga = 'Firaga' },
        { key = 'b',  base = 'Blizzard', ga = 'Blizzaga' },
        { key = 't',  base = 'Thunder',  ga = 'Thundaga' },
        { key = 'a',  base = 'Aero',     ga = 'Aeroga' },
        { key = 'w',  base = 'Water',    ga = 'Waterga' },
        { key = 'st', base = 'Stone',    ga = 'Stonega' },
    }

    for _, e in ipairs(elements) do
        -- Single-target nukes: /f4 -> Fire IV
        for tier = 1, 4 do
            add(e.key .. tostring(tier), spellNameWithTier(e.base, tier), '<t>')
        end

        -- -ga: /tga3 -> Thundaga III
        for tier = 1, 3 do
            add(e.key .. 'ga' .. tostring(tier), spellNameWithTier(e.ga, tier), '<t>')
        end
    end

    -- Ancient Magic (common CoP era nukes)
    add('flr', 'Flare', '<t>')
    add('frz', 'Freeze', '<t>')
    add('brs', 'Burst', '<t>')
    add('fld', 'Flood', '<t>')
    add('qke', 'Quake', '<t>')
    add('trn', 'Tornado', '<t>')

    -- A starter set of common WHM/RDM utility
    add('dsp', 'Dispel', '<t>')
    add('slp', 'Sleep', '<t>')
    add('slp2', 'Sleep II', '<t>')
    add('bind', 'Bind', '<t>')
    add('grav', 'Gravity', '<t>')
    add('stn', 'Stun', '<t>')

    add('hst', 'Haste', '<t>')
    add('rfr', 'Refresh', '<t>')
    add('phl', 'Phalanx', '<t>')
    add('ss', 'Stoneskin', '<me>')
    add('blk', 'Blink', '<me>')
    add('aqv', 'Aquaveil', '<me>')
    add('rr1', 'Reraise', '<me>')

    -- Cures (kept explicit to avoid colliding with common chat shortcuts)
    add('c1', 'Cure', '<t>')
    add('c2', 'Cure II', '<t>')
    add('c3', 'Cure III', '<t>')
    add('c4', 'Cure IV', '<t>')
    add('cga1', 'Curaga', '<t>')
    add('cga2', 'Curaga II', '<t>')
    add('cga3', 'Curaga III', '<t>')

    return aliases
end

local function setAliases(aliasEntries)
    local seen = {}

    for _, entry in ipairs(aliasEntries) do
        local alias = entry.Alias
        local command = entry.Command

        if (alias ~= nil) and (command ~= nil) then
            alias = tostring(alias):lower()

            if (alias:match('^[%w]+$')) and (not ReservedGameAliases:contains(alias)) and (not seen[alias]) then
                seen[alias] = true
                AshitaCore:GetChatManager():QueueCommand(-1, '/alias /' .. alias .. ' ' .. command)
            end
        end
    end
end

local function clearAliases(aliasEntries)
    for _, entry in ipairs(aliasEntries) do
        if (entry.Alias ~= nil) then
            local alias = tostring(entry.Alias):lower()
            if (alias:match('^[%w]+$')) and (not ReservedGameAliases:contains(alias)) then
                AshitaCore:GetChatManager():QueueCommand(-1, '/alias del /' .. alias)
            end
        end
    end
end

function gcaliases.Load(force)
    if (state.installed and not force) then
        return
    end

    local spellAliases = gcaliases.BuildSpellAliases_CoP()
    setAliases(spellAliases)

    state.installed = true
end

-- Only call this if you explicitly want to remove the aliases (not recommended on job swaps).
function gcaliases.Unload(force)
    if (not force) then
        return
    end

    local spellAliases = gcaliases.BuildSpellAliases_CoP()
    clearAliases(spellAliases)

    state.installed = false
end

return gcaliases
