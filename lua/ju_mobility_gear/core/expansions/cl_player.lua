
local mg = ju.mobility_gear
local GM = GM or GAMEMODE

local PLAYER = FindMetaTable('Player')

net.Receive('Ju_UpdateMGState', function()

    local id = net.ReadUInt(8)
    local state = net.ReadUInt(8)

    local ply = Player(id)
    if !ply or !IsValid(ply) then return end

    ply.MGState = state

end)
