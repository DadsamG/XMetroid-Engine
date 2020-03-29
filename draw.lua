-- Everything here is executed in love.draw


local delta = love.timer.getTime()
-- Display the frame time in milliseconds for convenience.
-- A lower frame time means more frames per second.
if XState == XSTATE_WORLD then

	love.graphics.setDefaultFilter( "nearest")
	local x, y = love.mouse.getPosition( )
	local samus = love.graphics.newImage("gfx/")
	love.graphics.setColor(0.5,0.5,0.5)
	love.graphics.circle("line",x+math.sin(love.timer.getTime())*14,y+math.cos(love.timer.getTime())*14,16)
	love.graphics.setColor(0,1,0)
	love.graphics.circle("fill",x+math.sin(love.timer.getTime())*14,y+math.cos(love.timer.getTime())*14,14)

end
