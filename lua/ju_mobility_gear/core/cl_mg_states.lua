
net.Receive('Ju_UpdateMGState', function()

    local id = net.ReadUInt(7) + 1
    local newState = net.ReadUInt(3)

    local ply = Player(id)
    if !ply or !IsValid(ply) then return end

    local oldState = ply.MGState
    oldPlayerStates[ply] = newState

    ply.MGState = newState

    hook.Run('Ju_MGState_WasChanged', ply, oldState, newState)

end)
