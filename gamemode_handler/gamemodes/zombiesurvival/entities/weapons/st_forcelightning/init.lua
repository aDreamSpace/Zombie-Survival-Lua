AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

sound.Add( {
	name = "lighting_hands",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 100,
	pitch = 100,
	sound = "weapons/starwars/force_lightning1.wav"
} )

sound.Add( {
	name = "godon_snd",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 100,
	pitch = 125,
	sound = "beams/beamstart5.wav"
} )

function SWEP:Think()
	if !self.Owner:GetActiveWeapon():GetClass() == "st_forcelightning" then
		self.Owner:GodDisable()
	end
	if self.Owner:KeyPressed(IN_RELOAD) then
		if self.Owner:HasGodMode() == false then
			self:StopSound("lighting_hands")
			self.Owner:GodEnable()
			self:EmitSound("godon_snd")
		else
			self.Owner:GodDisable()
			self:EmitSound("friends/friend_online.wav")
		end
	end
	
	if !self.Owner:HasGodMode() then
		if self.Owner:KeyDown(IN_ATTACK2) then
			self:EmitSound("lighting_hands")
		else
			self:StopSound("lighting_hands")
		end
	else return end
	
	self.BaseClass.Think(self)
	self.VElements["muzzleflare"].color.a = math.max(0,self.VElements["muzzleflare"].color.a - 10 * FrameTime() * 60)
	self.VElements["muzzleflare"].size.x = math.max(0,self.VElements["muzzleflare"].size.x - 0.5 * FrameTime() * 60)
	self.VElements["muzzleflare"].size.y = math.max(0,self.VElements["muzzleflare"].size.y - 0.5 * FrameTime() * 60)
	self.VElements["muzzleflare2"].color.a = math.max(0,self.VElements["muzzleflare2"].color.a - 10 * FrameTime() * 60)
	self.VElements["muzzleflare3"].color.a = math.max(0,self.VElements["muzzleflare3"].color.a - 10 * FrameTime() * 60)
	self.WElements["muzzleflare"].color.a = math.max(0,self.WElements["muzzleflare"].color.a - 10 * FrameTime() * 60)
	self.WElements["muzzleflare"].size.x = math.max(0,self.WElements["muzzleflare"].size.x - 0.5 * FrameTime() * 60)
	self.WElements["muzzleflare"].size.y = math.max(0,self.WElements["muzzleflare"].size.y - 0.5 * FrameTime() * 60)
	self.WElements["muzzleflare2"].color.a = math.max(0,self.WElements["muzzleflare2"].color.a - 10 * FrameTime() * 60)
	self.WElements["muzzleflare3"].color.a = math.max(0,self.WElements["muzzleflare3"].color.a - 10 * FrameTime() * 60)
end

dist = 800
function SWEP:PrimaryAttack()
	if self.Owner:HasGodMode() == true then return end

	self:EmitSound("hand_zap")
	
	if IsFirstTimePredicted() then
	
		self.VElements["muzzleflare"].size.x = 20
		self.VElements["muzzleflare"].size.y = 20
		self.VElements["muzzleflare"].color.a = 255
		self.VElements["muzzleflare2"].color.a = 255
		self.VElements["muzzleflare3"].color.a = 255
		self.WElements["muzzleflare"].size.x = 20
		self.WElements["muzzleflare"].size.y = 20
		self.WElements["muzzleflare"].color.a = 255
		self.WElements["muzzleflare2"].color.a = 255
		self.WElements["muzzleflare3"].color.a = 255
	end

	if SERVER then
		local firedtime = 0
		local targ,tab = self:SelectTargets(5,dist)
		for k,v in pairs(targ) do
			if tab[v].dot < 0.8 then continue end
				local dmg = DamageInfo()
				dmg:SetAttacker( self.Owner || self )
				dmg:SetInflictor( self or self.Owner )
				dmg:SetDamage( math.random(10,25) )
				print(dmg:GetDamage())
				v:TakeDamageInfo( dmg )
			end
			local ed = EffectData()
			ed:SetEntity(self)
			ed:SetAttachment(1)
			ed:SetStart( self.Owner:GetPos() + Vector(0,0,30) )
			ed:SetOrigin( self.Owner:GetPos() + Vector(0,0,30) + self.Owner:GetForward() * math.random(dist - 50,dist + 50) + self.Owner:GetRight() * math.random(-80,80) + self.Owner:GetUp() * math.random(-20,20))
			ed:SetFlags(0x0002)
			util.Effect( "effect_arc_tracer", ed, true, true )
		end

	if ( self.Owner:IsNPC() ) then return end
	self.Owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) * self.Primary.Recoil, 0 ) )
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end