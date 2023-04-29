
local mg = ju.mobility_gear

local function sendNet(ply, sendFunc, ...)

    local id = ply:UserID()
    local state = ply:GetMGState()

    net.Start 'Ju_UpdateMGState'
        net.WriteUInt(id, 8)
        net.WriteUInt(state, 8)
    sendFunc(...)

end

local function isNoValid(client, ply, noCheck)
    return !noCheck 
        and !(IsValid(client) and IsValid(ply))
end

--[[
    Обновляет информацию о MGState игрока у конкретного клиента
]]
function mg.UpdateClientPlyMGState(client, ply, noCheck)
    
    if isNoValid(client, ply, noCheck) then
        return 
    end

    sendNet(client, net.Send, client)

end

--[[
    Обновляет информацию о MGState игрока у самого игрока
]]
function mg.UpdatePlyMGState(ply, noCheck)
    
    mg.UpdateClientPlyMGState(ply, ply, noCheck)

end

--[[
    Обновляет информацию о MGState игрока у всех клиентов
]]
function mg.UpdateAllClientPlyMGState(ply, noCheck)
    
    if isNoValid(client, ply, noCheck) then
        return 
    end

    sendNet(client, net.Broadcast)

end
