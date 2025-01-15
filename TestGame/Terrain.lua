-- UELOVR/Terrain.lua
local UELOVR = require('UELOVR')
local Terrain = UELOVR.Actor:extend()
local TerrainMaterial = require('TestGame.MaterialsLibrary.TerrainMaterial')



function Terrain:initialize(size, scale)
    self.size = size or 50
    self.scale = scale or { x = 1, y = 1, z = 1 }

    self.material = TerrainMaterial:new()
    if not self.material then
        error("Material creation failed!")
    end

    print("Generating terrain mesh...")
    self.vertices, self.indices = Grid(size, 100)
    for vi = 1, #self.vertices do
        local x,y,z = unpack(self.vertices[vi])
        self.vertices[vi][2] = Terrain_fn(x, z) -- elevate grid to terrain height
    end
    self.mesh = lovr.graphics.newMesh(self.vertices)
    if not self.mesh then
        error("Mesh generation failed!")
    end
    -- need to pipe world down the chain 
    --PhysicsWorld:newTerrainCollider(size, terrain_fn) -- use callback to define elevations

    print("Terrain initialized successfully.")
end


function Terrain:draw(pass)
    if self.mesh and self.material then
        self.material:apply(pass)
        pass:draw(self.mesh) 
        pass:setWireframe(true)
        pass:setColor(0.388, 0.302, 0.412, 0.1)
        pass:draw(self.mesh)
        pass:setWireframe(false)
        --self.material:reset(pass)
    else
        print("Cannot draw terrain: Mesh or material is missing!")
    end
end

function Terrain:generateMesh()
    local size = self.size
    local scale = self.scale
    local vertices = {}
    local indices = {}
    local mesh = nil

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

    mesh = lovr.graphics.newMesh({ { 'VertexPosition', 'vec3' } }, vertices)
    mesh:setIndices(indices)
    print("Mesh generated with", #vertices, "vertices and", #indices, "indices.")
    return mesh
end

function Grid(size, subdivisions)
    local vertices = {}
    local indices  = {}
    local step = size / (subdivisions - 1)
    for z = -size / 2, size / 2, step do
      for x = -size / 2, size / 2, step do
        table.insert(vertices, {x, 0, z})
        table.insert(vertices, {x, 0, z + step})
        table.insert(vertices, {x + step, 0, z})
        table.insert(vertices, {x, 0, z + step})
        table.insert(vertices, {x + step, 0, z + step})
        table.insert(vertices, {x + step, 0, z})
      end
    end
    return vertices
end

function Terrain_fn(x, z)
    return 4 * (lovr.math.noise(x * 0.05, z * 0.05) - 0.5)
end

return Terrain
