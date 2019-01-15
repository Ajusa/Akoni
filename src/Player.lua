local Player
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    scenes = '*',
    update = function(self, dt)
      self.dx, self.dy = 0, 0
      if input:down('down') then
        self.dy = 100
      end
      if input:down('up') then
        self.dy = -100
      end
      if input:down('left') then
        self.dx = -100
      end
      if input:down('right') then
        self.dx = 100
      end
      return _class_0.__parent.update(self, dt)
    end,
    enable = function(self)
      input:bind('s', 'down')
      input:bind('w', 'up')
      input:bind('a', 'left')
      return input:bind('d', 'right')
    end,
    disable = function(self)
      input:unbind('s')
      input:unbind('w')
      input:unbind('a')
      return input:unbind('d')
    end,
    teleport = function(self, x, y)
      world:update(self, x, y)
      self.x, self.y = x, y
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      self.quad = getChar(0, 11)
      local canvas = love.graphics.newCanvas()
      love.graphics.setCanvas(canvas)
      love.graphics.draw(chars, self.quad, 0, 0)
      love.graphics.setCanvas()
      self.img = love.graphics.newImage(canvas:newImageData())
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
