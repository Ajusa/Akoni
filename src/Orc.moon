class Orc extends NPC
	scenes: 'sample_map'
	new: =>
    	@getChar(0, 3)
    	@pad = 3
    	@x, @y = 35*16, 45*16
    	@health = 5
    	@speed = 50
    	super!
	update: (dt) =>
		angle = math.atan2(player.y-@y, player.x-@x)
		@dx, @dy = @speed * math.cos(angle), @speed * math.sin(angle)
		if @health <= 0 then @remove!
		super(dt)