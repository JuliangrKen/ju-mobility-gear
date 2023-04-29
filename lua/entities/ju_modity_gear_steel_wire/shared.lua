
ENT.Type = 'anim'
ENT.Base = "base_anim"
ENT.Author = 'Julik#8946'

ENT.Category = 'AOT'
ENT.Spawnable = true


if SERVER then

    local cfg = ju.mobility_gear.cfg
    
    local constraint = constraint
              -- constraint.CreateKeyframeRope
    local Rope = constraint.Rope

    function ENT:Initialize()
        
        local mg_hook = ents.Create 'mg_hook'
        self:DeleteOnRemove(mg_hook)

        self.mg_hook = mg_hook

    end
    
    function ENT:SetPlayer(ply)

        if !ply:IsPlayer() then return end
    
        self.player = ply

    end

    function ENT:SetHookPoint(point)
        
        if !isvector(point) then return end

        self.mg_hook:SetPos(point)

    end

    function ENT:Start()
        
        local _, rope = Rope(

        -- Entity Ent1
            self.player,

        -- Entity Ent2
            self.mg_hook,

        -- number Bone1
            cfg.customBones or cfg.defaultBone,

        -- number Bone2
            0,

        -- Vector LPos1
            isvector(cfg.defaultLift) and defaultLift or Vector(0, 0, defaultLift),

        -- Vector LPos2
            Vector(),

        -- number length
            cfg.defaultLength,
        
        -- number addlength
            0,
            
        -- number forcelimit
            0,

        -- number width
            cfg.defaultWidth,

        -- string material
            cfg.defaultMaterial,
        
        -- boolean rigid
            false,

        -- table color
            cfg.defaultColor

        )

        self:DeleteOnRemove(rope)
        
        rope:Activate()

        self.rope = rope

    end

    function ENT:Stop()

        self.rope:Remove()
        
    end

end
