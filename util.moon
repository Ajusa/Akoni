export *
cargo = require 'lib/cargo'
sti = require "lib/sti"
Camera = require "lib/camera"
Input = require 'lib/Input'
bump = require 'lib/bump'
Moan = require 'lib/Moan'
inspect = require 'lib/inspect'
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

export class Teleport extends Entity
	new: (obj) =>
		to = obj.properties
    	@x, @y = obj.x, obj.y
    	@width, @height = obj.width, obj.width
    	@to = to.map
    	@tx, @ty = to.x, to.y
    	super!
    collide: (other) => 
    	changeMap(@to)
    	player\teleport(@tx*16, @ty*16)
export class NPC extends Entity --currently unused
	new: =>
		super!
	update: (dt) =>
		@x += @dx * dt
		@y += @dy * dt