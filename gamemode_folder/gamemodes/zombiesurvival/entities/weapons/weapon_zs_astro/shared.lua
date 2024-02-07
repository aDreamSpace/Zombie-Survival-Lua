if CLIENT then
    SWEP.PrintName            = "Astronaut"                                                    
    SWEP.Author            = ""
	SWEP.Category = "Project Anon"
    SWEP.Slot            = 1
    SWEP.SlotPos            = 4
    SWEP.ViewModelFOV        = 90
    SWEP.DrawAmmo = false
	SWEP.IconLetter			= "x"
	killicon.Add( "weapon_zs_astro", "pack/killicon", color_white )
end

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true
SWEP.ViewModel              = "models/v_egon.mdl"
SWEP.WorldModel             = "models/weapons/w_physics.mdl"
SWEP.Primary.ClipSize        = -1
SWEP.Primary.Ammo            = "none"

SWEP.Secondary.ClipSize          = -1
SWEP.Secondary.DefaultClip      = -1
SWEP.Secondary.Automatic        = false
SWEP.Secondary.Ammo            = "none"

if SERVER then

    function alphathink(self)
        if self.TimeOut > CurTime() then
            self:SetColor(255,255,255,((self.TimeOut-CurTime())/2)*255)
        else
            self:Remove()
        end

        self:NextThink( CurTime() + 0.01 )
    end

    function SWEP:Initialize()
        self:SetWeaponHoldType( "physgun" )
        self.NextShoot = CurTime()
    end

    function SWEP:PrimaryAttack()
        if not self.NextShoot then self.NextShoot = CurTime() end
        if CurTime() >= self.NextShoot and self.Owner:KeyDown(IN_ATTACK) then
            if ALT_ON == 0 then
                self.Weapon:EmitSound("pack/up2.wav")
                ChargeSnd = Sound("pack/run2.wav")
                self.SndLoop = CreateSound(self.Weapon, ChargeSnd )
                self.SndLoop:Play()
                ALT_ON = 1
            end
        end
    end

    function SWEP:SecondaryAttack()
    end

    function SWEP:Think()
        if self.Owner:KeyReleased(IN_ATTACK) then
            ALT_ON = 0
            if self.SndLoop then
                self.SndLoop:Stop()
            end
        end

        if self.Owner:KeyDown(IN_ATTACK) and ALT_ON then
            if  not self.SndLoop then
                self.Weapon:EmitSound("pack/up2.wav")
                ChargeSnd = Sound("pack/run2.wav")
                self.SndLoop = CreateSound(self.Weapon, ChargeSnd )
                self.SndLoop:Play()
            end
            local tr = self.Owner:GetEyeTrace()
            if tr.Hit then
                util.ScreenShake( tr.HitPos, 5, 5, .1, 128 )
                util.BlastDamage(self.Weapon, self.Owner, tr.HitPos, 30, 30 )
            end
        end
        self:SetNWInt("fier", ALT_ON)
        self:NextThink( CurTime() + 1/30 )
    end

    function SWEP:Deploy()
        ALT_ON = 0
        self:SetNWInt("fier", 0)
        return true
    end


    function SWEP:OnRemove()
        self:SetNWInt("fier", 0)
        if self.SndLoop then
            self.SndLoop:Stop()
        end
    end

    function SWEP:ShootEffects()
        self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
        self.Owner:SetAnimation( PLAYER_ATTACK1 )
    end

    function SWEP:ShouldDropOnDie()
        return false
    end

end


if CLIENT then

    function SWEP:Initialize()
        if self.on == nil then self.on = 0 end
        self:SetWeaponHoldType( "physgun" )
        Beamz = CreateMaterial( "xeno/beamz2", "UnlitGeneric", {
            [ "$basetexture" ]    = "sprites/physbeam3",
            [ "$additive" ]        = "1",
            [ "$vertexcolor" ]    = "1",
            [ "$vertexalpha" ]    = "1",
        } )
        Beamtwo = CreateMaterial( "xeno/beam22", "UnlitGeneric", {
            [ "$basetexture" ]    = "sprites/laserbeam2",
            [ "$additive" ]        = "1",
            [ "$vertexcolor" ]    = "1",
            [ "$vertexalpha" ]    = "1",
        } )
    end

    function SWEP:DrawHUD()
    end

    function SWEP:Think()
        self.on = self:GetNWInt("fier")
    end


    function SWEP:ViewModelDrawn()
        self:Drawspiral()
    end

    function SWEP:DrawWorldModel()
        self:Drawspiral()
        self.Weapon:DrawModel()
    end


    function SWEP:Drawspiral()
        Beamz = CreateMaterial( "xeno/beamz2", "UnlitGeneric", {
            [ "$basetexture" ]    = "sprites/physbeam3",
            [ "$additive" ]        = "1",
            [ "$vertexcolor" ]    = "1",
            [ "$vertexalpha" ]    = "1",
        } )
        Beamtwo = CreateMaterial( "xeno/beam22", "UnlitGeneric", {
            [ "$basetexture" ]    = "sprites/laserbeam2",
            [ "$additive" ]        = "1",
            [ "$vertexcolor" ]    = "1",
            [ "$vertexalpha" ]    = "1",
        } )

        
        if self.on == 1 then
        local tr = self.Weapon.Owner:GetEyeTraceNoCursor()

        if tr.Hit then


        self.StartPos = self:GetMuzzlePos( self, 1 )
        self.EndPos = tr.HitPos


        if not self.StartPos then return end
        if not self.EndPos then return end

        render.SetMaterial(Material("effects/exit1"))
        render.DrawSprite( self.EndPos, 32, 32, Color(255,0,0,255))

        self.Weapon:SetRenderBoundsWS( self.StartPos, self.EndPos )

        local sinq = 3
        render.SetMaterial( Beamz )
        Rotator = Rotator or 0
        Rotator = Rotator - 10
        local Times = 50 --12
        render.StartBeam( 2 + Times );
        -- add start
        self.Dir = (self.EndPos - self.StartPos):GetNormal()
        self.Inc = (self.EndPos - self.StartPos):Length() / Times
        local RAng = self.Dir:Angle()
        RAng:RotateAroundAxis(RAng:Right(),90)
        RAng:RotateAroundAxis(RAng:Up(),Rotator)
        render.AddBeam(
            self.StartPos,                // Start position
            20,                    // Width
            CurTime(),                // Texture coordinate
            Color( 255, 255, 255, 200 )        // Color --Color( 64, 255, 64, 200 )
        )

        for i = 0, Times do
            // get point
            RAng:RotateAroundAxis(RAng:Up(),360/(Times/sinq))
            local point = ( self.StartPos + self.Dir * ( i * self.Inc ) ) + RAng:Forward() * (math.sin((i/Times)*math.pi))*25
            render.AddBeam(
                point,
                20,
                CurTime() + ( 1 / Times ) * i,
                Color( 255, 255, 255, 200 )
            )
        end
        render.AddBeam(
            self.EndPos,
            20,
            CurTime() + 1,
            Color( 255, 255, 255, 200 )
        )
        render.EndBeam()

        render.StartBeam( 2 + Times );
        -- add start
        self.Dir = (self.EndPos - self.StartPos):GetNormal()
        self.Inc = (self.EndPos - self.StartPos):Length() / Times
        local RAng = self.Dir:Angle()
        RAng:RotateAroundAxis(RAng:Right(),90)
        RAng:RotateAroundAxis(RAng:Up(),Rotator*-1)
        render.AddBeam(
            self.StartPos,                
            20,                    
            CurTime(),                
            Color( 255, 255, 255, 200 )        
        )

        for i = 0, Times do
            // get point
            RAng:RotateAroundAxis(RAng:Up(),360/(Times/sinq))
            local point = ( self.StartPos + self.Dir * ( i * self.Inc ) ) + RAng:Forward() * (math.sin((i/Times)*math.pi))*12
            render.AddBeam(
                point,
                20,
                CurTime() + ( 1 / Times ) * i,
                Color( 255, 255, 255, 200 )
            )
        end
        render.AddBeam(
            self.EndPos,
            20,
            CurTime() + 1,
            Color( 255, 255, 255, 200 )
        )
        render.EndBeam()

        render.StartBeam( 2 + Times );
        -- add start
        self.Dir = (self.EndPos - self.StartPos):GetNormal()
        self.Inc = (self.EndPos - self.StartPos):Length() / Times
        local RAng = self.Dir:Angle()
        RAng:RotateAroundAxis(RAng:Right(),90)
        render.AddBeam(
            self.StartPos,                
            20,                    
            CurTime(),                
            Color( 255, 255, 255, 200 )        
        )

        for i = 0, Times do
            // get point
            local point = ( self.StartPos + self.Dir * ( i * self.Inc ) ) --+ VectorRand()*math.random(1,10)
            render.AddBeam(
                point,
                20,
                CurTime() + ( 1 / Times ) * i,
                Color( 255, 255, 255, 200 )
            )
        end
        render.AddBeam(
            self.EndPos,
            20,
            CurTime() + 1,
            Color( 255, 255, 255, 200 )
        )
        render.EndBeam()
        end
        end


    end

    function SWEP:GetMuzzlePos( weapon, attachment )

        if(!IsValid(weapon)) then return end

        local origin = weapon:GetPos()
        local angle = weapon:GetAngles()
        if weapon:IsWeapon() and weapon:IsCarriedByLocalPlayer() then
            if( IsValid( weapon:GetOwner() ) && GetViewEntity() == weapon:GetOwner() ) then
                local viewmodel = weapon:GetOwner():GetViewModel()
                if( IsValid( viewmodel ) ) then
                    weapon = viewmodel
                end
            end
        end
        local attachment = weapon:GetAttachment( attachment or 1 )
        if( !attachment ) then
            return origin, angle
        end
        return attachment.Pos, attachment.Ang

    end
end

function SWEP:Deploy()
    self.Weapon:EmitSound("")
end