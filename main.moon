cargo = require 'lib/cargo'
sti = require "lib/sti"
export Camera = require "lib/camera"
Input = require 'lib/Input'
bump = require 'lib/bump'
Moan = require 'lib/Moan'
require 'util'
inspect = require 'lib/inspect'
export world = bump.newWorld(16)
kenPixel = love.graphics.newFont("lib/fonts/Kenney Pixel.ttf", 35)
Moan.font = kenPixel
--Moan.selectButton = 1
Moan.setSpeed(0.05)
export CLASS = {}
export MAP = {}
love.graphics.setDefaultFilter('nearest', 'nearest')
export chars = love.graphics.newImage("images/char_spritesheet.png")
export getChar = (x, y) -> love.graphics.newQuad(x + x*16, y + y*16, 16, 16, chars\getDimensions())
--love.window.setFullscreen(true)
export vItems = ->
	x,y = camera\worldCoords(0, 0)
	return world\queryRect(x, y, love.graphics.getWidth!, love.graphics.getHeight!, (item) -> item.__class)
export camera
export player
map = ""
export changeMap = (name) -> 
	unless map == name
		map = name
		items = world\getItems()
		for item in *items do if item.remove then item\remove! else world\remove(item)
		MAP[map]\bump_init(world)
		for _, obj in pairs MAP[map].objects
			if obj.properties.map
				p = obj.properties
				CLASS["Teleport"](p.map, p.x, p.y, obj.x, obj.y, obj.width, obj.height)
		--if tile.properties and tile.properties.collidable == true
		for name, c in pairs CLASS do if c.__name == "Player" then export player = c! --guarentees player goes first
		for name, c in pairs CLASS do if c.scenes == map then c!
love.keypressed = (key) -> Moan.keypressed(key)

love.load = ->
	export input = Input()
	cargo.init({
	dir: 'src',
	processors: {
		'.': (code, fn) -> 
			if fn\match("[^.]+$") == 'lua' then CLASS[code.__name] = code
	}
	})(true)
	cargo.init({
		dir: 'maps',
		processors: {
			'.': (code, fn) -> --sub gets rid of file extension
				if fn\match("[^.]+$") == 'lua' MAP[fn\match("^.+/(.+)$")\sub(1, -5)] = sti(fn, { "bump" }) 
		}
	})(true)
	camera = Camera(0, 0, 2.5)
	camera.smoother = Camera.smooth.damped(10)
	changeMap("sample_map")
	player\teleport(32*16, 39*16)
	Moan.speak({"Akoni", {0,255,0}}, {"Welcome to the game!", "This is a fun game!"}, {
		onstart: () -> player\disable!,
		oncomplete: ()-> player\enable!
	})
	--input\unbindAll()
	
love.update = (dt) ->
	MAP[map]\update(dt)
	camera\lockPosition(player.x, player.y)
	for item in *vItems!
		if item.alive --feels like a garbage collector
			item\update(dt)
			item.x, item.y, cols = world\move(item, item.x, item.y)
			for col in *cols do if col.other.collide and col.other.alive then col.other\collide(item) --this might lead to double collisions? idk
	Moan.update(dt)
love.draw = ->
	tx = math.floor(camera.x - (love.graphics.getWidth()/camera.scale) / 2)
	ty = math.floor(camera.y - (love.graphics.getHeight()/camera.scale) / 2)
	MAP[map]\draw(-tx, -ty, camera.scale, camera.scale)
	camera\attach()
	for item in *vItems! do item\draw!
	--love.graphics.setColor(255, 0, 0)
	--MAP[map]\bump_draw(world)
	camera\detach()
	love.graphics.setFont(kenPixel)
	love.graphics.print("FPS: "..love.timer.getFPS!, 12, 12)
	Moan.draw()