class Player extends Entity
	scenes: '*'
	new: =>
    	@quad = getChar(0, 11)
    	canvas = love.graphics.newCanvas()
    	love.graphics.setCanvas(canvas)
    	love.graphics.draw(chars, @quad, 0, 0)
    	love.graphics.setCanvas()
    	@img = love.graphics.newImage(canvas\newImageData!)
    	@pad = 3
    	@enable!
    	super!
	update: (dt) =>
		@dx, @dy = 0, 0
		if input\down('down') then @dy = 100
		if input\down('up') then @dy = -100
		if input\down('left') then @dx = -100
		if input\down('right') then @dx = 100
		super\update(dt)
	enable: => --eventually make this nicer, with a loop or something
		input\bind('s', 'down')
		input\bind('w', 'up')
		input\bind('a', 'left')
		input\bind('d', 'right')
	disable: =>
		input\unbind('s')
		input\unbind('w')
		input\unbind('a')
		input\unbind('d')
	teleport: (x, y) => 
		world\update(self, x, y)
		@x, @y = x, y