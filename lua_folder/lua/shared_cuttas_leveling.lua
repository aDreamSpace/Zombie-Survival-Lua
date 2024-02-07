local ply = FindMetaTable("Player")

function ply:giveExp(exp)

	self:SetNWInt("cutta_Experience",self:GetNWInt("cutta_Experience",0)+tonumber(exp))
	self:SetNWInt("cutta_TotalExperience",self:GetNWInt("cutta_TotalExperience",0)+tonumber(exp))
	update_cutta_levels_leaderboards(self, self:GetNWInt("cutta_TotalExperience",0), self:GetNWInt("cutta_Level",1))
	local nlevel = GetGlobalInt("cutta_leveling_xpmultiply_per_level", 1) * self:GetNWInt("cutta_Level",1)

	if(self:GetNWInt("cutta_Experience",0) >= nlevel) then
		self:SetNWInt("cutta_Level",self:GetNWInt("cutta_Level",1)+1)
		self:LevelUp()
		self:giveExp(0)
	end

	net.Start("DR_Experienced")
	net.WriteFloat(exp)
	net.Send(self)

end

function ply:LevelUp()
	self:SetNWInt("cutta_SkillPoints",self:GetNWInt("cutta_SkillPoints") + 1)
	self:SetNWInt("cutta_Experience",0)
	if(self:GetLevel()%10 == 0) then
		--self:SetNWInt("SkillPoints",self:GetNWInt("SkillPoints") + 1)
	end

	if(self:GetLevel() == 50) then
	//	self:AddPoints(49000)
	end
end

function ply:GetLevel()
	return tonumber(self:GetNWInt("cutta_Level",1))
end

function ply:GetExp(t)
	if(t == nil) then t = 0 end

	if(t == 0) then
		return self:GetNWInt("cutta_Experience",0)
	elseif(t == 1) then
		local nlevel = GetGlobalInt("cutta_leveling_xpmultiply_per_level", 1) * self:GetNWInt("cutta_Level",1)
		local blevel = GetGlobalInt("cutta_leveling_xpmultiply_per_level", 1) * self:GetNWInt("cutta_Level",1) 
		local a = self:GetNWInt("cutta_Experience",0)
		return (a/blevel)/(nlevel/blevel)

	elseif(t == 2) then
		return GetGlobalInt("cutta_leveling_xpmultiply_per_level", 1) * self:GetNWInt("cutta_Level",1)
	end

end

function ply:GetLevelColor()
	local l = tonumber(self:GetLevel() or 1)
	if(l < 10) then
		return Color(241,241,241)
	elseif(l < 20) then
		return Color(46, 204, 113)
	elseif(l < 30) then
		return Color(52, 152, 219)
	elseif(l < 40) then
		return Color(155, 89, 182)
	elseif(l < 50) then
		return Color(230, 126, 34)
	else
		return Color(241, 196, 15)
	end
end

--------shared variables-------------------

cuttas_leveling_ammoregen_ammotimeadjusted = 120