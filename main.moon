cargo = require 'lib/cargo'
sti = require "lib/sti"
Camera = require "lib/camera"
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
export MAP= {}
love.graphics.setDefaultFilter('nearest', 'nearest')
chars = love.graphics.newImage("images/char_spritesheet.png")
export getChar = (x, y) -> 
	love.graphics.newQuad(x + x*16, y + y*16, 16, 16, chars\getDimensions())
--love.window.setFullscreen(true)
   
export camera

map = 'sample_map'
love.keypressed = (key) ->
	Moan.keypressed(key)

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
			'.': (code, fn) -> 
				if fn\match("[^.]+$") == 'lua' MAP[fn\match("^.+/(.+)$")\sub(1, -5)] = sti(fn, { "bump" }) --sub gets rid of file extension
		}
	})(true)
	export player = CLASS['Player']()
	camera = Camera(player.x, player.x, 2.5)
	camera.smoother = Camera.smooth.damped(10)
	MAP[map]\bump_init(world)
	
	Moan.speak({"Akoni", {0,255,0}}, {"Welcome to the game!", "This is a fun game!"}, {
		onstart: () -> player\disable!,
		oncomplete: ()-> player\enable!
	})
	print(world\queryRect(0, 0, 10000, 10000, (item) -> item.__class.__name))) -- todo: make this be onscreen
	--input\unbindAll()
	--map = sti("maps/sample_map.lua")
	
love.update = (dt) ->
	MAP[map]\update(dt)
	input\update()
	player\update(dt)
	--if(player.x > 600) input\unbindAll()
	
	Moan.update(dt)
	player.x, player.y = world\move(player, player.x, player.y)
	camera\lockPosition(player.x, player.y)
love.draw = ->
	love.graphics.print("Lives: "..player.x, 12, 12)
	love.graphics.print("Score: "..3, 130, 12)
	tx = math.floor(camera.x - (love.graphics.getWidth()/camera.scale) / 2)
	ty = math.floor(camera.y - (love.graphics.getHeight()/camera.scale) / 2)
	MAP[map]\draw(-tx, -ty, camera.scale, camera.scale)
	camera\attach()
	love.graphics.draw(chars, player.img, player.x-3, player.y-3)
	--love.graphics.setColor(255, 0, 0)
	--MAP[map]\bump_draw(world)
	camera\detach()
	Moan.draw()