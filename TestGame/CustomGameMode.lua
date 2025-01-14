-- TestGame/CustomGameMode.lua
local UELOVR = require('UELOVR')
local CustomGameMode = UELOVR.GameMode:extend()

function CustomGameMode:initialize(...)
    -- Call the parent initialize method
    --self:super("initialize", ...) -- I assume this is like a super() call
    self.levelName = "TestLevel"
    self.gameState = require('TestGame.CustomGameState'):new()
   
end

function CustomGameMode:update(dt)
    -- Call the parent update method
    self:super("update", dt)
    self.gameState:update(dt)
end

return CustomGameMode