function EFFECT:Init(data)
	self.eEnt = data:GetEntity()
	self.iScale = math.Round(data:GetScale())

	self.DieTime = CurTime() + 3
end

local Dismembers = {DISMEMBER_HEAD, DISMEMBER_LEFTLEG, DISMEMBER_RIGHTLEG, DISMEMBER_LEFTARM, DISMEMBER_RIGHTARM}
local DismemberBones = {
{ToZero = {"ValveBiped.Bip01_Head1"}, ToBleed = {["ValveBiped.Bip01_Head1"] = true}},
{ToZero = {"ValveBiped.Bip01_L_Thigh", "ValveBiped.Bip01_L_Calf", "ValveBiped.Bip01_L_Foot"}, ToBleed = {["ValveBiped.Bip01_L_Thigh"]=true}},
{ToZero = {"ValveBiped.Bip01_R_Thigh", "ValveBiped.Bip01_R_Calf", "ValveBiped.Bip01_R_Foot"}, ToBleed = {["ValveBiped.Bip01_R_Thigh"]=true}},
{ToZero = {"ValveBiped.Bip01_L_UpperArm", "ValveBiped.Bip01_L_Forearm", "ValveBiped.Bip01_L_Hand"}, ToBleed = {["ValveBiped.Bip01_L_UpperArm"]=true}},
{ToZero = {"ValveBiped.Bip01_R_UpperArm", "ValveBiped.Bip01_R_Forearm", "ValveBiped.Bip01_R_Hand"}, ToBleed = {["ValveBiped.Bip01_R_UpperArm"]=true}}
}

local BoneTranslates = {}
BoneTranslates["models/zombie/classic.mdl"] = {["ValveBiped.Bip01_Head1"]="ValveBiped.Bip01_Spine2"}
BoneTranslates["models/zombie/poison.mdl"] = {["ValveBiped.Bip01_Head1"]="ValveBiped.Bip01_Spine4"}
BoneTranslates["models/zombie/fast.mdl"] = {["ValveBiped.Bip01_Head1"]="ValveBiped.HC_BodyCube"}
BoneTranslates["models/player/zombie_classic.mdl"] = {["ValveBiped.Bip01_Head1"]="ValveBiped.Bip01_Spine4"}

local function CollideCallback(particle, hitpos, hitnormal)
	if particle:GetDieTime() == 0 then return end
	particle:SetDieTime(0)

	if math.random(6) == 1 then
		sound.Play("physics/flesh/flesh_bloody_impact_hard1.wav", hitpos, 50, math.random(95, 105))
	end

	util.Decal("Impact.Flesh", hitpos + hitnormal, hitpos - hitnormal)
end

local eEnt
local vPos = Vector(128, 128, 128)
local vNeg = Vector(-128, -128, -128)
local eRag
function EFFECT:Think()
	eEnt = self.eEnt

	if not self.SetDoll and eEnt:IsValid() and eEnt:IsPlayer() then
		eRag = eEnt:GetRagdollEntity()
		if eRag and eRag:IsValid() then
			self.SetDoll = true
			self.eRagdoll = eRag
			eRag.Dismemberment = bit.bor((eRag.Dismemberment or 0), self.iScale)
			self.DieTime = CurTime() + math.Rand(5, 7)
			eRag.NextEmit = 0
			self.Entity:SetRenderBounds(vNeg, vPos)
		end
	end

	if self.eRagdoll and self.eRagdoll:IsValid() then
		self.Entity:SetPos(self.eRagdoll:GetPos())
	end

	return CurTime() < self.DieTime
end

local eRagdoll
local fCurTime
local emitter
local iDismemberment
local mdl
local iBone
local delta
local vBonePos, aBoneAng
local vForward
local particle
local force
local vel
local strBloodspray = "noxctf/sprite_bloodspray"
local vellength
function EFFECT:Render()
	eRagdoll = self.eRagdoll
	fCurTime = CurTime()

	if eRagdoll and eRagdoll:IsValid() and eRagdoll.NextEmit <= fCurTime then
		eRagdoll.NextEmit = fCurTime + 0.05

		emitter = ParticleEmitter(eRagdoll:GetPos())
		emitter:SetNearClip(20, 30)

		iDismemberment = eRagdoll.Dismemberment or 0
		for index, iDismemberPart in pairs(Dismembers) do
			if bit.band(iDismemberPart, iDismemberment) == iDismemberPart then
				for _, sZeroBone in pairs(DismemberBones[index].ToZero) do
					mdl = string.lower(eRagdoll:GetModel())
					if BoneTranslates[mdl] and BoneTranslates[mdl][sZeroBone] then
						sZeroBone = BoneTranslates[mdl][sZeroBone]
					end

					iBone = eRagdoll:LookupBone(sZeroBone)
					if iBone and iBone > 0 then
						eRagdoll:ManipulateBoneScale(iBone, vector_tiny)
					end
				end

				for sZeroBone in pairs(DismemberBones[index].ToBleed) do
					mdl = string.lower(eRagdoll:GetModel())
					if BoneTranslates[mdl] and BoneTranslates[mdl][sZeroBone] then
						sZeroBone = BoneTranslates[mdl][sZeroBone]
					end

					iBone = eRagdoll:LookupBone(sZeroBone)
					if iBone and iBone > 0 then
						delta = math.max(0, self.DieTime - fCurTime)
						if 0 < delta then
							vBonePos, aBoneAng = eRagdoll:GetBonePosition(iBone)
							if vBonePos and aBoneAng then
								emitter:SetPos(vBonePos)
								vForward = aBoneAng:Forward()
								for i=1, math.random(0, 2) do
									particle = emitter:Add(strBloodspray..math.random(8), vBonePos)
									force = math.min(1.5, delta) * math.Rand(175, 300)
									particle:SetVelocity(force * vForward + 0.2 * force * VectorRand())
									particle:SetDieTime(math.Rand(2.25, 3))
									particle:SetStartAlpha(240)
									particle:SetEndAlpha(0)
									particle:SetStartSize(math.random(1, 8))
									particle:SetEndSize(0)
									particle:SetRoll(math.Rand(0, 360))
									particle:SetRollDelta(math.Rand(-40, 40))
									particle:SetColor(255, 0, 0)
									particle:SetAirResistance(5)
									particle:SetBounce(0)
									particle:SetGravity(Vector(0, 0, -600))
									particle:SetCollide(true)
									particle:SetCollideCallback(CollideCallback)
									particle:SetLighting(true)
								end
								particle = emitter:Add(strBloodspray..math.random(8), vBonePos)
								vel = eRagdoll:GetVelocity()
								particle:SetVelocity(vel)
								particle:SetDieTime(math.Rand(0.5, 0.75))
								particle:SetStartAlpha(240)
								particle:SetEndAlpha(0)
								particle:SetStartSize(math.random(6, 12))
								particle:SetEndSize(0)
								particle:SetRoll(math.Rand(0, 360))
								vellength = vel:Length() * 0.45
								particle:SetRollDelta(math.Rand(-vellength, vellength))
								particle:SetColor(255, 0, 0)
								particle:SetAirResistance(20)
								particle:SetLighting(true)
							end
						end
					end
				end
			end
		end

		emitter:Finish()
	end
end
