
local PLAYER = FindMetaTable('Player')

function PLAYER:GetMGState()
    return self.MGState or 0
end
