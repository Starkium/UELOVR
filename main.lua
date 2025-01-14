-- main.lua
require('globals')


function lovr.load()
    GameInstance = require('TestGame.CustomGameInstance'):new()
    GameInstance:initialize()

    World = require('TestGame.CustomWorld'):new()
    World:initialize()
end

function lovr.update(dt)
    GameInstance:update(dt)
    World:update(dt)
end

function lovr.draw(pass)
    -- Create a main pass
    --local pass = lovr.graphics.getPass()
    World:draw(pass)
end
