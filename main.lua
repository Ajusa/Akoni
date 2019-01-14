local cargo = require('lib/cargo')
local sti = require("lib/sti")
local Camera = require("lib/camera")
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
local chars = love.graphics.newImage("images/char_spritesheet.png")
getChar = function(x, y)
  return love.graphics.newQuad(x + x * 16, y + y * 16, 16, 16, chars:getDimensions())
end
local map = 'sample_map'
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
  player = CLASS['Player']()
  camera = Camera(player.x, player.x, 2.5)
  camera.smoother = Camera.smooth.damped(10)
  MAP[map]:bump_init(world)
  Moan.speak({
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
  return print(inspect(world:queryRect(0, 0, 10000, 10000, function(item)
    return item.pad
  end)[1].__class.__name, {
    depth = 4
  }))
end
love.update = function(dt)
  MAP[map]:update(dt)
  input:update()
  player:update(dt)
  Moan.update(dt)
  player.x, player.y = world:move(player, player.x, player.y)
  return camera:lockPosition(player.x, player.y)
end
love.draw = function()
  love.graphics.print("Lives: " .. player.x, 12, 12)
  love.graphics.print("Score: " .. 3, 130, 12)
  local tx = math.floor(camera.x - (love.graphics.getWidth() / camera.scale) / 2)
  local ty = math.floor(camera.y - (love.graphics.getHeight() / camera.scale) / 2)
  MAP[map]:draw(-tx, -ty, camera.scale, camera.scale)
  camera:attach()
  love.graphics.draw(chars, player.img, player.x - 3, player.y - 3)
  camera:detach()
  return Moan.draw()
end
