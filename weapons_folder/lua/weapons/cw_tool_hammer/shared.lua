AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.Base = "cw_base"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Hammer"
	SWEP.CSMuzzleFlashes = true

	SWEP.Description = "A simple but extremely useful tool. Allows you to hammer in nails to make barricades.\nPress SECONDARY FIRE to hammer in nail. It will be attached to whatever is behind it.\nPress RELOAD to take a nail out.\nUse PRIMARY FIRE to bash zombie brains or to repair damaged nails.\nYou get a point bonus for repairing damaged nails but a point penalty for removing another player's nails."
	
	
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.DrawTraditionalWorldModel = true
	
	SWEP.IronsightPos = Vector(0, 0, 0)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(0, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(0, 0, 0)
	SWEP.CustomizeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.025
	local text = translate.Get("right_click_to_hammer_nail")
	local strNails = "nails_x"
	local strFont = "ZSHUDFontSmall"
	local strAmmo = "GaussEnergy"
	function SWEP:DrawHUD()

		surface.SetFont(strFont)
		
		local nails = MySelf:GetAmmoCount(strAmmo)
		local nTEXW, nTEXH = surface.GetTextSize(text)

		draw.SimpleTextBlurry(translate.Format(strNails, nails), strFont, ScrW() - nTEXW * 0.5 - 24, ScrH() - nTEXH * 3, nails > 0 and COLOR_LIMEGREEN or COLOR_RED, TEXT_ALIGN_CENTER)

		draw.SimpleTextBlurry(text, strFont, ScrW() - nTEXW * 0.5 - 24, ScrH() - nTEXH * 2, COLOR_LIMEGREEN, TEXT_ALIGN_CENTER)

		self.BaseClass.DrawHUD(self)
	end
	--]]

end

SWEP.Attachments = {
	["+reload"] = {header = "Nail Type", offset = {-600, -200}, atts = {"am_barbed2", "am_heavynails2", "am_steelnails2", "am_gnails2"}},
	[1] = {header = "Hammerhead", offset = {250, -400}, atts = {"md_m_steelhammer2", "md_m_alloyhammer2", "md_m_electrumhammer2"}},
	[2] = {header = "Grip", offset = {250, 200}, atts = {"md_m_polymergrip"}},
}

SWEP.Animations = {
	--slash_primary = "hit1",
	slash_secondary = "unnail",
	draw = "draw",
	idle = "idle"
}

SWEP.Sounds = {
	["draw"] = {{time = 0.1, sound = "CW_FOLEY_HEAVY"}, {time = 0.6, sound = "CW_FOLEY_MEDIUM"}},
	["attack1"] = {{time = 0.1, sound = "CW_FOLEY_LIGHT"}, {time = 0.15, sound = "CW_SWORD_SLASH_QUICK"}},
	["hit1"] = {{time = 0.1, sound = "CW_FOLEY_MEDIUM"}},

	["toinspect"] = {{time = 0.3, sound = "CW_FOLEY_LIGHT"}},
	["frominspect"] = {{time = 0, sound = "CW_FOLEY_LIGHT"}},
	["nail"] = {{time = 0.1, sound = "CW_FOLEY_MEDIUM"}, {time = 0.4, sound = "CW_HAMMER_HIT"}},
	["unnail"] = {{time = 0.5, sound = "CW_FOLEY_HEAVY"}},
}
SWEP.PlayerHitSounds = {"CW_SWORD_SLASH_FLESH"}
SWEP.PlayerHitSoundsSecondary = {"CW_SWORD_STAB_FLESH"}
SWEP.NPCHitSounds = {} -- key is npc class, value is table containing the sounds, if npc class key is not found within this table it will fall back to the sounds in PlayerHitSounds
SWEP.MiscHitSounds = {"CW_HAMMER_HIT"}
SWEP.MiscHitSoundsSecondary = {"CW_SWORD_STAB_OUT"}

SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.CW20Melee = true
SWEP.CW20Hammer = true

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.NormalHoldType = "grenade"
SWEP.ViewModel = "models/cw2/tools/newhammer/c_tool_newhammer.mdl"
SWEP.WorldModel = "models/newhammer/w_tool_newhammer.mdl"

SWEP.UseHands = true
SWEP.CanCustomize = true
SWEP.SpecialCAnimation = true
SWEP.CustomizationAnims = {to = {"toinspect", 1.25}, from = {"frominspect", 1.25}} 

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.PropDamage = 100
SWEP.Primary.ClipSize = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "GaussEnergy"
SWEP.Primary.Delay = 1
SWEP.Primary.DefaultClip = 16

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Ammo = "dummy"


SWEP.PrimaryAttackDelay = 0.8 --deminished with poly grip
SWEP.SecondaryAttackDelay = 0.75

SWEP.PrimaryAttackDamage = {40, 60}
SWEP.SecondaryAttackDamage = {30, 30}

SWEP.PrimaryAttackRange = 50
SWEP.SecondaryAttackRange = 50

SWEP.NoPropThrowing = true

SWEP.HolsterTime = 0.4
SWEP.DeployTime = 0.6

SWEP.PrimaryAttackImpactTime = 0.4
SWEP.PrimaryAttackDamageWindow = 0.15

SWEP.SecondaryAttackImpactTime = 0.2
SWEP.SecondaryAttackDamageWindow = 0.15

SWEP.FireAnimSpeed = 2.25
SWEP.FireAnimSpeedSecondary = 1.25

SWEP.PrimaryHitAABB = {
	Vector(-1, -1, -1),
	Vector(1, 1, 1)
}

SWEP.HealStrength = 1
SWEP.NailType = NAILTYPE_NONE

function SWEP:IndividualInitialize()
	self.Primary.ClipSize = -1
	self.Primary.Automatic = true
	self.Primary.Ammo = "GaussEnergy"
	self.Primary.Delay = 1 --not needed
	self.Primary.DefaultClip = 16
	--PrintTable(self.CW_VM:GetMaterials())
	--self.CW_VM:SetSubMaterial(1, "models/debug/debugwhite")

end


local fullSize = Vector(1, 1, 1)
local invisible = Vector(0, 0, 0)

function SWEP:adjustVisibleRounds()
	local vm = self.CW_VM
	local scale = self:GetOwner():GetAmmoCount(self.Primary.Ammo) > 0 and fullSize or invisible
	vm:ManipulateBoneScale(vm:LookupBone("nail_to_hand") or -1, scale)
end

function SWEP:IndividualThink()
	if self.CustomizationAnimation and not self:canCustomize() then
		self:playAnim(nil, nil, nil, nil, self.CustomizationAnims.from[1])
		self.CustomizationAnimation = false --idk why the fuck this variable is needed but getting the sequence causes CW_IDLE and CW_CUSTOMIZE to fuck up
	end

	if CLIENT then
		self.NEXTBONETHINK = self.NEXTBONETHINK or 0

		if self.NEXTBONETHINK < CurTime() then
			self:adjustVisibleRounds()
			self.NEXTBONETHINK = CurTime() + 1
		end
	end
end

if CLIENT then --we need to delete some functions
	function SWEP:Reload()
	
	end

	function SWEP:SecondaryAttack()
	
	end
end

local once = true
function SWEP:PrimaryAttack() --override this so we can play our animations seamlessly
	self.BaseClass.PrimaryAttack(self) --first play the original attack function\
	
	--then override it with out additional animation code
	if IsFirstTimePredicted() and CLIENT then
		once = false  
		local bHit = self:DetermineHitOrMiss(self.PrimaryAttackRange)
		self:playAnim(nil, nil, nil, nil, bHit and "hit1" or "attack1")
	end

	--to not be a hacky solution, there should be a way to send custom animations (since the current melee animation system sucks)
end
if SERVER then

function SWEP:Reload()
	if CurTime() < self:GetNextPrimaryFire() then return end

	local owner = self:GetOwner()
	if owner:GetBarricadeGhosting() then return end

	local tr = owner:MeleeTrace(self.SecondaryAttackRange, 4, owner:GetMeleeFilter()) --self.MeleeSize is substituted for 4 for the time being
	local trent = tr.Entity

	if not trent:IsValid() or not trent:IsNailed() then return end

	local ent
	local dist
	for _, e in pairs(ents.FindByClass("prop_nail")) do
		if not e.m_PryingOut and e:GetParent() == trent then
			local edist = e:GetActualPos():Distance(tr.HitPos)
			if not dist or edist < dist then
				ent = e
				dist = edist
			end
		end
	end

	if not ent or not gamemode.Call("CanRemoveNail", owner, ent) then return end

	local nailowner = ent:GetOwner()
	if nailowner:IsValid() and nailowner:IsPlayer() and nailowner ~= owner and nailowner:Team() == TEAM_HUMAN and not gamemode.Call("PlayerIsAdmin", owner) and not gamemode.Call("CanRemoveOthersNail", owner, nailowner, ent) then return end

	self:SetNextPrimaryFire(CurTime() + 1)

	ent.m_PryingOut = true -- Prevents infinite loops

	--self:SendWeaponAnim(self.Alternate and ACT_VM_HITCENTER or ACT_VM_MISSCENTER)
	self:playAnim(nil, 1.25, nil, nil, "unnail")

	owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE)

	owner:EmitSound("<phx/epicmetal_hard"..math.random(6, 7)..".ogg")

	ent:GetParent():RemoveNail(ent, nil, self.Owner)

	if nailowner and nailowner:IsValid() and nailowner:IsPlayer() and nailowner ~= owner and nailowner:Team() == TEAM_HUMAN then
		if not gamemode.Call("PlayerIsAdmin", owner) and (nailowner:Frags() >= 75 or owner:Frags() < 75) then
			owner:GivePenalty(30)
			owner:ReflectDamage(20)
		end

		if nailowner:NearestPoint(tr.HitPos):Distance(tr.HitPos) <= 768 and (nailowner:HasWeapon("weapon_zs_hammer") or nailowner:HasWeapon("weapon_zs_electrohammer")) then
			nailowner:GiveAmmo(1, self.Primary.Ammo)
		else
			owner:GiveAmmo(1, self.Primary.Ammo)
		end
	else
		owner:GiveAmmo(1, self.Primary.Ammo)
	end
end

function SWEP:SecondaryAttack()
	local owner = self:GetOwner()
	if owner:GetAmmoCount(self.Primary.Ammo) <= 0 or CurTime() < self:GetNextPrimaryFire() or owner:GetBarricadeGhosting() then return end

	if GAMEMODE:IsClassicMode() then
		owner:PrintTranslatedMessage(HUD_PRINTCENTER, "cant_do_that_in_classic_mode")
		return
	end

	local tr = owner:TraceLine(64, MASK_SOLID, owner:GetMeleeFilter())
	local trent = tr.Entity
	if not trent:IsValid()
	or not util.IsValidPhysicsObject(trent, tr.PhysicsBone)
	or tr.Fraction == 0
	or trent:GetMoveType() ~= MOVETYPE_VPHYSICS and not trent:GetNailFrozen()
	or trent.NoNails
	or trent:IsNailed() and (#trent.Nails >= 8 or trent:GetPropsInContraption() >= GAMEMODE.MaxPropsInBarricade)
	or trent:GetMaxHealth() == 1 and trent:Health() == 0 and not trent.TotalHealth and trent:GetClass() ~= "func_physbox"
	or not trent:IsNailed() and not trent:GetPhysicsObject():IsMoveable() then return end

	if not gamemode.Call("CanPlaceNail", owner, tr) then return end

	local count = 0
	for _, nail in pairs(trent:GetNails()) do
		if nail:GetDeployer() == owner then
			count = count + 1
			if count >= 3 then
				return
			end
		end
	end
	if tr.MatType == MAT_GRATE or tr.MatType == MAT_CLIP then
		owner:PrintTranslatedMessage(HUD_PRINTCENTER, "impossible")
		return
	end
	if tr.MatType == MAT_GLASS then
		owner:PrintTranslatedMessage(HUD_PRINTCENTER, "trying_to_put_nails_in_glass")
		return
	end

	if trent:IsValid() then
		for _, nail in pairs(ents.FindByClass("prop_nail")) do
			if nail:GetParent() == trent and nail:GetActualPos():Distance(tr.HitPos) <= 16 then
				owner:PrintTranslatedMessage(HUD_PRINTCENTER, "too_close_to_another_nail")
				return
			end
		end

		if trent:GetBarricadeHealth() <= 0 and trent:GetMaxBarricadeHealth() > 0 then
			owner:PrintTranslatedMessage(HUD_PRINTCENTER, "object_too_damaged_to_be_used")
			return
		end
	end

	local aimvec = owner:GetAimVector()

	local trtwo = util.TraceLine({start = tr.HitPos, endpos = tr.HitPos + aimvec * 24, filter = {owner, trent}, mask = MASK_SOLID})

	if trtwo.HitSky then return end
	local ent = trtwo.Entity
	if trtwo.HitWorld
	or ent:IsValid() and util.IsValidPhysicsObject(ent, trtwo.PhysicsBone) and (ent:GetMoveType() == MOVETYPE_VPHYSICS or ent:GetNailFrozen()) and not ent.NoNails and not (not ent:IsNailed() and not ent:GetPhysicsObject():IsMoveable()) and not (ent:GetMaxHealth() == 1 and ent:Health() == 0 and not ent.TotalHealth) then
		if trtwo.MatType == MAT_GRATE or trtwo.MatType == MAT_CLIP then
			owner:PrintTranslatedMessage(HUD_PRINTCENTER, "impossible")
			return
		end
		if trtwo.MatType == MAT_GLASS then
			owner:PrintTranslatedMessage(HUD_PRINTCENTER, "trying_to_put_nails_in_glass")
			return
		end

		if ent and ent:IsValid() and (ent.NoNails or ent:IsNailed() and (#ent.Nails >= 8 or ent:GetPropsInContraption() >= GAMEMODE.MaxPropsInBarricade)) and ent:GetClass() ~= "func_physbox" then return end

		if ent:GetBarricadeHealth() <= 0 and ent:GetMaxBarricadeHealth() > 0 then
			owner:PrintTranslatedMessage(HUD_PRINTCENTER, "object_too_damaged_to_be_used")
			return
		end

		if GAMEMODE:EntityWouldBlockSpawn(ent) then return end

		local cons = constraint.Weld(trent, ent, tr.PhysicsBone, trtwo.PhysicsBone, 0, true)
		if cons ~= nil then
			for _, oldcons in pairs(constraint.FindConstraints(trent, "Weld")) do
				if oldcons.Ent1 == ent or oldcons.Ent2 == ent then
					cons = oldcons.Constraint
					break
				end
			end
		end

		if not cons then return end

		self:playAnim(nil, nil, nil, nil, "nail")

		owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE)

		self:SetNextPrimaryFire(CurTime() + 1)
		owner:SetAmmo(owner:GetAmmoCount(self.Primary.Ammo) - 1, self.Primary.Ammo)

		local nail = ents.Create("prop_nail")
		if nail:IsValid() then
			nail:SetNailType(self.NailType)
			nail:SetActualOffset(tr.HitPos, trent)
			nail:SetPos(tr.HitPos - aimvec * 8)
			nail:SetAngles(aimvec:Angle())
			nail:AttachTo(trent, ent, tr.PhysicsBone, trtwo.PhysicsBone)
			nail:Spawn()
			nail:SetDeployer(owner)

			cons:DeleteOnRemove(nail)

			gamemode.Call("OnNailCreated", trent, ent, nail)
			nail:EmitSound("^phx/epicmetal_hard"..math.random(6, 7)..".ogg", 100, 100, 1)
		end
	end
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsValid() then
		if hitent.HitByHammer and hitent:HitByHammer(self, self.Owner, tr) then
			return
		end

		if hitent:IsNailed() then
			local healstrength = GAMEMODE.NailHealthPerRepair * (self.Owner.HumanRepairMultiplier or 1) * self.HealStrength
			local oldhealth = hitent:GetBarricadeHealth()
			if oldhealth <= 0 or oldhealth >= hitent:GetMaxBarricadeHealth() or hitent:GetBarricadeRepairs() <= 0 then return end

			hitent:SetBarricadeHealth(math.min(hitent:GetMaxBarricadeHealth(), hitent:GetBarricadeHealth() + math.min(hitent:GetBarricadeRepairs(), healstrength)))
			local healed = hitent:GetBarricadeHealth() - oldhealth
			hitent:SetBarricadeRepairs(math.max(hitent:GetBarricadeRepairs() - healed, 0))
			self:PlayRepairSound(hitent)
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

end

function SWEP:PlayRepairSound(hitent)
	hitent:EmitSound("npc/dog/dog_servo"..math.random(7, 8)..".ogg", 70, math.random(100, 105))
end
