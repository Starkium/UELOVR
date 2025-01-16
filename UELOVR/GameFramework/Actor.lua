-- UELOVR/Actor.lua
local BaseClass = require('UELOVR.CoreObject.BaseClass')
local Actor = BaseClass:extend()
Actor.typeName = "Actor"

function Actor:new(...)
    local obj = BaseClass.new(self, ...)
    obj.hasBegunPlay = false -- Track BeginPlay state
    return obj
end

-- BeginPlay Method (Game lifecycle method)
function Actor:beginPlay()
    if not self.hasBegunPlay then
        self.hasBegunPlay = true
        if self.onBeginPlay then
            self:onBeginPlay()
        end
    else
        error(self:type() .. ": beginPlay() called multiple times!")
    end
end

-- Gameplay-specific setup (override in subclasses)
function Actor:onBeginPlay()
    -- Default implementation (can be overridden by subclasses)
    print(self:type() .. " has entered the game world.")
end

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