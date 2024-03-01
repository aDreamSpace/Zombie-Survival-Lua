local draw_SimpleText = draw.SimpleText
local draw_DrawText = draw.DrawText

local color_blur1 = Color(60, 60, 60, 220)
local color_blur2 = Color(40, 40, 40, 140)
function draw.SimpleTextBlur(text, font, x, y, col, xalign, yalign)
	draw_SimpleText(text, font, x, y, col, xalign, yalign)
end

function draw.DrawTextBlur(text, font, x, y, col, xalign)
	draw_DrawText(text, font, x, y, col, xalign)
end

local colBlur = Color(0, 0, 0)
function draw.SimpleTextBlurry(text, font, x, y, col, xalign, yalign)
	draw_SimpleText(text, font, x, y, col, xalign, yalign)
end

function draw.DrawTextBlurry(text, font, x, y, col, xalign)
	draw_DrawText(text, font, x, y, col, xalign)
end
