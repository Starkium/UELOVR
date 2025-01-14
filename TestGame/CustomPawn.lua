-- TestGame/CustomPawn.lua
local UELOVR = require('UELOVR')
local CustomPawn = UELOVR.Pawn:extend()

function CustomPawn:initialize(world)
    self.position = { x = 0, y = 1, z = -3 } -- Start slightly off the ground
    self.rotation = { x = 0, y = 0, z = 0 }
    self.speed = 3
    self.world = world
    print("CustomPawn initialized at position:", self.position.x, self.position.y, self.position.z)

    -- Register with the world
    self.world:addEntity(self)
end

return CustomPawn