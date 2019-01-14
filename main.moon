cargo = require 'lib/cargo'
sti = require "lib/sti"
Camera = require "lib/camera"
Input = require 'lib/Input'
bump = require 'lib/bump'
world = bump.newWorld(16)
CLASS = {}
MAP= {}
love.graphics.setDefaultFilter("nearest")
--love.window.setFullscreen(true)
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
export camera
player = x: 500, y:600, dx: 0, dy: 0
world\add(player, player.x, player.y, 16,16)
map = 'sample_map'
export input
chars = love.graphics.newImage("images/char_spritesheet.png")
top_left = love.graphics.newQuad(0, 0, 16, 16, chars\getDimensions())
love.load = ->
	camera = Camera(player.x, player.x, 2.5)
	camera.smoother = Camera.smooth.damped(10)
	input = Input()
	input\bind('s', 'down')
	input\bind('w', 'up')
	input\bind('a', 'left')
	input\bind('d', 'right')
	MAP[map]\bump_init(world)
	--input\unbindAll()
	--map = sti("maps/sample_map.lua")
	
love.update = (dt) ->
	MAP[map]\update(dt)
	player.dx = 0
	player.dy = 0
	if input\down('down') then player.dy = 100
	if input\down('up') then player.dy = -100
	if input\down('left') then player.dx = -100
	if input\down('right') then player.dx = 100
	--if(player.x > 600) input\unbindAll()
	player.x += player.dx * dt
	player.y += player.dy * dt
	player.x, player.y = world\move(player, player.x, player.y)
	
	camera\lockPosition(player.x, player.y)
love.draw = ->
	love.graphics.print("Lives: "..CLASS['Player'].name, 12, 12)
	love.graphics.print("Score: "..3, 130, 12)
	tx = math.floor(camera.x - love.graphics.getWidth() / 2)
	ty = math.floor(camera.y - love.graphics.getHeight() / 2)
	MAP[map]\draw(-tx* camera.scale, -ty* camera.scale, camera.scale, camera.scale)
	camera\attach()
	love.graphics.draw(chars, top_left, player.x, player.y)
	MAP[map]\bump_draw(world)
	camera\detach()
	love.graphics.setColor(255, 0, 0)
	