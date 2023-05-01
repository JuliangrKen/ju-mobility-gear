
local CurTime = CurTime
local math = math
local random = math.random
local Vector = Vector
local Angle = Angle

local mg = ju.mobility_gear

local function getDataFromMV(mv)

    local angle = mv:GetMoveAngles()
    local position = mv:GetOrigin()
    local velocity = mv:GetVelocity()

    return angle, position, velocity

end

local function updateMVData(mv, angle, position, velocity)

    mv:SetMoveAngles(angle)
	mv:SetOrigin(position)
    mv:SetVelocity(velocity)

end

local function moveWithMG(ply, mv)

    print 'moveWithMG'

end

local jumpCooldown = 3
local minJumpBoost = 128
local maxJumpBoost = 256

local function moveWithMGMode(ply, mv)
    
    local angle, position, velocity = getDataFromMV(mv)

    if !(mv:KeyDown(IN_JUMP) and mv:KeyDown(IN_SPEED)) then return end

    if CurTime() - (ply.lastMGJump or 0) < jumpCooldown then return end
    ply.lastMGJump = CurTime()

    velocity = Vector(0, 0, 1) * random(minJumpBoost, maxJumpBoost)

    updateMVData(mv, angle, position, velocity)

    ply:SetMGState(4)

end

local function pushWithHooks(ply, mv)
    
    print 'pushWithHooks'

end

local function fly(ply, mv)
    
    local angle, position, velocity = getDataFromMV(mv)

    mv:SetMoveAngles(angle)
	mv:SetOrigin(position)
    mv:SetVelocity(velocity)



end

local function flyWithHooks(ply, mv)
    
    print 'flyWithHooks'

end

local switchTable = {
    -- PASSIVE
    [1] = moveWithMG,

    -- ACTIVE
    [2] = moveWithMGMode,

    -- HOOK_PULLS
    [3] = pushWithHooks,

    -- FLIGHT
    [4] = fly,

    -- FLIGHT_AND_HOOK_PULLS
    [5] = flyWithHooks,
}

hook.Add('Move', 'ju_mobility_gear_move', function(ply, mv)

    local state = ply:GetMGState()

    if state == 0 then
        return
    end

    local switchFunc = switchTable[state]

    if !switchFunc then
        return
    end

    switchFunc(ply, mv)


end)

hook.Add('GetFallDamage', 'ju_mobility_gear_removeFallDamage', function(ply, speed)
    
    if ply:GetMGState() != 0 then
        return 0
    end

end)