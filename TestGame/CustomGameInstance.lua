-- UELOVR/CustomGameInstance.lua
require('UELOVR')
local GameInstance = require('UELOVR.GameInstance')
local CustomGameInstance = GameInstance:extend()

--local PlayerController = require('TestGame.CustomPlayerController')

function CustomGameInstance:initialize(...)
  self:super("initialize", ...) -- Call immediate parent method
  print("CustomGameInstance custom initialization - GUID: " .. self.guid)
  --self.playerController = require('TestGame.CustomPlayerController'):new()

end

function CustomGameInstance:update(dt)
  --  print("CustomGameInstance updating with property:", self.customProperty)
    --self.playerController:update(dt)
    -- Call the parent update method
    self:super("update", dt)
    --print("CustomGameInstance update - GUID: " .. self.guid)
end


return CustomGameInstance
