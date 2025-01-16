-- UELOVR/Level.lua
local BaseClass = require('UELOVR.CoreObject.BaseClass')
local Level = BaseClass:extend()
Level.typeName = "Level"

function Level:initialize(...)
    -- Initialize entities table
    self.entities = {}
end

function Level:update(dt)
    -- Update all entities
    for _, entity in ipairs(self.entities) do
        if entity.update then
            entity:update(dt)
        end
    end
end

function Level:draw(pass)
    -- Draw all entities in the level
    for _, entity in ipairs(self.entities) do
        if entity.draw then
            entity:draw(pass)
        end
    end
end

function Level:addEntity(entity)
    table.insert(self.entities, entity)
end

return Level
