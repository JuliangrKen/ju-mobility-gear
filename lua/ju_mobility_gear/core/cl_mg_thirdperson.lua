
local math = math
local cos = math.cos
local sin = math.sin
local timeC = TimedCos
local timeS = TimedSin

local minDist = 32
local maxDist = 128
local height = 16

-- TODO: Добавить настройку вида от 3 лица (по необходимости)
-- TODO: Удалить хуки, что могут повлиять на работу камеры
-- TODO: Доработать эффект!

-- TODO: Разместить создание камеры в момент смены MG State
-- local camera = ju.mobility_gear.classes.camera:new(minDist, maxDist, height)

local camera

local function calcView(ply, eyeVector, eyeAngle, fov, znear, zfar)

    camera = ju.mobility_gear.classes.camera
                    :new(minDist, maxDist, height)
                    :SetEyePos(eyeVector)
                    :SetEyeAngle(eyeAngle)
                    :Recalculate()

    local view = {

        -- main settings:
		origin = camera.Pos,
		angles = camera.Angle,
		drawviewer = camera.NeedDrawViewer,

        -- other
        fov = fov,
		znear = znear,
		zfar = zfar,
		-- ortho = {0, 0, 0, 0},

	}

    return view

end

local function canDraw(hands, vm, ply, weapon)
    
    return !camera.NeedDrawViewer

end

hook.Add('Ju_MGState_WasChanged', 'Ju_MGState_WasChanged_Calcview', function(ply, oldState, newState)
    
    if ply != LocalPlayer() then
        return
    end

    if newState == 0 then
        
        hook.Remove('CalcView', 'ju_mobility_gear_calcview', calcView)
        hook.Remove('PreDrawPlayerHands', 'ju_mobility_gear_hands', canDraw)
        return

    end

    hook.Add('CalcView', 'ju_mobility_gear_calcview', calcView)
    hook.Add('PreDrawPlayerHands', 'ju_mobility_gear_hands', canDraw)
    
end)
