-- TestGame/Materials/TerrainMaterial.lua
local UELOVR = require('UELOVR')

local TerrainMaterial = UELOVR.Material:new()

function TerrainMaterial:new()
    local shaderCode = {[[
        /* VERTEX shader */
        out vec4 fragmentView;
        
        vec4 lovrmain() {
          fragmentView = ClipFromLocal * VertexPosition;
          return fragmentView;
        } ]], [[
        /* FRAGMENT shader */
        in vec4 fragmentView;
        
        Constants {
          vec3 fogColor;
        };
        
        vec4 lovrmain() {
          float fogAmount = atan(length(fragmentView) * 0.1) * 2.0 / PI;
          return vec4(mix(Color.rgb, fogColor, fogAmount), Color.a);
        }]]}

    local shader = UELOVR.Shader:new(unpack(shaderCode))
    local instance = UELOVR.Material:new(shader)

    setmetatable(instance, self)
    self.__index = self
    return instance
end

return TerrainMaterial