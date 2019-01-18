cargo = require('lib/cargo')
sti = require("lib/sti")
Camera = require("lib/camera")
Input = require('lib/Input')
bump = require('lib/bump')
Moan = require('lib/Moan')
inspect = require('lib/inspect')
Timer = require('lib/timer')
Convoke = require('lib/convoke')
Bind = require('lib/bind')
do
  local _class_0
  local _base_0 = {
    update = function(self, dt)
      self.x = self.x + (self.dx * dt)
      self.y = self.y + (self.dy * dt)
    end,
    draw = function(self)
      if self.img then
        return love.graphics.draw(self.img, self.x - self.pad, self.y - self.pad)
      end
    end,
    remove = function(self)
      if self.alive then
        self.alive = false
        return world:remove(self)
      end
    end,
    getChar = function(self, r, c, x, y, w, h)
      if x == nil then
        x = 0
      end
      if y == nil then
        y = 0
      end
      if w == nil then
        w = 16
      end
      if h == nil then
        h = 16
      end
      local quad = love.graphics.newQuad(x + r + r * 16, y + c + c * 16, w, h, chars:getDimensions())
      local canvas = love.graphics.newCanvas()
      love.graphics.setCanvas(canvas)
      love.graphics.draw(chars, quad, 0, 0)
      love.graphics.setCanvas()
      self.img = love.graphics.newImage(canvas:newImageData())
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      if not (self.x) then
        self.x = 0
      end
      if not (self.y) then
        self.y = 0
      end
      if not (self.dx) then
        self.dx = 0
      end
      if not (self.dy) then
        self.dy = 0
      end
      if not (self.width) then
        self.width = 16
      end
      if not (self.height) then
        self.height = 16
      end
      if not (self.pad) then
        self.pad = 0
      end
      self.alive = true
      return world:add(self, self.x, self.y, self.width - (2 * self.pad), self.height - (2 * self.pad))
    end,
    __base = _base_0,
    __name = "Entity"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Entity = _class_0
end
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    say = function(self, title, msg, cb)
      local call
      if cb then
        call = cb
      else
        do
          local _base_1 = player
          local _fn_0 = _base_1.enable
          call = function(...)
            return _fn_0(_base_1, ...)
          end
        end
      end
      return Moan.speak(title, msg, {
        onstart = function()
          return player:disable()
        end,
        oncomplete = function()
          return call()
        end,
        image = self.profile
      })
    end,
    teleport = function(self, x, y)
      world:update(self, x, y)
      self.x, self.y = x, y
    end,
    moveTo = function(self, x, y, cb)
      x, y = x * 16, y * 16
      local time = distance(self, {
        x = x,
        y = y
      }) / self.speed
      Timer.tween(time, self, {
        x = x,
        y = y
      })
      return Timer.after(time, cb)
    end,
    remove = function(self)
      if self.data then
        STATE[self.__class.__name] = self.data
      end
      return _class_0.__parent.__base.remove(self)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      local canvas = love.graphics.newCanvas()
      love.graphics.setCanvas(canvas)
      love.graphics.draw(self.img, 0, 0, 0, 22, 22)
      love.graphics.setCanvas()
      if not (self.speed) then
        self.speed = 100
      end
      self.profile = love.graphics.newImage(canvas:newImageData())
      if STATE[self.__class.__name] then
        self.data = STATE[self.__class.__name]
      end
      return _class_0.__parent.__init(self)
    end,
    __base = _base_0,
    __name = "NPC",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  NPC = _class_0
end
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    collide = function(self, other)
      if other.__class.__name == "Player" then
        return table.insert(EVENT, function()
          changeMap(self.to)
          return player:teleport(self.tx * 16, self.ty * 16)
        end)
      end
    end,
    filter = function(self, other)
      return "cross"
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, obj)
      local to = obj.properties
      self.x, self.y = obj.x, obj.y
      self.width, self.height = obj.width, obj.height
      self.to = to.map
      self.tx, self.ty = to.x, to.y
      return _class_0.__parent.__init(self)
    end,
    __base = _base_0,
    __name = "Teleport",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Teleport = _class_0
end
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    collide = function(self, other)
      if other.__class.__name ~= "Player" and other.health then
        other.health = other.health - self.damage
        return self:remove()
      end
    end,
    filter = function(self, other)
      return "cross"
    end,
    draw = function(self)
      return love.graphics.draw(self.img, self.x - self.pad, self.y - self.pad, self.angle + 90)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, obj)
      self.x, self.y = obj.x, obj.y
      self.width, self.height = 10, 10
      self.damage = 2
      self.speed = obj.speed
      self.angle = obj.angle
      self.dx = self.speed * math.cos(self.angle)
      self.dy = self.speed * math.sin(self.angle)
      self.timer = Timer.after(.3, function()
        return self:remove()
      end)
      self:getChar(43, 9, 0, 0, 8)
      return _class_0.__parent.__init(self)
    end,
    __base = _base_0,
    __name = "Dagger",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Dagger = _class_0
end
distance = function(p1, p2)
  return math.sqrt((p2.x - p1.x) ^ 2 + (p2.y - p1.y) ^ 2)
end
