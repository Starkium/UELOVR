-- TestGame/CustomWorld.lua
local UELOVR = require('UELOVR')
local CustomWorld = UELOVR.UEWorld:extend()
CustomWorld.typeName = "CustomWorld"

local TestLevel = require('TestGame.Levels.TestLevel')
local Player = require('TestGame.Core.Entities.Player')

function CustomWorld:initialize(...)
    self:super("initialize", ...) -- Call immediate parent method
    print("CustomWorld initialized - GUID: " .. self.guid)

    self.entities = {} -- redundant?

    self.currentLevel = TestLevel:new()
    self.currentLevel:SetOuter(self)
    self.currentLevel:initialize(self) -- because it's not in the entities list, perhaps make a section for levels

    self.player = self:addEntity(Player:new())

    skyColor = {0.529, 0.808, 0.922}
    lovr.graphics.setBackgroundColor(skyColor)
end

function CustomWorld:update(dt)
    self:super("update", dt)
    
end

function CustomWorld:draw(pass)
    self:super("draw", pass)
    self.currentLevel:draw(pass)
end

return CustomWorld