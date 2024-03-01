if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "bms/vgui/hud/weapon_gluon" )
SWEP.DrawWeaponInfoBox	= false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_bms_gluon", "bms/vgui/hud/weapon_gluon", Color( 255, 255, 255, 255 ) )
end

SWEP.PrintName = "Gluon Gun"
SWEP.Category = "Black Mesa: Source"
SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = true

SWEP.ViewModelFOV = 70
SWEP.ViewModel = "models/bms/weapons/v_egon.mdl"
SWEP.WorldModel = "models/bms/weapons/w_egon.mdl"
SWEP.ViewModelFlip = false
SWEP.BobScale = 0.2
SWEP.SwayScale = 1

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Weight = 100
SWEP.Slot = 3
SWEP.SlotPos = 2

SWEP.UseHands = false
SWEP.HoldType = "smg"
SWEP.FiresUnderwater = true
SWEP.DrawCrosshair = false
SWEP.DrawAmmo = true
SWEP.CSMuzzleFlashes = 1
SWEP.Base = "weapon_base"


SWEP.Sprint = 0
SWEP.Idle = 0
SWEP.IdleTimer = CurTime()
SWEP.Attack = 0
SWEP.AttackTimer = CurTime()
SWEP.FirstTime = 0

SWEP.Primary.Sound = Sound( "weapon_BMS_gluon.Special1" )
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 30
SWEP.Primary.MaxAmmo = 100
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "GaussEnergy"
SWEP.Primary.Damage = 14
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Spread = Vector( 0, 0, 0 )
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Delay = 0.1
SWEP.Primary.Force = 1

SWEP.Secondary.Sound = Sound( "weapon_BMS_gluon.Special2" )
SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
self:SetWeaponHoldType( self.HoldType )
self.Idle = 0
self.IdleTimer = CurTime() + 4
self.FirstTime = 1
end

function SWEP:DrawHUD()
if CLIENT then
local x, y
if ( self.Owner == LocalPlayer() and self.Owner:ShouldDrawLocalPlayer() ) then
local tr = util.GetPlayerTrace( self.Owner )
local trace = util.TraceLine( tr )
local coords = trace.HitPos:ToScreen()
x, y = coords.x, coords.y
else
x, y = ScrW() / 2, ScrH() / 2
end
surface.SetTexture( surface.GetTextureID( "bms/vgui/hud/crosshair_gluon" ) )
surface.SetDrawColor( 255, 255, 255, 255 )
surface.DrawTexturedRect( x - 16, y - 16, 32, 32 )
end
end

function SWEP:Deploy()
self:SetWeaponHoldType( self.HoldType )
if self.FirstTime == 0 then
self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
end
if self.FirstTime == 1 then
self.Weapon:SendWeaponAnim( ACT_DEPLOY )
end
self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self.Sprint = 0
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
self.Attack = 0
self.AttackTimer = CurTime()
self.FirstTime = 0
end

function SWEP:Holster()
if self.Attack == 1 then return end
self.Sprint = 0
self.Idle = 0
self.IdleTimer = CurTime()
self:StopSound( self.Primary.Sound )
return true
end

function SWEP:PrimaryAttack()
if self.Weapon:Ammo1() <= 0 then
if SERVER then
self.Owner:EmitSound( "weapon_BMS_glock.Empty" )
end
self:SetNextPrimaryFire( CurTime() + 0.2 )
self:SetNextSecondaryFire( CurTime() + 0.2 )
end
if self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 then
if SERVER then
self.Owner:EmitSound( "weapon_BMS_glock.Empty" )
end
self:SetNextPrimaryFire( CurTime() + 0.2 )
self:SetNextSecondaryFire( CurTime() + 0.2 )
end
if self.Weapon:Ammo1() <= 0 then return end
if self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 then return end
local bullet = {}
bullet.Num = self.Primary.NumberofShots
bullet.Src = self.Owner:GetShootPos()
bullet.Dir = self.Owner:GetAimVector()
bullet.Spread = self.Primary.Spread
bullet.Tracer = 0
bullet.Force = self.Primary.Force
bullet.Damage = self.Primary.Damage
bullet.AmmoType = self.Primary.Ammo
self.Owner:FireBullets( bullet )
self:EmitSound( self.Primary.Sound )
self.Owner:SetAnimation( PLAYER_ATTACK1 )
self:TakePrimaryAmmo( self.Primary.TakeAmmo )
self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
if self.Attack == 0 then
self.Owner:ViewPunchReset()
self.Owner:ViewPunch( Angle( math.Rand( 1, 2 ), math.Rand( -3.5, -1.5 ), 0 ) )
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
end
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
self.Attack = 1
self.AttackTimer = CurTime() + self.Primary.Delay + 0.05
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:Think()
if self.Attack == 1 then
local tr = self.Owner:GetEyeTrace()
local effectdata = EffectData()
effectdata:SetOrigin( tr.HitPos )
effectdata:SetNormal( tr.HitNormal )
effectdata:SetStart( self.Owner:GetShootPos() )
effectdata:SetAttachment( 1 )
effectdata:SetEntity( self.Weapon )
util.Effect( "effect_bms_gluon_beam", effectdata )
end
if self.Attack == 1 and self.AttackTimer <= CurTime() then
self.Weapon:SendWeaponAnim( ACT_TRANSITION )
self:StopSound( self.Primary.Sound )
self:EmitSound( self.Secondary.Sound )
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
self.Attack = 0
end
if self.Attack == 1 and self.Weapon:Ammo1() <= 0 then
self.Weapon:SendWeaponAnim( ACT_TRANSITION )
self:StopSound( self.Primary.Sound )
self:EmitSound( self.Secondary.Sound )
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
self.Attack = 0
end
if self.Owner:GetVelocity():Length() > 75 then
if self.Owner:KeyDown( IN_MOVELEFT ) then
self.Owner:ViewPunch( Angle( 0, 0, -0.05 ) )
end
if self.Owner:KeyDown( IN_MOVERIGHT ) then
self.Owner:ViewPunch( Angle( 0, 0, 0.05 ) )
end
end
if self.Attack == 0 and !( self.Weapon:GetActivity() == ACT_DEPLOY ) then
if self.Sprint == 0 and self.Owner:KeyDown( IN_SPEED ) and ( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) then
if SERVER then
self.Weapon:SendWeaponAnim( ACT_VM_SPRINT_ENTER )
end
self.Sprint = 1
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end
if self.Sprint == 1 and !self.Owner:KeyDown( IN_SPEED ) then
if SERVER then
self.Weapon:SendWeaponAnim( ACT_VM_SPRINT_LEAVE )
end
self.Sprint = 0
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end
if self.Sprint == 1 and !( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) then
if SERVER then
self.Weapon:SendWeaponAnim( ACT_VM_SPRINT_LEAVE )
end
self.Sprint = 0
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end
end
if self.Attack == 0 then
if self.Idle == 0 and self.IdleTimer < CurTime() then
if SERVER then
if self.Sprint == 0 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
end
if self.Sprint == 1 then
self.Weapon:SendWeaponAnim( ACT_VM_SPRINT_IDLE )
end
end
self.Idle = 1
end
end
if self.Weapon:Ammo1() > self.Primary.MaxAmmo then
self.Owner:SetAmmo( self.Primary.MaxAmmo, self.Primary.Ammo )
end
end