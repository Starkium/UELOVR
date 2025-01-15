-- UELOVR/Pawn.lua
local Actor = require('UELOVR.GameFramework.Actor')
local PlayerState = Actor:extend()

function PlayerState:initialize(...)
    self:super("initialize", ...)
end

function PlayerState:update(dt)
    -- like tick
    self:super("update", dt) -- Call parent update if necessary

end


return PlayerState