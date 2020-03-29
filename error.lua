
utf8 = require("utf8")

local function error_printer(msg, layer)
	print((debug.traceback("Error: " .. tostring(msg), 1+(layer or 1)):gsub("\n[^\n]+$", "")))
end
 
function love.errorhandler(msg)
	msg = tostring(msg)
 
	error_printer(msg, 2)
 
	if not love.window or not love.graphics or not love.event then
		return
	end
 
	if not love.graphics.isCreated() or not love.window.isOpen() then
		local success, status = pcall(love.window.setMode, 800, 600)
		if not success or not status then
			return
		end
	end
 
	-- Reset state.
	if love.mouse then
		love.mouse.setVisible(true)
		love.mouse.setGrabbed(false)
		love.mouse.setRelativeMode(false)
		if love.mouse.isCursorSupported() then
			love.mouse.setCursor()
		end
	end
	if love.joystick then
		-- Stop all joystick vibrations.
		for i,v in ipairs(love.joystick.getJoysticks()) do
			v:setVibration()
		end
	end
	if love.audio then love.audio.stop() end
 
	love.graphics.reset()
	local font = love.graphics.newFont("bahnschrift.ttf",14)
 
	love.graphics.setColor(1, 1, 1, 1)
 
	local trace = debug.traceback()
 
	love.graphics.origin()
 
	local sanitizedmsg = {}
	for char in msg:gmatch(utf8.charpattern) do
		table.insert(sanitizedmsg, char)
	end
	sanitizedmsg = table.concat(sanitizedmsg)
 
	local err = {}
 
	table.insert(err, "Codes get kicked!\n")
	table.insert(err, sanitizedmsg)
 
	if #sanitizedmsg ~= #msg then
		table.insert(err, "Invalid UTF-8 string in error message.")
	end
 
	table.insert(err, "\n")
 
	for l in trace:gmatch("(.-)\n") do
		if not l:match("boot.lua") then
			l = l:gsub("stack traceback:", "Traceback\n")
			table.insert(err, l)
		end
	end
 
	local p = table.concat(err, "\n")
 
	p = p:gsub("\t", "")
	p = p:gsub("%[string \"(.-)\"%]", "%1")
	start = 0
	finish = 0
 	angle = 0
	local function draw(a)

		local oscillating = function(period, amplitude, offset)
		    period = period or 1
		    amplitude = amplitude or 1
		    offset = offset or 0
		    local t = (offset+love.timer.getTime()) * 2 * math.pi / period
		    return (math.sin(t) + 1) * .5 * amplitude
		end
		local colorosc = oscillating(5,1)
		if start == 0 then
			start = love.timer.getTime()
		end
		if finish == 0 then
			finish = love.timer.getTime() + 10
		end

		local pos = 30
		angle = angle + 15
		if angle > 359 then
			angle = 0
		end
		local aimup = love.graphics.newImage("gfx/samus/aim_diagonal_up.png")
		local xpos = ScrW()-aimup:getWidth()-10
		local ypos = ScrH()-(aimup:getHeight()+10)
		local cl = oscillating(5,.3)
		love.graphics.clear(0,0,0)
		love.graphics.setDefaultFilter( "nearest")
		love.graphics.push()
		love.graphics.setFont(font)
   		love.graphics.printf(p, pos, pos, love.graphics.getWidth() - pos)
  		love.graphics.scale(2,2)
   		love.graphics.draw(aimup,xpos/2-(aimup:getWidth()/2),ypos/2-(aimup:getHeight()/2))--xpos,ypos)
		love.graphics.translate(xpos,ypos)
		love.graphics.rotate(math.rad(angle))
		love.graphics.translate(-xpos,-ypos)
		love.graphics.setColor(1,10,1)


		

		love.graphics.pop()
		love.graphics.present()
	end
 
	local fullErrorText = p
	local function copyToClipboard()
		if not love.system then return end
		love.system.setClipboardText(fullErrorText)
		p = p .. "\nCopied to clipboard!"
		draw()
	end
 
	if love.system then
		p = p .. "\n\nPress Ctrl+C or tap to copy this error"
	end
 
	if love then
		p = p .. "\n\nPress ESC to quit"
	end

	return function()
 		oldtime = 0
 		triggertime = false

		draw(oldtime)
 		
		if love.timer then
			--love.timer.sleep(0.1)
		end

		love.event.pump()
		for e, a, b, c in love.event.poll() do
			if e == "quit" then
				return 0
			elseif e == "keypressed" and a == "q" then
			elseif e == "keypressed" and a == "escape" then
				return 1
			elseif e == "keypressed" and a == "c" and love.keyboard.isDown("lctrl", "rctrl") then
				copyToClipboard()
			elseif e == "touchpressed" then
				local name = love.window.getTitle()
				if #name == 0 or name == "Untitled" then name = "Game" end
				local buttons = {"OK", "Cancel"}
				if love.system then
					buttons[3] = "Copy to clipboard"
				end
				local pressed = love.window.showMessageBox("Quit "..name.."?", "", buttons)
				if pressed == 1 then
					return 1
				elseif pressed == 3 then
					copyToClipboard()
				end
			end
		end
 

	end
 
end
