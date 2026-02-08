local profile = {}

local state = {
    mode = 'tp',
    idle = 'normal',
    wsName = '',
}

local function equip(set)
    if (set ~= nil) then
        gFunc.EquipSet(set)
    end
end

local function status()
    local p = gData.GetPlayer()
    return (p ~= nil and p.Status) or 'Idle'
end

local function isResting()
    local p = gData.GetPlayer()
    return (p ~= nil and p.Status == 'Resting')
end

local function action()
    return gData.GetAction()
end

local function lower(s)
    if s == nil then return '' end
    return string.lower(s)
end

local function startsWith(s, prefix)
    s = s or ''
    prefix = prefix or ''
    return string.sub(s, 1, #prefix) == prefix
end

local sets = {
    IdlePDT = {
        Main  = 'Earth Staff',
        Neck  = 'Evasion Torque',
        Body  = "Arhat's Gi",
        Legs  = "Arhat's Hakama +1",
        Waist = 'Koga Sarashi',
        Back  = 'Gigant Mantle',
    },

    Idle = {
        Main  = 'Senjuinrikio',
        Sub   = 'Fudo',
        Ammo  = 'Bailathorn',
        Head  = 'Optical Hat',
        Neck  = 'Peacock Amulet',
        Body  = "Arhat's Gi",
        Hands = 'Rasetsu Tekko',
        Legs  = "Arhat's Hakama +1",
        Feet  = 'Ninja Kyahan',
        Waist = 'Koga Sarashi',
        Back  = 'Gigant Mantle',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Ethereal Earring',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
        Back  = 'Gigant Mantle',
    },

    Resting = {
        Main = 'Dark Staff',
        Neck = 'Peacock Amulet',
    },

    TP = {
        Main  = 'Senjuinrikio',
        Sub   = 'Fudo',
        Ammo  = 'Bailathorn',
        Head  = 'Panther Mask',
        Neck  = 'Peacock Amulet',
        Body  = 'Ninja Chainmail',
        Hands = 'Rasetsu Tekko',
        Legs  = 'Koga Hakama',
        Feet  = 'Fuma Sune-Ate',
        Waist = 'Koga Sarashi',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Brutal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Toreador\'s Ring',
        Back  = 'Forager\'s Mantle',
    },

    Haste = {
        Main  = 'Senjuinrikio',
        Sub   = 'Fudo',
        Ammo  = 'Bailathorn',
        Head  = 'Panther Mask',
        Neck  = 'Peacock Amulet',
        Body  = 'Ninja Chainmail',
        Hands = 'Rasetsu Tekko',
        Legs  = 'Koga Hakama',
        Feet  = 'Fuma Sune-Ate',
        Waist = 'Koga Sarashi',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Brutal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Toreador\'s Ring',
        Back  = 'Forager\'s Mantle',
    },

    DPS = {
        Main  = 'Senjuinrikio',
        Sub   = 'Fudo',
        Ammo  = 'Bailathorn',
        Head  = 'Optical Hat',
        Neck  = 'Peacock Amulet',
        Body  = 'Haubergeon',
        Hands = 'Rasetsu Tekko',
        Legs  = 'Ryl.Kgt. Breeches',
        Feet  = 'Alumine Sollerets',
        Waist = 'Warwolf Belt',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Brutal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Toreador\'s Ring',
        Back  = 'Forager\'s Mantle',
    },

    Evasion = {
        Main  = 'Senjuinrikio',
        Sub   = 'Fudo',
        Ammo  = 'Happy Egg',
        Head  = 'Optical Hat',
        Neck  = 'Evasion Torque',
        Body  = "Arhat's Gi",
        Hands = 'Rasetsu Tekko',
        Legs  = "Arhat's Hakama +1",
        Feet  = 'Ninja Kyahan',
        Waist = 'Koga Sarashi',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Ethereal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Jadeite Ring',
        Back  = 'Gigant Mantle',
    },

    WS = {
        Head  = 'Optical Hat',
        Neck  = 'Peacock Amulet',
        Body  = 'Haubergeon',
        Hands = 'Rasetsu Tekko',
        Legs  = 'Ryl.Kgt. Breeches',
        Feet  = 'Alumine Sollerets',
        Waist = 'Warwolf Belt',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Brutal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Toreador\'s Ring',
        Back  = 'Forager\'s Mantle',
    },

    Utsusemi = {
        Head  = 'Panther Mask',
        Neck  = 'Evasion Torque',
        Body  = 'Arhat\'s Gi',
        Hands = 'Rasetsu Tekko',
        Legs  = 'Arhat\'s Hakama +1',
        Feet  = 'Fuma Sune-Ate',
        Waist = 'Koga Sarashi',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Ethereal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Jadeite Ring',
        Back  = 'Gigant Mantle',
    },
}

profile.HandleCommand = function(args)
    if (args == nil or #args == 0) then
        return
    end

    local a1 = lower(args[1])

    if (a1 == 'set' and #args >= 3) then
        local a2 = lower(args[2])
        local a3 = lower(args[3])

        if (a2 == 'mode') then
            if (a3 == 'tp' or a3 == 'haste' or a3 == 'dps' or a3 == 'evasion' or a3 == 'pdt') then
                state.mode = a3
                print(string.format('[LAC] mode = %s', state.mode))
            end
            return
        end

        if (a2 == 'idle') then
            if (a3 == 'normal' or a3 == 'pdt') then
                state.idle = a3
                print(string.format('[LAC] idle = %s', state.idle))
            end
            return
        end

        if (a2 == 'ws') then
            local ws = table.concat(args, ' ', 3)
            state.wsName = ws
            print(string.format('[LAC] wsName = %s', state.wsName))
            return
        end
    end
end

local function equipIdle()
    if (state.idle == 'pdt') then
        equip(sets.IdlePDT)
        return
    end

    if (isResting()) then
        equip(sets.Resting)
        return
    end

    equip(sets.Idle)
end

local function equipEngaged()
    if (state.mode == 'pdt') then
        equip(sets.IdlePDT)
        return
    end

    if (state.mode == 'haste') then
        equip(sets.Haste)
    elseif (state.mode == 'dps') then
        equip(sets.DPS)
    elseif (state.mode == 'evasion') then
        equip(sets.Evasion)
    else
        equip(sets.TP)
    end
end

profile.OnLoad = function() end
profile.OnUnload = function() end

profile.HandleDefault = function()
    if (status() == 'Engaged') then
        equipEngaged()
    else
        equipIdle()
    end
end

profile.HandlePrecast = function()
    local act = action()
    if (act == nil) then return end

    local name = act.Name or ''
    local typ  = act.ActionType or ''

    if (typ == 'Weaponskill') then
        equip(sets.WS)
        state.wsName = name
        return
    end

    if (typ == 'Magic') then
        if (startsWith(name, 'Utsusemi')) then
            equip(sets.Utsusemi)
            return
        end
    end
end

profile.HandleMidcast = function() end

profile.HandleAbility = function()
    profile.HandleDefault()
end

profile.HandleWeaponSkill = function()
    equip(sets.WS)
end

profile.HandleAftercast = function()
    profile.HandleDefault()
end

profile.HandleStatusChange = function()
    profile.HandleDefault()
end

return profile
