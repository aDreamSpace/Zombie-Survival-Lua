hook.Add( "PrePACEditorOpen", "RestrictToSuperadmin", function( ply )
	if not ply:IsSuperAdmin( ) then
		return false
	end
end )

hook.Add( "PrePACConfigApply", "PACRankRestrict", function( ply )
	if not ply:IsSuperAdmin( ) then 
		return false
	end
end )