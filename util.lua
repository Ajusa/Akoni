cargo = require('lib/cargo')
sti = require("lib/sti")
Camera = require("lib/camera")
Input = require('lib/Input')
bump = require('lib/bump')
Moan = require('lib/Moan')
inspect = require('lib/inspect')
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
    collide = function(self, other)
      return "slide"
    end,
    remove = function(self)
      self.alive = false
      return world:remove(self)
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
    collide = function(self, other)
      changeMap(self.to)
      return player:teleport(self.tx * 16, self.ty * 16)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, obj)
      local to = obj.properties
      self.x, self.y = obj.x, obj.y
      self.width, self.height = obj.width, obj.width
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
    update = function(self, dt)
      self.x = self.x + (self.dx * dt)
      self.y = self.y + (self.dy * dt)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
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
