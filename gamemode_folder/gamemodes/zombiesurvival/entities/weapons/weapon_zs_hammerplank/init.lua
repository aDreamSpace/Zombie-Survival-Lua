AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsValid() then
		if hitent.HitByHammer and hitent:HitByHammer(self, self.Owner, tr) then
			return
		end

		if hitent:IsNailed() then
			local healstrength = GAMEMODE.NailHealthPerRepair * (self.Owner.HumanRepairMultiplier or 1) * self.HealStrength
			local oldhealth = hitent:GetBarricadeHealth()
			if oldhealth <= 0 or oldhealth >= hitent:GetMaxBarricadeHealth() or hitent:GetBarricadeRepairs() <= 0 then self:SetCombo(0) return end

			hitent:SetBarricadeHealth(math.min(hitent:GetMaxBarricadeHealth(), hitent:GetBarricadeHealth() + math.min(hitent:GetBarricadeRepairs(), healstrength)))
			local healed = hitent:GetBarricadeHealth() - oldhealth
			hitent:SetBarricadeRepairs(math.max(hitent:GetBarricadeRepairs() - healed, 0))
			self:PlayRepairSound(hitent)
			local combo = self:GetCombo() or 0
			self:SetNextPrimaryFire(CurTime() + math.max(0.2, self.Primary.Delay * (1 - combo / 10)))
			self:SetCombo(combo + 1)
			gamemode.Call("PlayerRepairedObject", self.Owner, hitent, healed, self)

			local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetMagnitude(1)
			util.Effect("nailrepaired", effectdata, true, true)

			return true
		end
	end
end