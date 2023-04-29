
-- MG States - список возможных состояний, которые переживает игрок с УПМ.

local MG_STATES_NAMES = {}

-- Значение по умолчанию. Оружие не выбрано, возможность использовать УПМ отсутствует.
MG_STATES_NAMES.NONE = 0

-- Оружие взято, но игрок не активировал УПМ мод.
MG_STATES_NAMES.PASSIVE = 1

-- Оружие активировано, но игрок не находится в полёте.
MG_STATES_NAMES.ACTIVE = 2

-- Крюк в данный момент подрекплён, но игрок ещё не начал полёт
MG_STATES_NAMES.HOOK_PULLS = 3

-- Игрок находится в состоянии полёта, но крюки не прикреплены к объектам вокруг
MG_STATES_NAMES.FLIGHT = 4

-- Крюк в данный момент подрекплён и игрок находится в полёте
MG_STATES_NAMES.FLIGHT_AND_HOOK_PULLS = 5


local MG_STATES = {}
for k, v in pairs(MG_STATES_NAMES) do
    MG_STATES[v] = k
end


local mg = ju.mobility_gear

local isstring = isstring
local string = string
local upper = string.upper

--[[
    Проверяет, является ли данный тип данных MG State
        ! nil возвращает false !
]]
function mg.isMGState(argument)

    if !argument then return false end

    if isstring(argument) then
        return MG_STATES_NAMES[upper(argument)] != nil
    end
    
    if isnumber(argument) then
        return MG_STATES[argument] != nil
    end

    return false

end

--[[
    Проверяет корректность MG State при смене его у игрока
]]
function mg.isCorrectMGState(player, newState)

    return
        newState 
        and mg.isMGState(newState)
        and player.MGState != newState

end
