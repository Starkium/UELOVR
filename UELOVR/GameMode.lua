-- Core/GameMode.lua
local BaseClass = require('UELOVR.BaseClass')
local GameMode = BaseClass:extend()

function GameMode:initialize()
    -- Create and initialize the GameState
    self.gameState = require('UELOVR.GameState'):new()
    self.gameState:initialize()
end

function GameMode:update(dt)
    if self.gameState then
        self.gameState:update(dt)
    end
end

return GameMode