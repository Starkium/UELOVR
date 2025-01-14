-- UELOVR/Shader.lua
local Shader = {}

function Shader:new(vertexCode, fragmentCode, uniforms)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self

    instance.shader = lovr.graphics.newShader(vertexCode, fragmentCode)
    instance.uniforms = uniforms or {}

    return instance
end

function Shader:send(name, value)
    self.shader:send(name, value)
end

return Shader