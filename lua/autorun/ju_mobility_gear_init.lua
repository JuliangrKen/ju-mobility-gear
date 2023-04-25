
-- by Julik#8946

-- addon global tables

ju = ju or {}
ju.mobility_gear = ju.mobility_gear or {}
ju.mobility_gear.cfg = ju.mobility_gear.cfg or {}

-- include functions:

local rDir = 'ju_mobility_gear/'

local addSv = SERVER and include or function() end
local addCl = SERVER and AddCSLuaFile or include
local addSh = function(...)
    addSv(...)
    addCl(...)
end

local addFile = function(name, dir)
    local prefix = string.Left(name, 3)
    local path = dir..name

    if prefix == 'sv_' then
        addSv(path)
        return
    end

    if prefix == 'cl_' then
        addCl(path)
        return
    end

    addSh(path)
end

local addDir = function(name)
    local dir = rDir..name..'/'
    local files, _ = file.Find(dir..'*', 'LUA')
    
    for _, v in ipairs(files) do
        if !string.EndsWith(v, '.lua') then return end
        addFile(v, dir)
    end
end

-- includes functions:

addSh(rDir..'/cfg.lua')
addDir 'core'

if ju.mobility_gear.cfg.debug then
    addDir 'debug_mode'
end

-- Hello msg:
MsgC(Color(134, 223, 201), '\n~~~\tJuliandrKen (Julik#8946) Mobility Gear was loaded. Eat the titan!\t~~~\n')
