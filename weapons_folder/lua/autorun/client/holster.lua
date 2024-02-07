--[[local holsteredgunsconvar = CreateConVar( "cl_holsteredguns", "1", { FCVAR_ARCHIVE, }, "Enable/Disable the rendering of the weapons on any player" )
 
local NEXT_WEAPONS_UPDATE = CurTime()

local AmmoWepInfo = {
	["pistol"] = {vec =  Vector(9, -2.597, 4.9), ang = Angle(-5.844, 1.169, 101.688), bone = "ValveBiped.Bip01_L_Thigh"},
  	["smg1"] = {vec = Vector(-5.715, -5.715, -3.636), ang = Angle(0, 3.506, 90), bone = "ValveBiped.Bip01_R_Thigh"},
	["ar2"] = {vec = Vector(-6.753, -15.065, 5.714), ang = Angle(0, -59.611, -90), bone = "ValveBiped.Bip01_Pelvis"},
   	["buckshot"] = {vec = Vector(3, -8.832, -17.143), ang = Angle(90, 101.688, -90), bone = "ValveBiped.Bip01_L_Thigh"},
  	["gravity"] = {vec = Vector(0, -8, 0), ang = Angle(0, 90, 0), bone = "ValveBiped.Bip01_Pelvis"},
  	["357"] = {vec = Vector(-0.519, -1.558, -7.792), ang = Angle(1.169, 59.61, -90), bone = "ValveBiped.Bip01_Pelvis"},
  	["alyxgun"] = {vec = Vector(0, -8, 0), ang = Angle(0, 90, 0), bone = "ValveBiped.Bip01_Pelvis"}, 
}

local HWepInfo = HWepInfo or {}
hook.Add("PostGamemodeLoaded", "Weaponlists", function()
    for _, v in pairs(weapons.GetList()) do
    local class = v.ClassName
    local tWep = weapons.GetStored(class)
        if tWep then
            local ammo = tWep.Primary.Ammo
            if ammo and AmmoWepInfo[ammo] then
                HWepInfo[class] = {Model = tWep.WM or tWep.WorldModel, Bone = AmmoWepInfo[ammo].bone, BoneOffset = {AmmoWepInfo[ammo].vec, AmmoWepInfo[ammo].ang}}
                print(HWepInfo[class].Model)
                print(class)
            end
        end
    end

    ProcessOverrides()
end)


--overrides go down in this function for priority and render functions etc
function ProcessOverrides()
    HWepInfo[cw_pist_1911].BoneOffset = {vec = Vector(10.909, 0, 3.635), ang = Angle(0, 180, -90)}
	HWepInfo["cw_pist_contender"].BoneOffset = {vec = Vector(16.104, -0.519, 3.635), ang = Angle(0, 169.481, -90)}
	
end
-- 경찰 스턴봉
-- 경찰 체포봉
-- 경찰 체포봉
-- FA:S 2.0 자동소총
local function CalcOffset2(pos,ang,tHWep)
    local offsetPos = tHWep.BoneOffset[1]
    local offsetAng = tHWep.BoneOffset[2]
    pos = pos + ang:Forward() * offsetPos.x + ang:Right() * offsetPos.y + ang:Up() * offsetPos.z
    ang:RotateAroundAxis(ang:Up(), offsetAng.y)
    ang:RotateAroundAxis(ang:Forward(), offsetAng.r)
    ang:RotateAroundAxis(ang:Right(), offsetAng.p)

    return pos, ang
    --return pos + ang:Right() * off.x + ang:Forward() * off.y + ang:Up() * off.z
end
 
local function GetHolsteredWeaponTable(ply,indx)
    return HWepInfo[indx]
end

--local nextThink = 0
local class
local tCLWep
local function thinkdamnit()
    --if nextThink < CurTime() then
        --nextThink = CurTime() + 0.1
        if holsteredgunsconvar:GetBool() then
            for _,pl in ipairs(player.GetAll()) do
                if not pl:IsValid() and not pl:Team() == TEAM_HUMAN then continue end

                if !pl.CL_CS_WEPS then
                    pl.CL_CS_WEPS={}
                end
                
                if !pl:Alive() then pl.CL_CS_WEPS={} continue end
                
                if NEXT_WEAPONS_UPDATE<CurTime() then
                    pl.CL_CS_WEPS={} 
                    NEXT_WEAPONS_UPDATE=CurTime()+5
                end
                
                for i,v in pairs(pl:GetWeapons())do
                    if not v:IsValid() then continue end
                    class = v:GetClass()
                    tCLWep = GetHolsteredWeaponTable(pl,class)
                    if pl.CL_CS_WEPS[class] then continue end
                    
                    if !pl.CL_CS_WEPS[class] then
                        local worldmodel=v.WorldModelOverride or v.WorldModel
                        local attachedwmodel=v.AttachedWorldModel
                        
                        if tCLWep && tCLWep.Model then
                            worldmodel=tCLWep.Model
                        end
                        if !worldmodel || worldmodel=="" then continue end
                        
                        
                        pl.CL_CS_WEPS[class]=ClientsideModel(worldmodel,RENDERGROUP_OPAQUE)
                        pl.CL_CS_WEPS[class]:SetNoDraw(true)
                        pl.CL_CS_WEPS[class]:SetSkin(v:GetSkin())
                        pl.CL_CS_WEPS[class]:SetColor(v:GetColor())
                        
                        if v.MaterialOverride || v:GetMaterial() then
                            pl.CL_CS_WEPS[class]:SetMaterial(v.MaterialOverride || v:GetMaterial())
                        end
                        
                        pl.CL_CS_WEPS[class].WModelAttachment=v.WModelAttachment
                        pl.CL_CS_WEPS[class].WorldModelVisible=v.WorldModelVisible
                        
                        
                        if attachedwmodel then
                            pl.CL_CS_WEPS[class].AttachedModel=ClientsideModel(attachedwmodel,RENDERGROUP_OPAQUE)
                            pl.CL_CS_WEPS[class].AttachedModel:SetNoDraw(true)
                            pl.CL_CS_WEPS[class].AttachedModel:SetSkin(v:GetSkin())
                            pl.CL_CS_WEPS[class].AttachedModel:SetParent(pl.CL_CS_WEPS[class])
                            pl.CL_CS_WEPS[class].AttachedModel:AddEffects( EF_BONEMERGE, EF_BONEMERGE_FASTCULL, EF_PARENT_ANIMATES )
                        end
                    end
                end
            end
        end
    --end
end

local tHWep
local gWep
local priority
local bol
local bone
local bonePelvis
local strPBone = "ValveBiped.Bip01_Pelvis"
local mPBone
local matrix
local vPelvis
local aPelvis
local pos
local ang
local eAW

local function playerdrawdamnit(pl,legs)
    if holsteredgunsconvar:GetBool() and pl:IsValid() and pl.CL_CS_WEPS and not pl.ShadowMan then
        for i,v in pairs(pl.CL_CS_WEPS) do
            tHWep = GetHolsteredWeaponTable(pl,i)
            gWep = pl:GetWeapon(i)
            eAW = pl:GetActiveWeapon()
            if tHWep && (eAW==NULL || eAW:GetClass()~=i) && (gWep and gWep:IsValid()) then
                if tHWep.Priority then
                    priority=tHWep.Priority
                    bol=tHWep && (eAW==NULL || eAW:GetClass()!=priority) && (gWep and gWep:IsValid())
                    if bol then continue end
                end
                
                bone = pl:LookupBone(tHWep.Bone or "")
                if !bone then continue end
                
                matrix = pl:GetBoneMatrix(bone)
                if !matrix then continue end
                pos = matrix:GetTranslation()
                ang = matrix:GetAngles()
                pos, ang = CalcOffset2(pos, ang, tHWep)
                if tHWep.Skin then v:SetSkin(tHWep.Skin) end
                
                v:SetRenderOrigin(pos)     
                v:SetRenderAngles(ang)
                if v.WorldModelVisible==nil || (v.WorldModelVisible!=false) then
                    v:DrawModel()
                end
                
                if v.AttachedModel and v.AttachedModel:IsValid() then
                    v.AttachedModel:DrawModel()
                end
                if v.WModelAttachment && multimodel then
                    multimodel.Draw(v.WModelAttachment, gWep, {origin=pos, angles=ang})
                    multimodel.DoFrameAdvance(v.WModelAttachment, CurTime(), gWep)
                end
                
                if tHWep.DrawFunction then
                    tHWep.DrawFunction(v, pl)
                end
            end
        end
    end
end
hook.Remove("Think", "HG_Think")
hook.Remove("PostPlayerDraw", "HG_Draw")
hook.Add("Think","HG_Think",thinkdamnit)
hook.Add("PostPlayerDraw","HG_Draw",playerdrawdamnit)]]