local cargo = require('lib/cargo')
local sti = require("lib/sti")
Camera = require("lib/camera")
local Input = require('lib/Input')
local bump = require('lib/bump')
local Moan = require('lib/Moan')
require('util')
local inspect = require('lib/inspect')
world = bump.newWorld(16)
local kenPixel = love.graphics.newFont("lib/fonts/Kenney Pixel.ttf", 35)
Moan.font = kenPixel
Moan.setSpeed(0.05)
CLASS = { }
MAP = { }
love.graphics.setDefaultFilter('nearest', 'nearest')
chars = love.graphics.newImage("images/char_spritesheet.png")
getChar = function(x, y)
  return love.graphics.newQuad(x + x * 16, y + y * 16, 16, 16, chars:getDimensions())
end
vItems = function()
  local x, y = camera:worldCoords(0, 0)
  return world:queryRect(x, y, love.graphics.getWidth(), love.graphics.getHeight(), function(item)
    return item.__class
  end)
end
local map = ""
changeMap = function(name)
  if not (map == name) then
    map = name
    local items = world:getItems()
    for _index_0 = 1, #items do
      local item = items[_index_0]
      if item.remove then
        item:remove()
      else
        world:remove(item)
      end
    end
    MAP[map]:bump_init(world)
    for _, obj in pairs(MAP[map].objects) do
      if obj.properties.map then
        local p = obj.properties
        CLASS["Teleport"](p.map, p.x, p.y, obj.x, obj.y, obj.width, obj.height)
      end
    end
    for name, c in pairs(CLASS) do
      if c.__name == "Player" then
        player = c()
      end
    end
    for name, c in pairs(CLASS) do
      if c.scenes == map then
        c()
      end
    end
  end
end
love.keypressed = function(key)
  return Moan.keypressed(key)
end
love.load = function()
  input = Input()
  cargo.init({
    dir = 'src',
    processors = {
      ['.'] = function(code, fn)
        if fn:match("[^.]+$") == 'lua' then
          CLASS[code.__name] = code
        end
      end
    }
  })(true)
  cargo.init({
    dir = 'maps',
    processors = {
      ['.'] = function(code, fn)
        if fn:match("[^.]+$") == 'lua' then
          MAP[fn:match("^.+/(.+)$"):sub(1, -5)] = sti(fn, {
            "bump"
          })
        end
      end
    }
  })(true)
  camera = Camera(0, 0, 2.5)
  camera.smoother = Camera.smooth.damped(10)
  changeMap("sample_map")
  player:teleport(32 * 16, 39 * 16)
  return Moan.speak({
    "Akoni",
    {
      0,
      255,
      0
    }
  }, {
    "Welcome to the game!",
    "This is a fun game!"
  }, {
    onstart = function()
      return player:disable()
    end,
    oncomplete = function()
      return player:enable()
    end
  })
end
love.update = function(dt)
  MAP[map]:update(dt)
  camera:lockPosition(player.x, player.y)
  local _list_0 = vItems()
  for _index_0 = 1, #_list_0 do
    local item = _list_0[_index_0]
    if item.alive then
      item:update(dt)
      local cols
      item.x, item.y, cols = world:move(item, item.x, item.y)
      for _index_1 = 1, #cols do
        local col = cols[_index_1]
        if col.other.collide and col.other.alive then
          col.other:collide(item)
        end
      end
    end
  end
  return Moan.update(dt)
end
love.draw = function()
  local tx = math.floor(camera.x - (love.graphics.getWidth() / camera.scale) / 2)
  local ty = math.floor(camera.y - (love.graphics.getHeight() / camera.scale) / 2)
  MAP[map]:draw(-tx, -ty, camera.scale, camera.scale)
  camera:attach()
  local _list_0 = vItems()
  for _index_0 = 1, #_list_0 do
    local item = _list_0[_index_0]
    item:draw()
  end
  camera:detach()
  love.graphics.setFont(kenPixel)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 12, 12)
  return Moan.draw()
end
