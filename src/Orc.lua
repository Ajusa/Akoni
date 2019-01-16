local Orc
do
  local _class_0
  local _parent_0 = NPC
  local _base_0 = {
    scenes = 'sample_map',
    update = function(self, dt)
      local angle = math.atan2(player.y - self.y, player.x - self.x)
      self.dx, self.dy = self.speed * math.cos(angle), self.speed * math.sin(angle)
      if self.health <= 0 then
        self:remove()
      end
      return _class_0.__parent.__base.update(self, dt)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      self:getChar(0, 3)
      self.pad = 3
      self.x, self.y = 35 * 16, 45 * 16
      self.health = 5
      self.speed = 50
      return _class_0.__parent.__init(self)
    end,
    __base = _base_0,
    __name = "Orc",
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
  Orc = _class_0
  return _class_0
end
