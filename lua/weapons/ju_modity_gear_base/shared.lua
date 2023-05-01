
local mg = ju.mobility_gear
local cfg = mg.cfg

-- Q-menu
SWEP.Category = cfg.q_menu_category
SWEP.Author = 'Julik#8946'
SWEP.Spawnable = false

-- Selector
SWEP.Slot = 2
SWEP.SlotPos = 0

-- Hud
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false


function SWEP:Initialize()

    

end

if SERVER then

    function SWEP:startMG()
        
        self:GetOwner():SetMGState(2)
        
    end

    function SWEP:endMG()
        
        self:GetOwner():SetMGState(0)
        
    end
    
    function SWEP:Deploy()
        
        self:startMG()

    end

    function SWEP:Holster(weapon)
        
        self:endMG()

        return true
    
    end

end

function SWEP:PrimaryAttack()
    if !IsFirstTimePredicted() then return end

    print 'PrimaryAttack'
end

function SWEP:SecondaryAttack()
    if !IsFirstTimePredicted() then return end

    print 'SecondaryAttack'
end

function SWEP:CanPrimaryAttack()
    
end

function SWEP:CanSecondaryAttack()
    
end
