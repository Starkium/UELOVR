-- TestGame/CustomPlayerController.lua
local UELOVR = require('UELOVR')
local CustomPlayerController = UELOVR.PlayerController:extend()

function CustomPlayerController:initialize()
    -- this doesn't make sense to spawn pawn inside controller
    self.pawn = require('TestGame.CustomPawn'):new()
end

function CustomPlayerController:update(dt)
    if self.pawn then
        self.pawn:update(dt)
    end
    --UELOVR.PlayerController.update(self, dt)
    self:super("update", dt) -- Call immediate parent method
end

return CustomPlayerController