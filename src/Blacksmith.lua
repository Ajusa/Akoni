local Blacksmith
do
  local _class_0
  local _parent_0 = NPC
  local _base_0 = {
    scenes = "sample_indoor",
    collide = function(self, other)
      if other.__class.__name == "Player" then
        return self:dialog(false)
      end
    end,
    dialog = function(self, cutscene)
      if player.data.token and not cutscene then
        return Convoke(Bind(self.inQuest, self))()
      else
        if not (player.data.token) then
          return Convoke(Bind(self.startQuest, self))()
        end
      end
    end,
    startQuest = function(self, cont, wait)
      player:disable()
      self:moveTo(15, 14, cont())
      wait()
      self:moveTo(16, 17, cont())
      wait()
      self:moveTo(18, 17, cont())
      wait()
      self:say("Blacksmith", {
        "Ah, hello there young’un! Wait! I suppose I can’t call you that anymore. Happy Birthday! What can I do for you this morning?",
        "Ah, what’s this? What a strange token. I’ve never seen a symbol like this before. What fine craftsmanship. Here let me study it a bit more carefully.",
        "In the meanwhile, why don’t ye do something for me? I left my lucky gold ring at the tavern last night. I took it off to brawl someone. Poor sucker wasn’t even able to lay a finger on me.",
        "I’ll tell ye what. Get me my ring back for me and I’ll tell you of the origins of this token, free of charge.",
        "The road to the tavern may be a little dangerous. You’d better take this blade."
      }, cont())
      wait()
      player.data.weapon = true
      player:say({
        "Inventory",
        {
          0,
          255,
          0
        }
      }, {
        "You recieved bronze blade."
      }, cont())
      player:say({
        "Objective",
        {
          255,
          0,
          0
        }
      }, {
        "Ask the tavern server where Blacksmith Bono’s lucky ring is and return in to Bono."
      })
      player.data.token = {
        started = true
      }
    end,
    inQuest = function(self)
      return self:say("Blacksmith", {
        "Well, get a move on! I haven't got all day."
      })
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      self:getChar(1, 6)
      self.x, self.y = 18 * 16, 13 * 16
      _class_0.__parent.__init(self)
      return self:dialog(true)
    end,
    __base = _base_0,
    __name = "Blacksmith",
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
  Blacksmith = _class_0
  return _class_0
end
