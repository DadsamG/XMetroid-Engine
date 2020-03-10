require("metroidworld/world")
require("metroidworld/entity")
require("metroidworld/staticwrl")
require("metroidworld/constructors")

XMetroid = {}
XMetroid.Player2Enabled = true


-- Metroid World. Can Execute XWorld() to get the Box2D Physics
XWorld = {}
-- Player1 or Samus
XSamusP1 = {}

-- Enable the experimental player2. Putting a P2 Hud in Down

XSamusP2 = (Player2Enabled and {} or nil)

