local Actor = require('UELOVR.GameFramework.Actor')
local Controller = Actor:extend()

function Controller:initialize(...)
    self:super("initialize", ...)
end

function Controller:update(dt)
    -- like tick
    self:super("update", dt) -- Call parent update if necessary

end

function Controller:draw(pass)
    self:super("draw", pass) -- Call parent draw if necessary
end

return Controller