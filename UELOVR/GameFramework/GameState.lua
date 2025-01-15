-- Core/GameState.lua
local Actor = require('UELOVR.GameFramework.Actor')
local GameState = Actor:extend()

function GameState:initialize(...)
    self:super("initialize", ...)
end

function GameState:update(dt)
    -- like tick
    self:super("update", dt) -- Call parent update if necessary

end
