local gren = {}
gren.name = "40mm_flash"
gren.display = " - 40MM FLASH"
gren.pelletCount = 24
gren.pelletDamage = 12
gren.spread = 0.0000000001
gren.clumpSpread = 0.000001
gren.fireSound = "CW_M203_FIRE_BUCK"
gren.allowSights = true

function gren:fireFunc()
	if self:filterPrediction() then
        self.bulType = 3
		self:FireBullet(gren.pelletDamage, gren.spread, gren.clumpSpread, gren.pelletCount)
        self.bulType = 0
	end
end

CustomizableWeaponry.grenadeTypes:addNew(gren)