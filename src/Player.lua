local Player
do
  local _class_0
  local _parent_0 = NPC
  local _base_0 = {
    scenes = '*',
    update = function(self, dt)
      self.dx, self.dy = 0, 0
      if input:down('down') then
        self.dy = self.speed
      end
      if input:down('up') then
        self.dy = -self.speed
      end
      if input:down('left') then
        self.dx = -self.speed
      end
      if input:down('right') then
        self.dx = self.speed
      end
      if input:down('attack', 0.5) then
        self:attack()
      end
      return _class_0.__parent.__base.update(self, dt)
    end,
    enable = function(self)
      input:bind('s', 'down')
      input:bind('w', 'up')
      input:bind('a', 'left')
      input:bind('d', 'right')
      return input:bind('space', 'attack')
    end,
    disable = function(self)
      input:unbind('s')
      input:unbind('w')
      input:unbind('a')
      input:unbind('d')
      return input:unbind('space')
    end,
    filter = function(self, o)
      if o.__class and o.__class.__name == "Dagger" then
        return "cross"
      else
        return "slide"
      end
    end,
    attack = function(self)
      local x, y = camera:worldCoords(love.mouse.getPosition())
      local angle = math.atan2(y - self.y, x - self.x)
      return Dagger({
        x = self.x + 5,
        y = self.y + 5,
        speed = 80,
        angle = angle
      })
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      self:getChar(0, 0)
      self.data = { }
      self.pad = 3
      self.x, self.y = 32 * 16, 39 * 16
      self:enable()
      return _class_0.__parent.__init(self)
    end,
    __base = _base_0,
    __name = "Player",
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
  Player = _class_0
  return _class_0
end
