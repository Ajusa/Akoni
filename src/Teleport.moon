class Teleport extends Entity
	new: (to, tx, ty, x, y, width, height) =>
    	@x, @y = x, y
    	@width, @height = width, height
    	@to = to
    	@tx, @ty = tx, ty
    	super!
    collide: (other) => 
    	changeMap(@to)
    	player\teleport(@tx*16, @ty*16)