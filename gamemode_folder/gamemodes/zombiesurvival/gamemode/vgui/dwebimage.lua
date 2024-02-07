local PANEL = {}

function PANEL:Init()

	self:SetImageColor(Color(255, 255, 255, 255 ))
	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)

	self:SetKeepAspect(false)

	self.ImageName = ""

	self.ActualWidth = 10
	self.ActualHeight = 10

	self:SetMaterial(Material("vgui/avatar_default"))
	self:FixVertexLitMaterial()
end

local DefaultURL = "https://fearsomegaming.com/pa/zsimg/"
local DefaultPath = "zscache/images/"


function PANEL:SetImage(strImage, strBackup, bNoWeb)
	--self.BaseClass.SetImage(self, "data/".. DefaultPath.."1949115705.png")
	--self.BaseClass.SetImage(self, "../../../data/"..path.."1949115705.png")
	strBackup = strBackup or "vgui/avatar_default"
	local url = self.CustomURL or DefaultURL
	local path = self.CustomPath or DefaultPath

	--make sure our path exists
	if not file.Exists(path, "DATA") then
		file.CreateDir(path)
	end

	if not file.Exists(path..strImage, "DATA") then
		--fetch the image
		http.Fetch(url..strImage, 
		
		function(body, ln, headers, code)
			if code == 404 then print("error: 404 returned", strImage, url) return end
			if code == 200 and body then
				file.Write(path..strImage, body)
				self.BaseClass.SetImage(self, "data/"..path..strImage)
			end
		end,

		function(err)
			print("Error when fetching image")
			print("Error:", err)
		end)
		return
	else
		self.BaseClass.SetImage(self, "data/"..path..strImage)
	end

end


function PANEL:SetBaseURL(url)
	self.CustomURL = url
end

function PANEL:SetBasePath(path)
	self.CustomPath = path
end


vgui.Register("DWebImage", PANEL, "DImage")