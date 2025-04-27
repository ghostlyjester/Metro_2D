extends Node2D

const SPEED = 200

var direction = -1

var health_val = 90

var is_dead  = false

@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	animated_sprite_2d.play("run")


func _process(delta):
	
	if health_val > 0:
		position.x += direction * SPEED * delta
		if position.x < 600:
			direction = 1
			animated_sprite_2d.flip_h = true
		elif position.x > 1700:	
			direction = -1
			animated_sprite_2d.flip_h = false
	elif health_val < 1 and !is_dead:
		
		animated_sprite_2d.play("death")
		
		
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "death":
		is_dead = true
		animated_sprite_2d.play("st_death")
