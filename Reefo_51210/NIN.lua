local profile = {}

local fastCastValue = 0.00 -- 0% from gear listed in Precast set

local max_hp_in_idle_with_regen_gear_equipped = 0 -- Set to 0 to never use regen gear

-- Elemental staves (Horizon item names as shown in your inventory)
local fire_staff = { Main = 'Fire Staff', }
local earth_staff = { Main = 'Earth Staff', }
local water_staff = { Main = 'Water Staff', }
local wind_staff = { Main = 'Wind Staff', }
local ice_staff = { Main = 'Ice Staff', }
local thunder_staff = { Main = 'Thunder Staff', }
local light_staff = { Main = 'Light Staff', }
local dark_staff = { Main = 'Dark Staff', }

-- Obis (leave commented if not owned)
local karin_obi = { -- Waist = 'Karin Obi',
}
local dorin_obi = { -- Waist = 'Dorin Obi',
}
local suirin_obi = { -- Waist = 'Suirin Obi',
}
local furin_obi = { -- Waist = 'Furin Obi',
}
local hyorin_obi = { -- Waist = 'Hyorin Obi',
}
local rairin_obi = { -- Waist = 'Rairin Obi',
}
local korin_obi = { -- Waist = 'Korin Obi',
}
local anrin_obi = { -- Waist = 'Anrin obi',
}

-- Optional utility pieces (comment out if not owned / not desired)
local shinobi_ring = { -- Ring2 = 'Shinobi Ring',
}
local koga_tekko = { -- Hands = 'Koga Tekko',
}
local koga_tekko_plus_one = { -- Hands = 'Kog. Tekko +1',
}
local uggalepih_pendant = { -- Neck = 'Uggalepih Pendant',
}
local warlocks_mantle = { -- Back = 'Warlock\'s Mantle',
}
local fenrirs_stone = { -- Ammo = 'Fenrir\'s Stone',
}

local koga_hakama = { Legs = 'Koga Hakama', }
local koga_hakama_plus_one = { -- Legs = 'Kog. Hakama +1',
}

local sets = {
    -- Idle families used by gcmelee:
    Idle = {
        Main  = 'Senjuinrikio',
        Sub   = 'Fudo',
        Ammo  = 'Bomb core',
        Head  = 'Optical Hat',
        Neck  = 'Peacock Amulet',
        Body  = "Haubergeon",
        Hands = 'Ochiudo\'s Kote',
        Legs  = "Byakko's Haidate",
        Feet  = 'Ninja Kyahan',
        Waist = 'Koga Sarashi',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Ethereal Earring',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
        Back  = 'Forager\'s Mantle',
    },
    IdleALT = {
        Main  = 'Senjuinrikio',
        Sub   = 'Fudo',
        Range = 'Ebisu Fishing Rod',
        Ammo  = 'fly lure',
        Head  = 'Merman\'s hairpin',
        Neck  = 'Peacock Amulet',
        Body  = "Elder\'s surcoat",
        Hands = 'Elder\'s Bracers',
        Legs  = "Elder\'s Braguette",
        Feet  = 'Ninja Kyahan',
        Waist = 'Desert Rope',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Ethereal Earring',
        Ring1 = 'Carect Ring',
        Ring2 = 'Astral Ring',
        Back  = 'Aurora Mantle',
    },
    IdleDT = { 
        Main  = 'Earth Staff',
        Ammo  = 'Happy Egg',
        Neck  = 'Evasion Torque',
        Body  = "Arhat's Gi",
        Legs  = "Arhat's Hakama +1",
        Waist = 'Koga Sarashi',
        Back  = 'Gigant Mantle',
    },
    IdleALTDT = { -- Optional alternate DT idle
    },
    Resting = {
        Main = 'Dark Staff',
    },
    Town = { -- Optional: use this for cities
    },
    Movement = { -- Optional: movement-only override (leave empty unless you want different)
    },
    Movement_TP = { -- Optional: movement while engaged
    },

    -- Defensive / resist / utility sets (optional)
    DT = { -- Optional engaged DT override
    },
    MDT = { -- Optional magic DT override
    },
    FireRes = {},
    IceRes = {},
    LightningRes = {},
    EarthRes = {},
    WindRes = {},
    WaterRes = {},
    Evasion = {
        Main  = 'Senjuinrikio',
        Sub   = 'Fudo',
        Ammo  = 'Happy Egg',
        Head  = 'Optical Hat',
        Neck  = 'Evasion Torque',
        Body  = "Scorpion Harness",
        Hands = 'Rasetsu Tekko',
        Legs  = "Koga Hakama",
        Feet  = 'Ninja Kyahan',
        Waist = 'Koga Sarashi',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Ethereal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'emerald Ring',
        Back  = 'Gigant Mantle',
    },

    -- Casting buckets used by gcmelee:
    Precast = { -- Fast cast / quick gear (kept empty for now)
    },
    SIRD = { -- Spell interruption rate down for idle (optional)
    },
    Haste = { -- Used for Utsusemi cooldown / general haste on casting
        Head  = 'Panther Mask',
        Neck  = 'Evasion Torque',
        Body  = "Arhat's Gi",
        Hands = 'Dusk Gloves',
        Legs  = "Byakko's Haidate",
        Feet  = 'Fuma Sune-Ate',
        Waist = 'Koga Sarashi',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Ethereal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Emerald Ring',
        Back  = 'Gigant Mantle',
    },

    Hate = { -- Enmity / snap hate (optional)
    },
    NinDebuff = { -- Ninjutsu enfeebles
        Head  = 'Panther Mask',
        Neck  = 'Evasion Torque',
        Body  = 'Ninja Chainmail',
        Hands = 'Dusk Gloves',
        Legs  = "Byakko's Haidate",
        Feet  = 'Fuma Sune-Ate',
        Waist = 'Koga Sarashi',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Brutal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Toreador\'s Ring',
        Back  = 'Forager\'s Mantle',
    },
    NinElemental = { -- Ninjutsu nukes
        Head  = 'Panther Mask',
        Neck  = 'Peacock Amulet',
        Body  = 'Ninja Chainmail',
        Hands = 'Dusk Gloves',
        Legs  = "Byakko's Haidate",
        Feet  = 'Fuma Sune-Ate',
        Waist = 'Koga Sarashi',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Brutal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Toreador\'s Ring',
        Back  = 'Forager\'s Mantle',
    },
    NinElemental_Accuracy = { -- If you toggle Nuke=Accuracy
        Head  = 'Ninja Hatsuburi',
        Neck  = 'Peacock Amulet',
        Body  = 'Ninja Chainmail',
        Hands = 'Dusk Gloves',
        Legs  = "Byakko's Haidate",
        Feet  = 'Fuma Sune-Ate',
        Waist = 'Koga Sarashi',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Brutal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Toreador\'s Ring',
        Back  = 'Forager\'s Mantle',
    },
    DrkDarkMagic = {},

    Enhancing = {},
    Cure = {},
    Flash = {},

    -- Lock sets (optional)
    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},

    -- Melee engaged sets used by gcmelee:
    TP_LowAcc = { -- Your default TP
        Main  = 'Senjuinrikio',
        Sub   = 'Fudo',
        Ammo  = 'Bomb core',
        Head  = 'Panther Mask',
        Neck  = 'Peacock Amulet',
        Body  = 'Ninja Chainmail',
        Hands = 'Dusk Gloves',
        Legs  = "Byakko's Haidate",
        Feet  = 'Fuma Sune-Ate',
        Waist = 'Koga Sarashi',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Brutal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Toreador\'s Ring',
        Back  = 'Forager\'s Mantle',
    },
    TP_Aftermath = { -- Optional aftermath variant
    },
    TP_Mjollnir_Haste = { -- Not applicable; leave empty
    },
    TP_HighAcc = { -- High accuracy option (swap in Optical Hat)
        Main  = 'Senjuinrikio',
        Sub   = 'Fudo',
        Ammo  = 'Bailathorn',
        Head  = 'Optical Hat',
        Neck  = 'Peacock Amulet',
        Body  = 'Haubergeon',
        Hands = 'Dusk Gloves',
        Legs  = "Byakko's Haidate",
        Feet  = 'Fuma Sune-Ate',
        Waist = 'Koga Sarashi',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Brutal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Toreador\'s Ring',
        Back  = 'Forager\'s Mantle',
    },

    -- Generic WS buckets
    WS = { -- Generic physical WS
        Head  = 'Optical Hat',
        Neck  = 'Peacock Amulet',
        Body  = 'Haubergeon',
        Hands = 'Ochiudo\'s Kote',
        Legs  = "Byakko's Haidate",
        Feet  = 'Alumine Sollerets',
        Waist = 'Warwolf Belt',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Brutal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Flame Ring',
        Back  = 'Forager\'s Mantle',
    },
    WS_HighAcc = { -- Optional WS high acc
    },

    -- Specific WS routing already exists in template for Blade: Jin and Blade: Ku
    WS_BladeJin = {
        Head  = 'Optical Hat',
        Neck  = 'Peacock Amulet',
        Body  = 'Haubergeon',
        Hands = 'Ochiudo\'s Kote',
        Legs  = "Byakko's Haidate",
        Feet  = 'Alumine Sollerets',
        Waist = 'Warwolf Belt',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Brutal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Flame Ring',
        Back  = 'Forager\'s Mantle',
    },
    WS_BladeKu = {
        Head  = 'Optical Hat',
        Neck  = 'Peacock Amulet',
        Body  = 'Haubergeon',
        Hands = 'Ochiudo\'s Kote',
        Legs  = "Byakko's Haidate",
        Feet  = 'Alumine Sollerets',
        Waist = 'Warwolf Belt',
        Ear1  = 'Suppanomimi',
        Ear2  = 'Brutal Earring',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Flame Ring',
        Back  = 'Forager\'s Mantle',
    },

    Ranged = {},
    Weapon_Loadout_1 = {
        Main  = 'Senjuinrikio',
        Sub   = 'Fudo',
    },
    Weapon_Loadout_2 = {
        Main  = 'Earth Staff',
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

sets.fire_staff = fire_staff
sets.earth_staff = earth_staff
sets.water_staff = water_staff
sets.wind_staff = wind_staff
sets.ice_staff = ice_staff
sets.thunder_staff = thunder_staff
sets.light_staff = light_staff
sets.dark_staff = dark_staff
sets.karin_obi = karin_obi
sets.dorin_obi = dorin_obi
sets.suirin_obi = suirin_obi
sets.furin_obi = furin_obi
sets.hyorin_obi = hyorin_obi
sets.rairin_obi = rairin_obi
sets.korin_obi = korin_obi
sets.anrin_obi = anrin_obi
sets.shinobi_ring = shinobi_ring
sets.koga_tekko = koga_tekko
sets.koga_tekko_plus_one = koga_tekko_plus_one
sets.uggalepih_pendant = uggalepih_pendant
sets.warlocks_mantle = warlocks_mantle
sets.fenrirs_stone = fenrirs_stone
sets.koga_hakama = koga_hakama
sets.koga_hakama_plus_one = koga_hakama_plus_one
profile.Sets = gcmelee.AppendSets(sets)

local NinDebuffs = T{ 'Kurayami: Ni', 'Hojo: Ni', 'Jubaku: Ichi', 'Dokumori: Ichi', 'Kurayami: Ichi', 'Hojo: Ichi' }
local HateDebuffs = T{ 'Bind', 'Sleep', 'Poison', 'Blind' }
local DrkDarkMagic = T{ 'Stun', 'Aspir', 'Drain', 'Absorb-AGI', 'Absorb-VIT' }
local NinElemental = T{
    'Hyoton: Ni', 'Katon: Ni', 'Huton: Ni', 'Doton: Ni', 'Raiton: Ni', 'Suiton: Ni',
    'Hyoton: Ichi', 'Katon: Ichi', 'Huton: Ichi', 'Doton: Ichi', 'Raiton: Ichi', 'Suiton: Ichi',
    'Hyoton: San', 'Katon: San', 'Huton: San', 'Doton: San', 'Raiton: San', 'Suiton: San'
}

local ElementalStaffTable = {
    ['Fire'] = 'fire_staff',
    ['Earth'] = 'earth_staff',
    ['Water'] = 'water_staff',
    ['Wind'] = 'wind_staff',
    ['Ice'] = 'ice_staff',
    ['Thunder'] = 'thunder_staff',
    ['Light'] = 'light_staff',
    ['Dark'] = 'dark_staff'
}

local NukeObiOwnedTable = {
    ['Fire'] = 'karin_obi',
    ['Earth'] = 'dorin_obi',
    ['Water'] = 'suirin_obi',
    ['Wind'] = 'furin_obi',
    ['Ice'] = 'hyorin_obi',
    ['Thunder'] = 'rairin_obi',
    ['Light'] = 'korin_obi',
    ['Dark'] = 'anrin_obi'
}

local WeakElementTable = {
    ['Fire'] = 'Water',
    ['Earth'] = 'Wind',
    ['Water'] = 'Thunder',
    ['Wind'] = 'Ice',
    ['Ice'] = 'Fire',
    ['Thunder'] = 'Earth',
    ['Light'] = 'Dark',
    ['Dark'] = 'Light'
}

profile.HandleAbility = function()
    gcmelee.DoAbility()
    gFunc.EquipSet(sets.Hate)
end

profile.HandleItem = function()
    gcinclude.DoItem()
end

profile.HandlePreshot = function()
    gFunc.EquipSet(sets.Ranged)
end

profile.HandleMidshot = function()
    gFunc.EquipSet(sets.Ranged)
end

profile.HandleWeaponskill = function()
    gcmelee.DoWS()

    local action = gData.GetAction()
    if (action.Name == 'Blade: Jin') then
        gFunc.EquipSet(sets.WS_BladeJin)
    elseif (action.Name == 'Blade: Ku') then
        gFunc.EquipSet(sets.WS_BladeKu)
    else
        gFunc.EquipSet(sets.WS)
    end

    local environment = gData.GetEnvironment()
    if (environment.Time < 6 or environment.Time >= 18) then
        gFunc.EquipSet('koga_tekko')
    end
    if (environment.Time < 7 or environment.Time >= 17) then
        gFunc.EquipSet('koga_tekko_plus_one')
    end
end

profile.OnLoad = function()
    gcinclude.SetAlias(T{'nuke'})
    gcdisplay.CreateCycle('Nuke', {[1] = 'Potency', [2] = 'Accuracy',})
    gcinclude.SetAlias(T{'staff'})
    gcdisplay.CreateCycle('Staff', {[1] = 'Enabled', [2] = 'Disabled',})
    gcmelee.Load()
    profile.SetMacroBook()
end

profile.OnUnload = function()
    gcmelee.Unload()
    gcinclude.ClearAlias(T{'nuke'})
    gcinclude.ClearAlias(T{'staff'})
end

profile.HandleCommand = function(args)
    if (args[1] == 'nuke') then
        gcdisplay.AdvanceCycle('Nuke')
        gcinclude.Message('Nuke', gcdisplay.GetCycle('Nuke'))
    elseif (args[1] == 'staff') then
        gcdisplay.AdvanceCycle('Staff')
        gcinclude.Message('Staff', gcdisplay.GetCycle('Staff'))
    else
        gcmelee.DoCommands(args)
    end

    if (args[1] == 'horizonmode') then
        profile.HandleDefault()
    end
end

profile.HandleDefault = function()
    gcmelee.DoDefault(max_hp_in_idle_with_regen_gear_equipped)

    local player = gData.GetPlayer()
    local environment = gData.GetEnvironment()

    if (player.Status == 'Engaged') then
        if (player.HPP <= 75 and player.TP <= 1000) then
            gFunc.EquipSet('shinobi_ring')
        end
        if (environment.Time < 6 or environment.Time >= 18) then
            gFunc.EquipSet('koga_tekko')
        end
        if (environment.Time < 7 or environment.Time >= 17) then
            gFunc.EquipSet('koga_tekko_plus_one')
        end
    end

    gcmelee.DoDefaultOverride()

    if (gcdisplay.IdleSet == 'Evasion') then
        if (environment.Time < 6 or environment.Time >= 18) then
            gFunc.EquipSet('fenrirs_stone')
        end
        if (environment.Time < 6 or environment.Time >= 18) then
            gFunc.EquipSet('koga_hakama')
        end
        if (environment.Time < 7 or environment.Time >= 17) then
            gFunc.EquipSet('koga_hakama_plus_one')
        end
    end

    gFunc.EquipSet(gcinclude.BuildLockableSet(gData.GetEquipment()))
end

profile.HandlePrecast = function()
    local player = gData.GetPlayer()
    if (player.SubJob == 'RDM' and warlocks_mantle.Back) then
        gcmelee.DoPrecast(fastCastValue + 0.02)
        gFunc.EquipSet('warlocks_mantle')
    else
        gcmelee.DoPrecast(fastCastValue)
    end
end

profile.HandleMidcast = function()
    gcmelee.DoMidcast(sets)

    local player = gData.GetPlayer()
    local environment = gData.GetEnvironment()

    if (player.HPP <= 75 and player.TP <= 1000) then
        gFunc.EquipSet('shinobi_ring')
    end
    if (environment.Time < 6 or environment.Time >= 18) then
        gFunc.EquipSet('koga_tekko')
    end
    if (environment.Time < 7 or environment.Time >= 17) then
        gFunc.EquipSet('koga_tekko_plus_one')
    end

    local action = gData.GetAction()
    if (action.Skill == 'Ninjutsu') then
        if (NinDebuffs:contains(action.Name)) then
            gFunc.EquipSet(sets.NinDebuff)
            EquipStaffAndObi(action)
        elseif (NinElemental:contains(action.Name)) then
            gFunc.EquipSet(sets.NinElemental)
            if (gcdisplay.GetCycle('Nuke') == 'Accuracy') then
                gFunc.EquipSet(sets.NinElemental_Accuracy)
            end
            if (action.MppAftercast < 51) then
                gFunc.EquipSet('uggalepih_pendant')
            end
            EquipStaffAndObi(action)
        end
    elseif (action.Skill == 'Enfeebling Magic') then
        if (HateDebuffs:contains(action.Name)) then
            gFunc.EquipSet(sets.Hate)
        end
        EquipStaff(action)
    elseif (action.Skill == 'Dark Magic') then
        if (DrkDarkMagic:contains(action.Name)) then
            gFunc.EquipSet(sets.DrkDarkMagic)
        end
        EquipStaffAndObi(action)
    elseif (action.Skill == 'Enhancing Magic') then
        gFunc.EquipSet(sets.Enhancing)
    elseif (action.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Cure)
    elseif (action.Skill == 'Divine Magic') then
        gFunc.EquipSet(sets.Hate)
        gFunc.EquipSet(sets.Haste)
        gFunc.EquipSet(sets.Flash)
    end
end

function EquipStaffAndObi(action)
    EquipStaff(action)

    if (ObiCheck(action)) then
        local obiOwned = NukeObiOwnedTable[action.Element]
        gFunc.EquipSet(obiOwned)
    end
end

function EquipStaff(action)
    if (gcdisplay.GetCycle('Staff') == 'Enabled') then
        local staff = ElementalStaffTable[action.Element]
        gFunc.EquipSet(staff)
    end
end

function ObiCheck(action)
    local element = action.Element
    local environment = gData.GetEnvironment()
    local weakElement = WeakElementTable[element]

    if environment.WeatherElement == element then
        return environment.Weather:match('x2') or environment.DayElement ~= weakElement
    end

    return environment.DayElement == element and environment.WeatherElement ~= weakElement
end

return profile
