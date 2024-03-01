local gren = {}
gren.name = "40mm_slug"
gren.display = " - 40MM SLUG"
gren.pelletCount = 1
gren.pelletDamage = 600
gren.spread = 0.05
gren.clumpSpread = 0.0
gren.fireSound = "CW_M203_FIRE_BUCK"
gren.allowSights = true

function gren:fireFunc()
	if self:filterPrediction() then
		self:FireBullet(gren.pelletDamage, gren.spread, gren.clumpSpread, gren.pelletCount)
	end
end

CustomizableWeaponry.grenadeTypes:addNew(gren)