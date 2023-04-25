
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


function SWEP:Reload()
    
end

function SWEP:Deploy()
    
end


function SWEP:PrimaryAttack()
    print 'PrimaryAttack'
end

function SWEP:SecondaryAttack()
    print 'SecondaryAttack'
end

function SWEP:CanPrimaryAttack()
    
end

function SWEP:CanSecondaryAttack()
    
end
