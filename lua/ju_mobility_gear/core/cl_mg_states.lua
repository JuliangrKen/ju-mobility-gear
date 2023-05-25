
local oldPlayerStates = {}

net.Receive('Ju_UpdateMGState', function()

    local id = net.ReadUInt(8)
    local newState = net.ReadUInt(8)

    local ply = Player(id)
    
    local oldState = oldPlayerStates[ply]
    oldPlayerStates[ply] = newState

    hook.Run('Ju_MGState_WasChanged', ply, oldState, newState)

end)
