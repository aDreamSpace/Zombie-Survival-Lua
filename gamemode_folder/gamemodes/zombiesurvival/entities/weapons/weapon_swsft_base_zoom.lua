
-----------------------------------------------------
AddCSLuaFile()


SWEP.Base = "weapon_swsft_base"


function SWEP:Reload()
	if (self:Clip1() < self.Primary.ClipSize) then
		if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
			self:EmitSound( self.ReloadSound )
		end
		self:DefaultReload( ACT_VM_RELOAD );
		if not self.Owner:GetViewModel():GetSequenceName(self.Owner:GetViewModel():GetSequence()):find("reload") then
			self:DefaultReload(ACT_VM_RELOAD_EMPTY)
		end
		if self:GetIronsights() then
			self:SetIronsights(false)
			self.Owner:GetViewModel():SetNoDraw(false)
			self.Owner:SetFOV( 0, 0.25 )
		end
		self:SetReloading(true)
		self:SetReloadStart(CurTime())
		self:SetReloadEnd(CurTime() + self.Owner:GetViewModel():SequenceDuration())
	end
end

function SWEP:SecondaryAttack()
	if self:GetIronsights() then
		self:SetIronsights(false)
		self.Owner:GetViewModel():SetNoDraw(false)
		self.Owner:SetFOV( 0, 0.25 )
	else
		self:SetIronsights(true)
		self.Owner:GetViewModel():SetNoDraw(true)
		self.Owner:SetFOV( 40, 0.25 )
	end
end

if CLIENT then
	local scope_sniper = surface.GetTextureID("scope/tex_weapon_scope2")
	local scope_sniper_lr = surface.GetTextureID("sprites/scopes/752/scope_synbf3_lr")
	local scope_sniper_ll = surface.GetTextureID("sprites/scopes/752/scope_synbf3_ll")
	local scope_sniper_ul = surface.GetTextureID("sprites/scopes/752/scope_synbf3_ul")
	local scope_sniper_ur = surface.GetTextureID("sprites/scopes/752/scope_synbf3_ur")

	function SWEP:DrawHUD()
		if not self:GetIronsights() then
				
			local x, y
			if ( self.Owner == LocalPlayer() && self.Owner:ShouldDrawLocalPlayer() ) then

				local tr = util.GetPlayerTrace( self.Owner )
				local trace = util.TraceLine( tr )
					
				local coords = trace.HitPos:ToScreen()
				x, y = coords.x, coords.y
					
			else
				x, y = ScrW() / 2.0, ScrH() / 2.0
			end
		
			local scale = 10 * self.Primary.Cone
		
			local LastShootTime = self:GetNetworkedFloat( "LastShootTime", 0 )
			scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))

			surface.SetDrawColor( 255, 0, 0, 255 )
				
			local gap = 40 * scale
			local length = gap + 20 * scale
			surface.DrawLine( x - length, y, x - gap, y )
			surface.DrawLine( x + length, y, x + gap, y )
			surface.DrawLine( x, y - length, x, y - gap )
			surface.DrawLine( x, y + length, x, y + gap )
			return;
		end

		surface.SetDrawColor(255,255,255,250)
		surface.SetTexture(scope_sniper)
		render.UpdateRefractTexture()
		render.UpdateScreenEffectTexture()
		local w,h = surface.GetTextureSize(scope_sniper)
		surface.DrawTexturedRectRotated(ScrW() / 2,ScrH() / 2,ScrH() + 100,ScrH() + 100,0)

		surface.SetDrawColor(0,0,0,250)
		surface.DrawRect(0,0,ScrW() / 2 - (ScrH() + 100) / 2,ScrH())
		surface.DrawRect(ScrW() / 2 + (ScrH() + 100) / 2,0,ScrW(),ScrH())
		draw.Circle(ScrW() / 2,ScrH() / 2, 4, 20, Color(255,50,50,200))
		draw.Circle(ScrW() / 2,ScrH() / 2, 2, 20, Color(50,50,50,200))
	end
end