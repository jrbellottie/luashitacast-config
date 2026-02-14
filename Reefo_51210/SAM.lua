local profile = {}

local fastCastValue = 0.00 -- 0% from gear listed in Precast set

local max_hp_in_idle_with_regen_gear_equipped = 0 -- You could set this to 0 if you do not wish to ever use regen gear

-- Comment out the equipment within these sets if you do not have them or do not wish to use them
local myochin_kabuto = {
    Head = 'Myochin Kabuto',
}
local saotome_kote = {
    Hands = 'Saotome Kote',
}

local sets = {
    Idle = {
        -- Main  = 'Stone-splitter',
        Range = 'Lightning Bow +1',
        Ammo = 'Horn Arrow',
        Head  = 'Optical Hat',
        Neck  = 'Peacock Amulet',
        Body  = "Haubergeon",
        Hands = 'Ochiudo\'s Kote',
        Legs  = "Byakko's Haidate",
        Feet  = 'Fuma Sune-Ate',
        Waist = 'Swift Belt',
        Ear1  = 'Brutal Earring',
        Ear2  = 'Ethereal Earring',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
        Back  = 'Forager\'s Mantle',
    },
    IdleALT = {
        -- Main  = 'Stone-splitter',
        Range = 'Ebisu Fishing Rod',
        Ammo  = 'fly lure',
        Head  = 'Merman\'s hairpin',
        Neck  = 'Peacock Amulet',
        Body  = "Elder\'s surcoat",
        Hands = 'Elder\'s Bracers',
        Legs  = "Elder\'s Braguette",
        Feet  = 'Fuma Sune-Ate',
        Waist = 'Desert Rope',
        Ear1  = 'Brutal Earring',
        Ear2  = 'Ethereal Earring',
        Ring1 = 'Carect Ring',
        Ring2 = 'Astral Ring',
        Back  = 'Aurora Mantle',
    },
    Resting = {
    },
    Town = {},
    Movement = {},
    Movement_TP = {},

    DT = {},
    MDT = {},
    FireRes = {},
    IceRes = {},
    LightningRes = {},
    EarthRes = {},
    WindRes = {},
    WaterRes = {},
    Evasion = {},

    Precast = {},
    SIRD = { -- Only used for Idle sets and not while Override sets are active
    },
    Haste = { -- Used for Utsusemi cooldown
        Hands = 'Dusk Gloves',
        Legs  = "Byakko's Haidate",
        Feet  = 'Fuma Sune-Ate',
        Waist = 'Swift Belt',
    },

    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},

    TP_LowAcc = {
        Range = 'Lightning Bow +1',
        Head  = 'Wyvern Helm',
        Neck  = 'Peacock Amulet',
        Body  = "Haubergeon",
        Hands = 'Dusk Gloves',
        Legs  = "Byakko's Haidate",
        Feet  = 'Fuma Sune-Ate',
        Waist = 'Swift Belt',
        Ear1  = 'Brutal Earring',
        Ear2  = 'Ethereal Earring',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
        Back  = 'Forager\'s Mantle',
    },
    TP_Aftermath = {},
    TP_Mjollnir_Haste = {},
    TP_HighAcc = {
        Range = 'Lightning Bow +1',
        Head  = 'Optical Hat',
        Neck  = 'Peacock Amulet',
        Body  = "Haubergeon",
        Hands = 'Dusk Gloves',
        Legs  = "Byakko's Haidate",
        Feet  = 'Fuma Sune-Ate',
        Waist = 'Swift Belt',
        Ear1  = 'Brutal Earring',
        Ear2  = 'Ethereal Earring',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
        Back  = 'Forager\'s Mantle',
    },

    WS = {
        Head  = 'Wyvern Helm',
        Neck  = 'Peacock Amulet',
        Body  = "Haubergeon",
        Hands = 'Ochiudo\'s Kote',
        Legs  = "Byakko's Haidate",
        Feet  = 'Hmn. Sune-Ate',
        Waist = 'Warwolf Belt',
        Ear1  = 'Brutal Earring',
        Ear2  = 'Ethereal Earring',
        Ring1 = 'Flame Ring',
        Ring2 = 'Rajas Ring',
        Back  = 'Forager\'s Mantle',
    },
    WS_HighAcc = {},

    WS_Kaiten = {},

    Weapon_Loadout_1 = {
        Main  = 'Onimaru',
    },
    Weapon_Loadout_2 = {
        Main  = 'Stone-splitter',
    },
    Weapon_Loadout_3 = {},
}

profile.SetMacroBook = function()
    -- AshitaCore:GetChatManager():QueueCommand(1, '/macro book 1')
    -- AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')
end

--[[
--------------------------------
Everything below can be ignored.
--------------------------------
]]

gcmelee = gFunc.LoadFile('common\\gcmelee.lua')

sets.myochin_kabuto = myochin_kabuto
sets.saotome_kote = saotome_kote
profile.Sets = gcmelee.AppendSets(sets)

profile.HandleAbility = function()
    gcmelee.DoAbility()

    local action = gData.GetAction()
    if (action.Name == 'Meditate') then
        gFunc.EquipSet('myochin_kabuto')
        gFunc.EquipSet('saotome_kote')
    end
end

profile.HandleItem = function()
    gcinclude.DoItem()
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
    gcmelee.DoWS()

    local action = gData.GetAction()
    if (action.Name == 'Tachi: Kaiten') then
        gFunc.EquipSet(sets.WS_Kaiten)
    end
end

profile.OnLoad = function()
    gcmelee.Load()
    profile.SetMacroBook()
end

profile.OnUnload = function()
    gcmelee.Unload()
end

profile.HandleCommand = function(args)
    gcmelee.DoCommands(args)

    if (args[1] == 'horizonmode') then
        profile.HandleDefault()
    end
end

profile.HandleDefault = function()
    gcmelee.DoDefault(max_hp_in_idle_with_regen_gear_equipped)
    gcmelee.DoDefaultOverride()
    gFunc.EquipSet(gcinclude.BuildLockableSet(gData.GetEquipment()))
end

profile.HandlePrecast = function()
    gcmelee.DoPrecast(fastCastValue)
end

profile.HandleMidcast = function()
    gcmelee.DoMidcast(sets)
end

return profile
