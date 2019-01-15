export class Entity
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
	collide: (other) => "slide"
	remove: () => 
		@alive = false
		world\remove(self)


export class NPC extends Entity --currently unused
	new: =>
		super!
	update: (dt) =>
		@x += @dx * dt
		@y += @dy * dt