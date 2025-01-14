-- TestGame/Entities/Player.lua
-- Adding mouse support from the lovr-mouse library
local status, mouse = pcall(require, 'Libraries/lovr-mouse')
if status then
    lovr.mouse = mouse
else
    print("Warning: lovr-mouse library not loaded")
end

local UELOVR = require('UELOVR')
local Player = UELOVR.Pawn:extend()
local PlayerInstance = nil -- Global reference

function Player:new()
    local instance = UELOVR.Pawn.new(self)
    instance.camera = {
        transform = lovr.math.newMat4(),
        position = lovr.math.newVec3(),
        movespeed = 10,
        pitch = 0,
        yaw = 0
    }
    PlayerInstance = instance -- Store reference to player instance
    return instance
end

function Player:initialize()
   -- self.camera.position:set(0, 1000, 0) -- Starting position
   --lovr.mouse.setRelativeMode(true)
end

function Player:update(dt)
    local velocity = vec4()

    if lovr.system.isKeyDown('w', 'up') then
        velocity.z = -1
    elseif lovr.system.isKeyDown('s', 'down') then
        velocity.z = 1
    end

    if lovr.system.isKeyDown('a', 'left') then
        velocity.x = -1
    elseif lovr.system.isKeyDown('d', 'right') then
        velocity.x = 1
    end

    if #velocity > 0 then
        velocity:normalize()
        velocity:mul(self.camera.movespeed * dt)
        self.camera.position:add(self.camera.transform:mul(velocity).xyz)
    end

    self.camera.transform:identity()
    self.camera.transform:translate(0, 1.7, 0)
    self.camera.transform:translate(self.camera.position)
    self.camera.transform:rotate(self.camera.yaw, 0, 1, 0)
    self.camera.transform:rotate(self.camera.pitch, 1, 0, 0)
end

function Player:draw(pass)
    pass:push()
    pass:setViewPose(1, self.camera.transform)
    pass:pop()
end

function lovr.mousemoved(x, y, dx, dy)
    if PlayerInstance then
        PlayerInstance.camera.pitch = PlayerInstance.camera.pitch - dy * .004
        PlayerInstance.camera.yaw = PlayerInstance.camera.yaw - dx * .004
    end
end

function lovr.keypressed(key)
    if key == 'escape' then
        lovr.event.quit()
    end
end

return Player