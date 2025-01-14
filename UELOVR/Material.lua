-- UELOVR/Material.lua
local Material = {}

function Material:new(shader)
    local instance = {
        shader = shader,
        properties = {}
    }
    setmetatable(instance, self)
    self.__index = self
    return instance
end

function Material:setProperty(name, value)
    self.properties[name] = value
end

function Material:apply(pass)
    if pass then
        pass:setShader(self.shader.shader)
        for name, value in pairs(self.properties) do
            self.shader:send(name, value)
        end
    else
        print("Warning: No pass provided to Material:apply()")
    end
end

function Material:reset(pass)
    if pass then
        pass:setShader(nil)
    else
        print("Warning: No pass provided to Material:reset()")
    end
end

return Material
