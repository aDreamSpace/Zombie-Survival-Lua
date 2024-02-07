local Category = "Saints Row 4 Murderbot Playermodel"
list.Set( "PlayerOptionsModel", "murderbot", "Models/player/pizzaroll/murderbot.mdl" )
player_manager.AddValidModel( "murderbot", "Models/player/pizzaroll/murderbot.mdl" )

player_manager.AddValidHands( "murderbot", "Models/weapons/murderbotarms.mdl", 0, "00000000" )

local CBB = {}
function CBB.DrawRottenHands( vm, ply, weapon )
	if CLIENT then
		hskin = MySelf:GetSkin()
		local hands = MySelf:GetHands()
		if ( weapon.UseHands || !weapon:IsScripted() ) then
			if ( IsValid( hands ) ) then
				hands:DrawModel()
				hands:SetSkin(hskin)
			end
		end
	end
end
hook.Add("PostDrawViewModel", "Set player hand skin", CBB.DrawRottenHands)





