-- TestGame/Levels/TestLevel.lua
local UELOVR = require('UELOVR')
local TestLevel = UELOVR.Level:extend()

local Terrain = require('TestGame.Terrain')

--function TestLevel:new()
--  self:super("new")
--  self.grid = self:SetUpGrid()
--end


function TestLevel:initialize(...)
  self:super("initialize", ...) -- Call the base class's initialize method
  self.terrain = Terrain:new(64)
  --self:addEntity(self.terrain) -- don't need this since we manually update
  --self.grid = self:SetUpGrid()
  self.shader = lovr.graphics.newShader([[
    out vec2 scale;

    vec4 lovrmain() {
      scale = vec2(length(Transform[0]), length(Transform[1]));
      return DefaultPosition;
    }
  ]], [[
    uniform float lineWidth;
    uniform vec3 background;
    uniform vec3 foreground;

    in vec2 scale;

    vec4 lovrmain() {
      vec2 uv = (UV - 1.) * scale;
      vec4 uvDDXY = vec4(dFdx(uv), dFdy(uv));
      vec2 uvDeriv = vec2(length(uvDDXY.xz), length(uvDDXY.yw));
      vec2 drawWidth = clamp(vec2(lineWidth), uvDeriv, vec2(.5));
      vec2 lineAA = uvDeriv * 1.5;
      vec2 gridUV = 1.0 - abs(fract(uv) * 2. - 1.);
      vec2 grid2 = smoothstep(lineWidth + lineAA, lineWidth - lineAA, gridUV);
      grid2 *= clamp(lineWidth / drawWidth, 0., 1.);
      grid2 = mix(grid2, vec2(lineWidth), clamp(uvDeriv * 2. - 1., 0., 1.));
      float grid = mix(grid2.x, 1., grid2.y);
      vec3 rgb = mix(gammaToLinear(background), gammaToLinear(foreground), grid);
      return vec4(rgb, 1.);
    }
  ]])

end

function TestLevel:update(dt)
  self:super("update", dt)
    if self.terrain then
        self.terrain:update(dt)
    end
end

function TestLevel:draw(pass)
  self:super("draw", pass)
    if self.terrain then
        self.terrain:draw(pass)
    end
    --if self.grid then
        pass:setShader(self.shader)
        pass:send('lineWidth', .005)
        pass:send('background', { .05, .05, .05 })
        pass:send('foreground', { .5, .5, .5 })
        pass:plane(0, 0, 0, 200, 200, -math.pi / 2, 1, 0, 0)
        --print("Drawing Grid manually")
        --pass:setShader(nil)
    --end
    --print("Test Level Drawing")
end

function TestLevel:SetUpGrid()
  local shader = lovr.graphics.newShader([[
    out vec2 scale;

    vec4 lovrmain() {
      scale = vec2(length(Transform[0]), length(Transform[1]));
      return DefaultPosition;
    }
  ]], [[
    uniform float lineWidth;
    uniform vec3 background;
    uniform vec3 foreground;

    in vec2 scale;

    vec4 lovrmain() {
      vec2 uv = (UV - 1.) * scale;
      vec4 uvDDXY = vec4(dFdx(uv), dFdy(uv));
      vec2 uvDeriv = vec2(length(uvDDXY.xz), length(uvDDXY.yw));
      vec2 drawWidth = clamp(vec2(lineWidth), uvDeriv, vec2(.5));
      vec2 lineAA = uvDeriv * 1.5;
      vec2 gridUV = 1.0 - abs(fract(uv) * 2. - 1.);
      vec2 grid2 = smoothstep(lineWidth + lineAA, lineWidth - lineAA, gridUV);
      grid2 *= clamp(lineWidth / drawWidth, 0., 1.);
      grid2 = mix(grid2, vec2(lineWidth), clamp(uvDeriv * 2. - 1., 0., 1.));
      float grid = mix(grid2.x, 1., grid2.y);
      vec3 rgb = mix(gammaToLinear(background), gammaToLinear(foreground), grid);
      return vec4(rgb, 1.);
    }
  ]])
  return shader
end

return TestLevel
