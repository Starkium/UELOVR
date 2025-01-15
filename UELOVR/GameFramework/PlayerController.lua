-- UELOVR/PlayerController.lua
local Controller = require('UELOVR.GameFramework.Controller')
local PlayerController = Controller:extend()

function PlayerController:initialize()
    self.pawn = nil
end

function PlayerController:update(dt)
    if self.pawn then
        self.pawn:update(dt)
    end
end

return PlayerController