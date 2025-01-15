-- UELOVR/Level.lua
local BaseClass = require('UELOVR.CoreObject.BaseClass')
local Level = BaseClass:extend()

function Level:initialize(...)

    -- Initialize entities table
    self.entities = {}

    -- Create a physics world if the physics module is available
    self.PhysicsWorld = lovr.physics and lovr.physics.newWorld(0, -9.81, 0, false) or nil
    --if not self.PhysicsWorld then
    --    error("Physics world could not be created. Make sure LOVR's physics module is available.")
    --end
end

function Level:update(dt)
    -- doesn't make sense, world should update level
    -- Update the physics world
    --if self.PhysicsWorld then
    --    self.PhysicsWorld:update(dt)
    --end

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
