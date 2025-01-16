-- UELOVR/UEWorld.lua
local BaseClass = require('UELOVR.CoreObject.BaseClass')
local UEWorld = BaseClass:extend()
UEWorld.typeName = "UEWorld"

function UEWorld:initialize(...)
    self:SetOuter(self)
    self.physicsWorld = lovr.physics.newWorld(0, -9.81, 0, false) or nil
    if not self.entities then
        self.entities = {}
    end
    print("UEWorld initialized - GUID: " .. self.guid)
end

function UEWorld:addEntity(entity)
    if not self.entities then
        self.entities = {}
    end
    table.insert(self.entities, entity)
    entity:SetOuter(self)
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
    self.physicsWorld:update(dt)
end

function UEWorld:draw(pass)
    for _, entity in ipairs(self.entities or {}) do
        if entity.draw then
            entity:draw(pass)
        end
    end
end

return UEWorld