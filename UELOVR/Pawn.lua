-- UELOVR/Pawn.lua
local BaseClass = require('UELOVR.BaseClass')
local Pawn = BaseClass:extend()

function Pawn:initialize(...)
    self:super("initialize", ...)
end

function Pawn:update(dt)
    -- like tick
    self:super("update", dt) -- Call parent update if necessary

end

function Pawn:draw(pass)
    self:super("draw", pass) -- Call parent draw if necessary
end

return Pawn