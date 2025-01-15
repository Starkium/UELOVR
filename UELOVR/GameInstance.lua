-- UELOVR/GameInstance.lua
local BaseClass = require('UELOVR.CoreObject.BaseClass')
local GameInstance = BaseClass:extend()

function GameInstance:initialize(...)
    print("GameInstance initialized - GUID: " .. self.guid)
    -- Create and initialize the GameMode
    self.currentGameMode = require('UELOVR.GameFramework.GameMode'):new()
end

function GameInstance:update(dt)
    if self.currentGameMode then
        self.currentGameMode:update(dt)
    end
end

return GameInstance