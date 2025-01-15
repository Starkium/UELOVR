-- ini.lua
local function loadModules(prefix)
    local modules = {}

    -- Helper function to recursively load modules from folders and files
    local function loadFolder(path, base)
        local files = lovr.filesystem.getDirectoryItems(path)
        for _, file in ipairs(files) do
            local fullPath = path .. '/' .. file
            if lovr.filesystem.isFile(fullPath) then
                local moduleName = file:gsub('%.lua$', ''):gsub('/', '.')
                modules[moduleName] = require(base .. '.' .. moduleName)
            elseif lovr.filesystem.isDirectory(fullPath) then
                loadFolder(fullPath, base .. '.' .. file)
            end
        end
    end

    -- Load all files and folders starting from the prefix
    loadFolder(prefix, prefix)

    -- Flatten nested modules into the top-level table
    for name, module in pairs(modules) do
        local flattenedName = name:match('%.?([^%.]+)$') -- Extract the final part of the module name
        modules[flattenedName] = module
    end

    for name, module in pairs(modules) do
        print("Loaded module:", name)
    end
    
    return modules
end

return loadModules(...)


-- Usage in custom classes or main.lua:
-- local UELOVR = require('UELOVR')
-- local MyPawn = UELOVR.Pawn:extend()
-- local CustomClass = UELOVR.BaseClass:extend()
-- etc.