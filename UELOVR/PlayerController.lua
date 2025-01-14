-- UELOVR/PlayerController.lua
local BaseClass = require('UELOVR.BaseClass')
local PlayerController = BaseClass:extend()

function PlayerController:initialize()
    self.pawn = nil
end

function PlayerController:update(dt)
    if self.pawn then
        self.pawn:update(dt)
    end
end

return PlayerController