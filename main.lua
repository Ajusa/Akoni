local cargo = require('lib/cargo')
local sti = require("lib/sti")
local Camera = require("lib/camera")
local Input = require('lib/Input')
local bump = require('lib/bump')
local world = bump.newWorld(16)
local CLASS = { }
local MAP = { }
love.graphics.setDefaultFilter("nearest")
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
local player = {
  x = 500,
  y = 600,
  dx = 0,
  dy = 0
}
world:add(player, player.x, player.y, 16, 16)
local map = 'sample_map'
local chars = love.graphics.newImage("images/char_spritesheet.png")
local top_left = love.graphics.newQuad(0, 0, 16, 16, chars:getDimensions())
love.load = function()
  camera = Camera(player.x, player.x, 2.5)
  camera.smoother = Camera.smooth.damped(10)
  input = Input()
  input:bind('s', 'down')
  input:bind('w', 'up')
  input:bind('a', 'left')
  input:bind('d', 'right')
  return MAP[map]:bump_init(world)
end
love.update = function(dt)
  MAP[map]:update(dt)
  player.dx = 0
  player.dy = 0
  if input:down('down') then
    player.dy = 100
  end
  if input:down('up') then
    player.dy = -100
  end
  if input:down('left') then
    player.dx = -100
  end
  if input:down('right') then
    player.dx = 100
  end
  player.x = player.x + (player.dx * dt)
  player.y = player.y + (player.dy * dt)
  player.x, player.y = world:move(player, player.x, player.y)
  return camera:lockPosition(player.x, player.y)
end
love.draw = function()
  love.graphics.print("Lives: " .. CLASS['Player'].name, 12, 12)
  love.graphics.print("Score: " .. 3, 130, 12)
  local tx = math.floor(camera.x - love.graphics.getWidth() / 2)
  local ty = math.floor(camera.y - love.graphics.getHeight() / 2)
  MAP[map]:draw(-tx * camera.scale, -ty * camera.scale, camera.scale, camera.scale)
  camera:attach()
  love.graphics.draw(chars, top_left, player.x, player.y)
  MAP[map]:bump_draw(world)
  camera:detach()
  return love.graphics.setColor(255, 0, 0)
end
