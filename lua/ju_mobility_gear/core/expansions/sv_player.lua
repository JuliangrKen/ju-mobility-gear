
local mg = ju.mobility_gear
local GM = GM or GAMEMODE


util.AddNetworkString 'Ju_UpdateMGState'


local PLAYER = FindMetaTable 'Player'


function PLAYER:SetMGState(newState)

    if !mg.isCorrectMGState(self, newState) then return end

    local oldState = self.MGState or 0

    local can = hook.Run('Ju_MGState_CanChanged', oldState, newState)
    if isbool(can) and !can then
        return
    end

    self.MGState = newState
    hook.Run('Ju_MGState_WasChanged', oldState, newState)

    mg.UpdatePlyMGState(self)

end
