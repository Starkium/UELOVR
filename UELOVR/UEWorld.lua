-- UELOVR/UEWorld.lua
local BaseClass = require('UELOVR.BaseClass')
local UEWorld = BaseClass:extend()

function UEWorld:initialize(...)
    print("UEWorld initialized - GUID: " .. self.guid)
    if not self.entities then
        self.entities = {}
    end
end

function UEWorld:addEntity(entity)
    if not self.entities then
        self.entities = {}
    end
    table.insert(self.entities, entity)
    if entity.initialize then
        entity:initialize()
    end
    print("Entity added to UEWorld")
end

function UEWorld:update(dt)
    for _, entity in ipairs(self.entities or {}) do
        if entity.update then
            entity:update(dt)
        end
    end
end

function UEWorld:draw(pass)
    for _, entity in ipairs(self.entities or {}) do
        if entity.draw then
            entity:draw(pass)
        end
    end
end

return UEWorld