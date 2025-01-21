--- Credit to the original author of 'Transform' Donald Hays https://gist.github.com/DonaldHays/95e6db3641bd2b3dafe1b0bfeae60f56

-- Define the Math module
local Math = {}

-- Transform Class
--- @class Transform
--- @field position lovr.Vec3
--- @field scale lovr.Vec3
--- @field rotation lovr.Quat
local Transform = {}
Transform.__index = Transform

--- Returns a new Transform object that represents the identity transform.
--- @param position? lovr.Vec3
--- @param scale? lovr.Vec3
--- @param rotation? lovr.Quat
--- @return Transform
function Transform:new(position, scale, rotation)
    local instance = {
        position = position or lovr.math.newVec3(),
        scale = scale or lovr.math.newVec3(1, 1, 1),
        rotation = rotation or lovr.math.newQuat()
    }
    setmetatable(instance, self)
    return instance
end

--- Returns a new temporary `mat4` that represents the transform.
--- @return lovr.Mat4
function Transform:mat4()
    return lovr.math.mat4(self.position, self.scale, self.rotation)
end

--- Returns a new permanent `mat4` that represents the transform.
--- @return lovr.Mat4
function Transform:newMat4()
    return lovr.math.newMat4(self.position, self.scale, self.rotation)
end

--- Fills an existing `mat4` with the transform.
--- @param m lovr.Mat4
--- @return lovr.Mat4
function Transform:fillMat4(m)
    return m:set(self.position, self.scale, self.rotation)
end

-- Register Transform class in Math
Math.Transform = Transform

-- Return the Math module
return setmetatable(Math, {
    __index = function(_, key)
        return rawget(Math, key)
    end
})
