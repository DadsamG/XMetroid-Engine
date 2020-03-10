local XWorld = {}
local WWorld = nil
local physc = love.physics
hook.add("init","XMetroid-WorldStart",function()
    love.physics.setMeter(64)
    WWorld = physc.newWorld( 0, 9.83*64, true )
    XWorld.PostCreation(WWorld)
end)
function XWorld.PreCreation()
  -- If return false: (Don't create the world). [UNABLE TO USE ONLY THE HUD]
  
  return true
end


function XWorld.PostCreation(world)
  hook.run("XWorld.PostCreation",function(...)end,world)
end


setmetatable(XWorld,{__call = function() return self.World end, World = )
