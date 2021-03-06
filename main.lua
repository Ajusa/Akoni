require('util')
world = bump.newWorld(16)
local kenPixel = love.graphics.newFont("lib/fonts/Kenney Pixel.ttf", 35)
Moan.font = kenPixel
Moan.setSpeed(0.05)
CLASS = { }
MAP = { }
EVENT = { }
STATE = { }
love.graphics.setDefaultFilter('nearest', 'nearest')
chars = love.graphics.newImage("images/char_spritesheet.png")
vItems = function()
  local x, y = Luven.camera:worldCoords(0, 0)
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
        Teleport(obj)
      end
    end
    for name, c in pairs(CLASS) do
      if name == "Player" then
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
  Luven.init()
  Luven.setAmbientLightColor({
    0.5,
    0.5,
    0.5
  })
  Luven.camera:init(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
  Luven.camera:setScale(2.5)
  player_light = Luven.addNormalLight(0, 0, {
    0.9,
    1,
    0
  }, 1, Luven.lightShapes.round, 0)
  return table.insert(EVENT, function()
    changeMap("sample_map")
    return player:teleport(32 * 16, 39 * 16)
  end)
end
love.update = function(dt)
  Timer.update(dt)
  for i = #EVENT, 1, -1 do
    EVENT[i]()
    table.remove(EVENT)
  end
  MAP[map]:update(dt)
  Luven.update(dt)
  Luven.camera:smooth(player.x, player.y, Camera.smooth.damped(10))
  Luven.setLightPosition(player_light, player.x, player.y)
  local _list_0 = vItems()
  for _index_0 = 1, #_list_0 do
    local item = _list_0[_index_0]
    item:update(dt)
    if item.alive then
      local filter
      if item.filter then
        filter = item.filter
      else
        filter = function(i, o)
          return "slide"
        end
      end
      local cols
      item.x, item.y, cols = world:move(item, item.x, item.y, filter)
      for _index_1 = 1, #cols do
        local col = cols[_index_1]
        if col.other.collide then
          col.other:collide(item)
        end
      end
    end
  end
  return Moan.update(dt)
end
love.draw = function()
  local tx = math.floor(Luven.camera.x - (love.graphics.getWidth() / Luven.camera.scaleX) / 2)
  local ty = math.floor(Luven.camera.y - (love.graphics.getHeight() / Luven.camera.scaleY) / 2)
  MAP[map]:draw(-tx, -ty, Luven.camera.scaleX, Luven.camera.scaleY)
  Luven.drawBegin()
  local _list_0 = vItems()
  for _index_0 = 1, #_list_0 do
    local item = _list_0[_index_0]
    item:draw()
  end
  Luven.drawEnd()
  love.graphics.setFont(kenPixel)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 12, 12)
  return Moan.draw()
end
