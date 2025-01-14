-- UELOVR/Terrain.lua
local lovr = require('lovr')
local UELOVR = require('UELOVR')
local Terrain = UELOVR.BaseClass:extend()
local TerrainMaterial = require('TestGame.MaterialsLibrary.TerrainMaterial')

function Terrain:new(size, scale)
    local instance = {
        size = size or 64,
        scale = scale or { x = 1, y = 1, z = 1 },
        mesh = nil,
        material = TerrainMaterial:new()
    }
    setmetatable(instance, self)
    self.__index = self

    if not instance.material then
        error("Material creation failed!")
    end

    print("Generating terrain mesh...")
    instance:generateMesh()

    if not instance.mesh then
        error("Mesh generation failed!")
    end

    print("Terrain initialized successfully.")
    return instance
end

function Terrain:generateMesh()
    local size = self.size
    local scale = self.scale
    local vertices = {}
    local indices = {}

    for z = 1, size do
        for x = 1, size do
            local y = lovr.math.noise(x / size, z / size) * scale.y
            table.insert(vertices, { (x - size / 2) * scale.x, y, (z - size / 2) * scale.z })
        end
    end

    for z = 1, size - 1 do
        for x = 1, size - 1 do
            local i = (z - 1) * size + x
            table.insert(indices, i)
            table.insert(indices, i + 1)
            table.insert(indices, i + size)
            table.insert(indices, i + 1)
            table.insert(indices, i + size + 1)
            table.insert(indices, i + size)
        end
    end

    self.mesh = lovr.graphics.newMesh({ { 'VertexPosition', 'vec3' } }, vertices)
    self.mesh:setIndices(indices)
    print("Mesh generated with", #vertices, "vertices and", #indices, "indices.")
end

function Terrain:draw(pass)
    if self.mesh and self.material then
        self.material:apply(pass)
        if pass then pass:draw(self.mesh) else print("Warning: No pass provided to Terrain:draw()") end
        self.material:reset(pass)
    else
        print("Cannot draw terrain: Mesh or material is missing!")
    end
end

return Terrain
