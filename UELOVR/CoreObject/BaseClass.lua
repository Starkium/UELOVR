-- LOVRTEST/UELOVR/BaseClass.lua

local BaseClass = {}
BaseClass.__index = BaseClass

-- Utility function to generate a unique GUID
local function generateGUID()
    local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return (template:gsub('[xy]', function(c)
        local v = (c == 'x') and math.random(0, 15) or math.random(8, 11)
        return string.format('%x', v)
    end))
end

-- Create a new instance of the class
function BaseClass:new(...)
    local instance = setmetatable({ guid = generateGUID() }, self)
    return instance
end

-- Allow derived classes to call methods in the inheritance chain
function BaseClass:super(method, ...)
    local parent = getmetatable(self)
    while parent do
        local base = rawget(parent, "__base")
        if base and base[method] then
            return base[method](self, ...)
        end
        parent = base
    end
    error("No method named '" .. method .. "' found in the inheritance chain")
end


-- Set up inheritance with automatic parent method calls
function BaseClass:extend()
    local derivedClass = setmetatable({}, self)
    derivedClass.__index = derivedClass
    derivedClass.__base = self -- Track parent class for super()

    -- Override new to create an instance without calling initialize()
    function derivedClass:new(...)
        return BaseClass.new(self, ...)
    end

    return derivedClass
end


return BaseClass