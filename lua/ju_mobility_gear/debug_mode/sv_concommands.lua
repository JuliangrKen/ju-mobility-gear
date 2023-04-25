local string = string
local lower = string.lower
local find = string.find
local player = player
local getByID = Player
local getBySteamID64 = player.GetBySteamID64
local getBySteamID = player.GetBySteamID

local getByNick = function(str)
    
    str = lower(str)

    for k, v in ipairs(player.GetAll()) do
        if find(lower(v:Nick()), str) then
            return v
        end
    end

    return false
    
end

local function getPly(plyArg)
    
    local ply

    if isnumber(plyArg) then
        
        ply = getByID(plyArg)
        ply = ply or getBySteamID64(plyArg)

        return ply

    end

    if isstring(plyArg) then
        
        ply = getByNick(plyArg)

    end

    return ply

end

concommand.Add('ju_ply_set_mg_state', function(ply, cmd, args, argStr)
    
    local plyArg = args[1]
    
    local valueArg = tonumber(args[2])
    if !valueArg then print 'invalid value' return end

    local ply = getPly(plyArg)
    if !ply then print 'invalid player' return end

    ply:SetMGState(valueArg)
    print 'OK'

end)

concommand.Add('ju_ply_get_mg_state', function(ply, cmd, args, argStr)

    local ply = getPly(args[1])
    if !ply then print 'invalid player' return end
    
    print(ply:Nick() .. ' MG State: ' .. ply:GetMGState())

end)