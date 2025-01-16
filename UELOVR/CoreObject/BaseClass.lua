-- Core/BaseClass.lua
local BaseClass = {}
BaseClass.__index = BaseClass
BaseClass.typeName = "BaseClass"

-- Utility function to generate a unique GUID, move to utilities class later
local function generateGUID()
    local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return (template:gsub('[xy]', function(c)
        local v = (c == 'x') and math.random(0, 15) or math.random(8, 11)
        return string.format('%x', v)
    end))
end

-- Constructor
function BaseClass:new(...)
    local obj = setmetatable({}, self)
    obj.guid = generateGUID()
    obj.outer = nil
    obj.flags = {}
    obj.properties = {}
    --- Do we want to initialize class on new? 
    --- We can't provide constructor inputs on new so currently we need to treat initialize as constructor
    --- 
    --if obj.initialize then
    --    obj:initialize(...)
    --end
    return obj
end

-- Inheritance
function BaseClass:extend()
    local subclass = setmetatable({}, self)
    subclass.__index = subclass
    subclass.__base = self -- Track parent class for super()

    -- Override new to create an instance without calling initialize()
    function subclass:new(...)
        return BaseClass.new(self, ...)
    end
    return subclass
end

-- Super Method Access
function BaseClass:super(method, ...)
    local parent = getmetatable(self)
    while parent do
        local base = rawget(parent, "__base")
        if base and base[method] then
            return base[method](self, ...)
        end
        parent = base
    end
    error("Method '" .. method .. "' not found in class '" .. self:type() .. "' or its inheritance chain.")
end

-- Outer/Inner Relationships
function BaseClass:SetOuter(outer)
    self.outer = outer
end

function BaseClass:GetOuter()
    return self.outer
end

-- Type Detection
function BaseClass:type()
    return self.typeName --or (getmetatable(self) and getmetatable(self).typeName) or "Unknown"
end

-- Flags Management
function BaseClass:SetFlag(flag)
    self.flags[flag] = true
end

function BaseClass:HasFlag(flag)
    return self.flags[flag] or false
end

-- Reflection System
function BaseClass:SetProperty(name, value)
    self.properties[name] = value
end

function BaseClass:GetProperty(name)
    return self.properties[name]
end

-- Outer Chain Traversal (e.g., finding a World)
function BaseClass:GetWorld()
    if self.outer then
        if (self.outer == self) then
            return self.outer
        else
            return self.outer:GetWorld() --should I call get outer instead of world?
        end
        --return nil
    end
end

return BaseClass
