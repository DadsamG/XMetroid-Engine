
--[[
For MOUSE_FUNCTIONS
Use: MOUSE_LEFT | MOUSE_MIDDLE | MOUSE_RIGHT
	 
]]

local CONFIG_MOUSE = 0x02
local CONFIG_KEY = 0x01

-- GLOBALS: To set what button is used to mouse
MOVE_LEFT = "left"
MOVE_RIGHT = "right"
MOVE_UP = "up"
MOVE_DOWN = "down"

-- Jump Button
MOVE_BUTTON_JUMP = "z"
-- Projectile Button | Select
MOVE_BUTTON_SELECT = "c"
-- Fire Button 
MOVE_BUTTON_FIRE = "x"

-- Diagonal Up
MOVE_BUTTON_DIAGONAL_1 = "a"
-- Diagonal Down
MOVE_BUTTON_DIAGONAL_2 = "b"
-- [Testing] Uses the mouse as aim 
-- Is more recommended to use 
-- MOVE Buttons as WASD | and Shot as Left and Right Click
-- No Select | Middle Mouse Button
-- Change Select | UP / DOWN (Wheel Mouse)

MetroidConfig.Test360 = false

MetroidConfig.ButtonType = CONFIG_KEY
MetroidConfig.Gravity = 6.3 --9.8
