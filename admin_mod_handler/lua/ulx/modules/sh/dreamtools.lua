local CATEGORY_NAME = "Sigil Tools"

if SERVER then
        function ulx.createnode(calling_ply)
            if calling_ply:IsAdmin() then
                local pos = calling_ply:GetPos()
                table.insert(nodeLocations, pos)
                ulx.fancyLogAdmin(calling_ply, "#A created a node at " .. tostring(pos))
            end
        end
        local createnode = ulx.command(CATEGORY_NAME, "ulx createnode", ulx.createnode, "!createnode")
        createnode:defaultAccess(ULib.ACCESS_ADMIN)
        createnode:help("Create a sigil node at your current position.")
    
        function ulx.deletenode(calling_ply)
            if calling_ply:IsAdmin() then
                local pos = calling_ply:GetPos()
                for i, nodePos in ipairs(nodeLocations) do
                    if pos:DistToSqr(nodePos) < 10000 then -- Adjust this value as needed
                        table.remove(nodeLocations, i)
                        ulx.fancyLogAdmin(calling_ply, "#A deleted a node at " .. tostring(nodePos))
                        break
                    end
                end
            end
        end
        local deletenode = ulx.command(CATEGORY_NAME, "ulx deletenode", ulx.deletenode, "!deletenode")
        deletenode:defaultAccess(ULib.ACCESS_ADMIN)
        deletenode:help("Delete the nearest sigil node.")
    
        function ulx.deleteallnodes(calling_ply)
            if calling_ply:IsAdmin() then
                for _, ent in ipairs(ents.GetAll()) do
                    if table.HasValue(entities, ent:GetClass()) then
                        ent:Remove()
                    end
                end
                nodeLocations = {}
                ulx.fancyLogAdmin(calling_ply, "#A deleted all nodes")
            end
        end
        local deleteallnodes = ulx.command(CATEGORY_NAME, "ulx deleteallnodes", ulx.deleteallnodes, "!deleteallnodes")
        deleteallnodes:defaultAccess(ULib.ACCESS_ADMIN)
        deleteallnodes:help("Delete all sigil nodes.")
    
        function ulx.savenodes(calling_ply)
            if calling_ply:IsAdmin() then
                -- Convert the table to a string
                local str = util.TableToJSON(nodeLocations)
    
                -- Save the string to a file, named after the current map
                file.Write(game.GetMap() .. "_nodes.txt", str)
                ulx.fancyLogAdmin(calling_ply, "#A saved nodes")
            end
        end
        local savenodes = ulx.command(CATEGORY_NAME, "ulx savenodes", ulx.savenodes, "!savenodes")
        savenodes:defaultAccess(ULib.ACCESS_ADMIN)
        savenodes:help("Save the current sigil nodes.")
    
        function ulx.countsigils(calling_ply)
            local sigilClasses = {"sigil_barricadetower", "sigil_medicaltower", "sigil_ammotower"}
            local count = 0
    
            for _, class in ipairs(sigilClasses) do
                count = count + #ents.FindByClass(class)
            end
    
            ulx.fancyLogAdmin(calling_ply, "#A counted #s sigils on the current map", count)
        end
        local countsigils = ulx.command(CATEGORY_NAME, "ulx countsigils", ulx.countsigils, "!countsigils")
        countsigils:defaultAccess(ULib.ACCESS_ADMIN)
        countsigils:help("Count the number of sigils on the current map.")
    end
    