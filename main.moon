require 'util'
export world = bump.newWorld(16)
kenPixel = love.graphics.newFont("lib/fonts/Kenney Pixel.ttf", 35)
Moan.font = kenPixel
--Moan.selectButton = 1
Moan.setSpeed(0.05)
export CLASS = {}
export MAP = {}
export EVENT = {}
export STATE = {}
love.graphics.setDefaultFilter('nearest', 'nearest')
export chars = love.graphics.newImage("images/char_spritesheet.png")
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
		for _, obj in pairs MAP[map].objects --initialize any custom objects
			if obj.properties.map then Teleport(obj)
		for name, c in pairs CLASS do if name == "Player" then export player = c! --guarentees player goes first
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
	table.insert(EVENT, ->
		changeMap("sample_map")
		player\teleport(32*16, 39*16)
		
	)
	--input\unbindAll()
	
love.update = (dt) ->
	Timer.update(dt)
	for i = #EVENT, 1, -1
	    EVENT[i]!
		table.remove(EVENT)
	MAP[map]\update(dt)
	camera\lockPosition(player.x, player.y)
	for item in *vItems!
		item\update(dt)
		if item.alive
			filter = if item.filter then item.filter else (i, o) -> "slide"
			item.x, item.y, cols = world\move(item, item.x, item.y, filter)
			for col in *cols do if col.other.collide then col.other\collide(item) --this might lead to double collisions? idk
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