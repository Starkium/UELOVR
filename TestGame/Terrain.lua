-- UELOVR/Terrain.lua
local UELOVR = require('UELOVR')
local Terrain = UELOVR.Actor:extend()
Terrain.typeName = "Terrain"



local function grid(size, subdivisions)
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

local function terrain_fn(x, z)
    return 4 * (lovr.math.noise(x * 0.05, z * 0.05) - 0.5)
end

-- Haven't confirmed, but the order in which you write stuff seems to matter for local functions


function Terrain:initialize(size)
    self.size = size or 50

    self.material = require('TestGame.MaterialsLibrary.TerrainMaterial'):new()
    if not self.material then
        error("Material creation failed!")
        return
    end

    print("Generating terrain mesh...")
    self.vertices, self.indices = grid(size, 100)
    for vi = 1, #self.vertices do
        local x,y,z = unpack(self.vertices[vi])
        self.vertices[vi][2] = terrain_fn(x, z) -- elevate grid to terrain height
    end
    self.mesh = lovr.graphics.newMesh(self.vertices)
    if not self.mesh then
        error("Mesh generation failed!")
        return
    end

    self:GetWorld().physicsWorld:newTerrainCollider(self.size, terrain_fn) -- use callback to define elevations

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

return Terrain
