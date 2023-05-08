
local GM = GM or GAMEMODE

local mg = ju.mobility_gear
local cfg = mg.cfg
local classes = mg.classes

util.AddNetworkString 'Ju_UpdateMGState'


local PLAYER = FindMetaTable 'Player'


function PLAYER:SetMGState(newState)

    if !mg.isCorrectMGState(self, newState) then return end

    local oldState = self:GetMGState()

    local can = hook.Run('Ju_MGState_CanChanged', self, oldState, newState)
    if isbool(can) and !can then
        return
    end

    self.MGState = newState
    hook.Run('Ju_MGState_WasChanged', self, oldState, newState)

    mg.UpdatePlyMGState(self)

end


function PLAYER:UpdateTBPos(num, distCenter, slopeDist, vectorFunc)

    distCenter, slopeDist = distCenter or cfg.maxLength - cfg.minLength, slopeDist or cfg.defaultSlopeDist

    self['TB' .. num]:SetPos(self:LocalToWorld(vectorFunc(distCenter, slopeDist)))

end

function PLAYER:UpdateTB1Pos(distCenter, slopeDist)
    
    self:UpdateTBPos(1, distCenter, slopeDist, function(distCenter, slopeDist)
        
        return Vector(distCenter, slopeDist, 0)

    end)

end

function PLAYER:UpdateTB2Pos(distCenter, slopeDist)
    
    self:UpdateTBPos(2, distCenter, slopeDist, function(distCenter, slopeDist)
        
        return Vector(distCenter, - slopeDist, 0)

    end)

end


function PLAYER:UpdateTB(num, minDist, maxDist, updateFunc)

    self.traceBombMinDist = minDist or self.traceBombMinDist or cfg.minLength
    self.traceBombMaxDist = maxDist or self.traceBombMaxDist or cfg.maxLength

    local radius = (self.traceBombMinDist - self.traceBombMaxDist) / 2

    local tbName = 'TB' .. num
    local tb = self[tbName]

    if !tb then
        
        self[tbName] = classes.trace_bomb:new()
        return

    end

    tb:SetRadius(radius)

    updateFunc()

end

function PLAYER:UpdateTB1(minDist, maxDist)
    
    self:UpdateTB(1, minDist, maxDist, function()
        
        self:UpdateTB1Pos()

    end)

end

function PLAYER:UpdateTB2(minDist, maxDist)
    
    self:UpdateTB(2, minDist, maxDist, function()
        
        self:UpdateTB2Pos()

    end)

end


function PLAYER:GetHookDots()

    self:UpdateTB1()
    self:UpdateTB2()

    local trace1 = self.TB1:Boom()
    local trace2 = self.TB2:Boom()

    return trace1, trace2

end
