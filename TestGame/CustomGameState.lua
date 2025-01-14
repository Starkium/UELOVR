-- TestGame/CustomGameState.lua
local UELOVR = require('UELOVR')
local CustomGameState = UELOVR.GameState:extend()

function CustomGameState:initialize(...)
    self.score = 0
end

function CustomGameState:update(dt)
    self.score = self.score + dt
   -- print("CustomGameState score:", math.floor(self.score))
end

return CustomGameState