-- UELOVR/init.lua

local prefix = (...):gsub('%.[^%.]+$', '')

return {
    BaseClass = require(prefix .. '.BaseClass'),
    Pawn = require(prefix .. '.Pawn'),
    UEWorld = require(prefix .. '.UEWorld'),
    Level = require(prefix .. '.Level'),
    Material = require(prefix .. '.Material'),
    Shader = require(prefix .. '.Shader'),
    GameInstance = require(prefix .. '.GameInstance'),
    GameMode = require(prefix .. '.GameMode'),
    GameState = require(prefix .. '.GameState'),
    PlayerController = require(prefix .. '.PlayerController')
}

-- Usage in custom classes or main.lua:
-- local UELOVR = require('UELOVR')
-- local MyPawn = UELOVR.Pawn:extend()
-- local CustomClass = UELOVR.BaseClass:extend()
-- etc.