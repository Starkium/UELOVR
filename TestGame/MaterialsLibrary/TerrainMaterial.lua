-- TestGame/Materials/TerrainMaterial.lua
local UELOVR = require('UELOVR')

local TerrainMaterial = UELOVR.Material:new()

function TerrainMaterial:new()
    local vertexShader = [[
        out vec3 vColor;

        vec4 lovrmain() {
            vColor = vec3(VertexPosition.x, VertexPosition.y, VertexPosition.z) * 0.5 + 0.5;
            return Projection * Transform * VertexPosition;
        }
    ]]

    local fragmentShader = [[
        in vec3 vColor;

        vec4 lovrmain() {
            return vec4(vColor, 1.0);
        }
    ]]

    local shader = UELOVR.Shader:new(vertexShader, fragmentShader)
    local instance = UELOVR.Material:new(shader)

    setmetatable(instance, self)
    self.__index = self
    return instance
end

return TerrainMaterial