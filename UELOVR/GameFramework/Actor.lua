-- UELOVR/Actor.lua
local BaseClass = require('UELOVR.CoreObject.BaseClass')
local Actor = BaseClass:extend()

function Actor:initialize(...)
    self:super("initialize", ...)
end

function Actor:update(dt)
    -- like tick
    self:super("update", dt) -- Call parent update if necessary

end

function Actor:draw(pass)
    self:super("draw", pass) -- Call parent draw if necessary
end

return Actor