include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetModelScale(0.5, 0)
end


local vOffset = Vector(0, 0, 0)
local aOffset = Angle(-1.17, -5.844, 90)
local strBone = "ValveBiped.Bip01_Spine2"
local strWep = "weapon_zs_arsenalcrate"
local owner
local wep
local boneid
local bonepos, boneang
function ENT:Draw()
	owner = self:GetOwner()
	if not owner:IsValid() or owner == MySelf and not owner:ShouldDrawLocalPlayer() then return end

	if owner.ShadowMan then return end

	wep = owner:GetActiveWeapon()
	if wep:IsValid() and wep:GetClass() == strWep then return end

	boneid = owner:LookupBone(strBone)
	if not boneid or boneid <= 0 then return end

	bonepos, boneang = owner:GetBonePositionMatrixed(boneid)

	self:SetPos(bonepos + vOffset)
	boneang:RotateAroundAxis(boneang:Up(), aOffset.y)
	boneang:RotateAroundAxis(boneang:Right(), aOffset.p)
	boneang:RotateAroundAxis(boneang:Forward(), aOffset.r)

	self:SetAngles(boneang)

	self:DrawModel()
end