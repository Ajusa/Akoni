class Player extends NPC
	scenes: '*'
	new: =>
    	@getChar(0, 0)
    	@data = {}
    	@pad = 3
    	@x, @y = 32*16, 39*16
    	@enable!
    	super!
	update: (dt) =>
		@dx, @dy = 0, 0
		if input\down('down') then @dy = @speed
		if input\down('up') then @dy = -@speed
		if input\down('left') then @dx = -@speed
		if input\down('right') then @dx = @speed
		if input\down('attack', 0.5) then @attack!
		super(dt)
	enable: => --eventually make this nicer, with a loop or something
		input\bind('s', 'down')
		input\bind('w', 'up')
		input\bind('a', 'left')
		input\bind('d', 'right')
		input\bind('space', 'attack')
	disable: =>
		input\unbind('s')
		input\unbind('w')
		input\unbind('a')
		input\unbind('d')
		input\unbind('space')
	filter: (o) => if o.__class and o.__class.__name == "Dagger" then "cross" else "slide"
	attack: =>
		--if @data.weapon
			x,y = camera\worldCoords(love.mouse.getPosition())
			angle = math.atan2(y-@y, x-@x)
			Dagger(x: @x + 5, y: @y + 5, speed: 80, angle: angle) --+5 for centering the dagger