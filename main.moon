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
	x,y = Luven.camera\worldCoords(0, 0)
	return world\queryRect(x, y, love.graphics.getWidth!, love.graphics.getHeight!, (item) -> item.__class)
export camera
export player
export player_light
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
	Luven.init()
    Luven.setAmbientLightColor({ 0.5, 0.5, 0.5 })
    Luven.camera\init(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    Luven.camera\setScale(2.5)
	player_light = Luven.addNormalLight(0, 0, { 0.9, 1, 0 }, 1, Luven.lightShapes.round, 0)
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
	Luven.update(dt)
	Luven.camera\smooth(player.x, player.y, Camera.smooth.damped(10))
	Luven.setLightPosition(player_light, player.x, player.y)
	for item in *vItems!
		item\update(dt)
		if item.alive
			filter = if item.filter then item.filter else (i, o) -> "slide"
			item.x, item.y, cols = world\move(item, item.x, item.y, filter)
			for col in *cols do if col.other.collide then col.other\collide(item) --this might lead to double collisions? idk
	Moan.update(dt)
	
love.draw = ->
	tx = math.floor(Luven.camera.x - (love.graphics.getWidth()/Luven.camera.scaleX) / 2)
	ty = math.floor(Luven.camera.y - (love.graphics.getHeight()/Luven.camera.scaleY) / 2)
	MAP[map]\draw(-tx, -ty, Luven.camera.scaleX, Luven.camera.scaleY)
	Luven.drawBegin()
	for item in *vItems! do item\draw!
	--love.graphics.setColor(255, 0, 0)
	--MAP[map]\bump_draw(world)
	Luven.drawEnd()
	love.graphics.setFont(kenPixel)
	love.graphics.print("FPS: "..love.timer.getFPS!, 12, 12)
	Moan.draw()