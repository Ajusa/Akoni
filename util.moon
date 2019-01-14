export class Entity
	new: =>
		@x = unless @x then 0
		@y = unless @y then 0
		@dx = unless @dx then 0
		@dy = unless @dy then 0
		@width = unless @width then 16
		@height = unless @height then 16
		@pad = unless @pad then 0
		world\add(self, @x, @y, @width-(2*@pad), @height-(2*@pad))
	update: (dt) =>
		@x += @dx * dt
		@y += @dy * dt