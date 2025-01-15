-- Core/GameMode.lua
local Actor = require('UELOVR.GameFramework.Actor')
local GameMode = Actor:extend()

function GameMode:initialize()
    -- Create and initialize the GameState
    self.gameState = require('UELOVR.GameFramework.GameState'):new()
    self.gameState:initialize()
end

function GameMode:update(dt)
    if self.gameState then
        self.gameState:update(dt)
    end
end

return GameMode