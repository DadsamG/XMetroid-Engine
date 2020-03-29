-- This or everything. any data like how much lua files executed.
-- Will appears at Game.LuaFileAutorun as table
Game = {}
Game.RunFilesDirectories = {
	Autorun = "autorun/"
}
Game["ErrorTryFix"] = {}
GameFiles = {}
APPLICATION_MODE = "DEBUG"
do
	MetroidConfig = {}
	require "metroidconfig"
	Game.Config = MetroidConfig
	MetroidConfig = nil
	collectgarbage("collect")
end


ScrW = love.graphics.getWidth
ScrH = love.graphics.getHeight
require "error"
util = require "util"
breezefield = nil--require("breezefield")
require "hook"
XState = 0
XSTATE_MAINMENU = 0
XSTATE_LOAD = 1
XSTATE_WORLD = 2

GameFiles.Init = love.filesystem.load("init.lua")

function love.load()
	hook.Run("main")
	if love.filesystem.getInfo( "init.lua" ) then
		FUNCTION_ARGUMENT_1 = dt 
		GameFiles.Init()
	end
	XWorld = love.physics.newWorld(0, 0, true)
	local samus_widthheightcalc = love.image.newImageData( "gfx/colliderbounds.png" )
	local samus_offswidth,samus_offsheight = util.getPixelFromColor(samus_widthheightcalc,{
		red = 1,
		blue = 1,
		green = 1,
		alpha = 1
	})
	local samus_width, samus_height = samus_widthheightcalc:getDimensions()

	XSamus = XSamus or {}
	XSamus.Body = love.physics.newBody(XWorld,0,0,"dynamic")
	XSamus.Collider = love.physics.newRectangleShape(samus_width,samus_height)
	XSamus.Fixture = love.physics.newFixture(XSamus.Body,XSamus.Collider)
	--Game.ErrorTryFix["SetGravity"] = nil

	GameFiles.Autoruns = {}
	local files = love.filesystem.getDirectoryItems("autorun")
	if APPLICATION_MODE == DEBUG then
		local luafiles = {}
		print("[Starting Autorun Execute]")
		for k, file in ipairs(files) do 
			if string.match(file,".*%.lua") then luafiles[#luafiles+1] = file end
		end
		print("	Running "..#luafiles.." files")
	end
	for k, file in ipairs(files) do
		if string.match(file,".*%.lua") then
			print(file)
			local fileload = love.filesystem.load("autorun/"..file)
			if fileload then 
				fileload()
				GameFiles.Autoruns[file] = fileload
			end
		end
	end	
	print("[Finished Autorun Execute]")
end

GameFiles.Draw = love.filesystem.load("draw.lua")
function love.draw()
	hook.Run("draw")
	if love.filesystem.getInfo( "draw.lua" ) then
		FUNCTION_ARGUMENT_1 = dt 
		GameFiles.Draw()
	end
end
-- If all file of autorun folder is executed.
-- If it be false. will run everything causing errors
Game.AutorunExecuted = false
GameFiles.Update = love.filesystem.load("update.lua")
function love.update(dt) 
	XWorld:update(dt)
	if love.filesystem.getInfo( "update.lua" ) then
		FUNCTION_ARGUMENT_1 = dt 
		GameFiles.Update()
	end
	hook.Run("update",dt)
	if Game.AutorunExecuted == false then
		local dir = "autorun/"
		local files = love.filesystem.getDirectoryItems(dir)
		for k, file in ipairs(files) do
			if string.match(file,"*.lua") then
				Game.LuaFileAutorun[#Game.LuaFileAutorun+1] = file 
				dofile(file)
			end
		end
		Game.AutorunExecuted = true
	end
	collectgarbage("collect")

end

function love.keypressed(k,c,d)
	print(k,c,d)
	if k == "b" then
		XState = XSTATE_WORLD
	end
end

function love.quit()
	hook.Run("quit",true)
end

-- Highest loop
