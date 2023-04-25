
local mg = ju.mobility_gear
local GM = GM or GAMEMODE


util.AddNetworkString 'Ju_UpdateMGState'


local PLAYER = FindMetaTable('Player')


function PLAYER:UpdateClientMGState(state, ply, noCheck)
    
    state = state or self.MGState

    if !noCheck and !mg.isCorrectMGState(self, state) then return end

    ply = ply or self

    print(ply:UserID())

    net.Start 'Ju_UpdateMGState'
        net.WriteUInt(ply:UserID(), 8)
        net.WriteUInt(state, 8)
    net.Send(self)

end

function PLAYER:SetMGState(newState)

    if !mg.isCorrectMGState(self, newState) then return end

    local oldState = self.MGState or 0

    hook.Call('Ju_MGState_PreChanged', GM, self, oldState, newState)

    self.MGState = newState

    hook.Call('Ju_MGState_WasChanged', GM, self, oldState, newState)

    self:UpdateClientMGState(nil, nil, true)

end
