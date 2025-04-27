extends Node2D

const SPEED = 200

var direction = -1


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _process(delta):
	
	position.x += direction * SPEED * delta
	
	
	if position.x < 600:
		direction = 1
		animated_sprite_2d.flip_h = true

	elif position.x > 1200:
		direction = -1
		animated_sprite_2d.flip_h = false
		
