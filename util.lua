do
  local _class_0
  local _base_0 = {
    update = function(self, dt)
      self.x = self.x + (self.dx * dt)
      self.y = self.y + (self.dy * dt)
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
