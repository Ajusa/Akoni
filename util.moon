export *
cargo = require 'lib/cargo'
sti = require "lib/sti"
Camera = require "lib/camera"
Input = require 'lib/Input'
bump = require 'lib/bump'
Moan = require 'lib/Moan'
inspect = require 'lib/inspect'
Timer = require 'lib/timer'
Convoke = require 'lib/convoke'
Bind = require 'lib/bind'
class Entity
	new: =>
		@x = unless @x then 0
		@y = unless @y then 0
		@dx = unless @dx then 0
		@dy = unless @dy then 0
		@width = unless @width then 16
		@height = unless @height then 16
		@pad = unless @pad then 0
		@alive = true
		world\add(self, @x, @y, @width-(2*@pad), @height-(2*@pad))
	update: (dt) =>
		@x += @dx * dt
		@y += @dy * dt
	draw: =>
		if @img then love.graphics.draw(@img, @x-@pad, @y-@pad)
	remove: () => 
		if @alive
			@alive = false
			world\remove(self)
	getChar: (r, c, x = 0, y = 0, w = 16, h = 16) => 
		quad = love.graphics.newQuad(x+ r + r*16, y + c + c*16, w, h, chars\getDimensions())
    	canvas = love.graphics.newCanvas()
    	love.graphics.setCanvas(canvas)
    	love.graphics.draw(chars, quad, 0, 0)
    	love.graphics.setCanvas()
    	@img = love.graphics.newImage(canvas\newImageData!)

class NPC extends Entity
	new: =>
    	canvas = love.graphics.newCanvas()
    	love.graphics.setCanvas(canvas)
    	love.graphics.draw(@img, 0, 0, 0, 22, 22) --resize by a factor of 22 for moan
    	love.graphics.setCanvas()
    	@speed = unless @speed then 100
		@profile = love.graphics.newImage(canvas\newImageData!)
		if STATE[@__class.__name] then @data = STATE[@__class.__name] 
		super!
	say: (title, msg, cb) =>
		call = if cb then cb else player\enable
		Moan.speak(title, msg, {
			onstart: () -> player\disable!,
			oncomplete: ()-> call!,
			image: @profile
		})
	teleport: (x, y) => 
		world\update(self, x, y)
		@x, @y = x, y
	moveTo: (x, y, cb) =>
		x, y = x*16, y*16
		time = distance(self, {:x, :y})/@speed
		Timer.tween(time, self, {:x, :y})
		Timer.after(time, cb)
	remove: () =>
		if @data then STATE[@__class.__name] = @data
		super!
class Teleport extends Entity
	new: (obj) =>
		to = obj.properties
    	@x, @y = obj.x, obj.y
    	@width, @height = obj.width, obj.height
    	@to = to.map
    	@tx, @ty = to.x, to.y
    	super!
    collide: (other) =>
    	if other.__class.__name == "Player"
	    	table.insert(EVENT, ->
				changeMap(@to)
	    		player\teleport(@tx*16, @ty*16)
	    	)
    --draw: => love.graphics.rectangle("fill", @x, @y, @width, @height )
    filter: (other) =>  "cross"
class Dagger extends Entity
	new: (obj) =>
    	@x, @y = obj.x, obj.y
    	@width, @height = 10, 10
    	@damage = 2
    	@speed = obj.speed
    	@angle = obj.angle
    	@dx = @speed * math.cos(@angle)
    	@dy = @speed * math.sin(@angle)
    	@timer = Timer.after(.3, -> @remove!)
    	@getChar(43, 9, 0, 0, 8)
    	super!
    collide: (other) =>
    	if other.__class.__name != "Player" and other.health
    		other.health -= @damage
    		@remove!
    --draw: => love.graphics.rectangle("fill", @x, @y, @width, @height )
    filter: (other) =>  "cross"
    draw: => love.graphics.draw(@img, @x-@pad, @y-@pad, @angle + 90)
distance = (p1,p2) -> math.sqrt((p2.x - p1.x) ^ 2 + (p2.y - p1.y) ^ 2)
