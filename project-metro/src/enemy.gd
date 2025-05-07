extends Node2D

const SPEED = 250

var direction = -1

var health_val = 90

var is_dead  = false

var player_chase = false

var player = null

@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var en_health_bar: ProgressBar = $"EnHealth Bar"


func _ready():
	animated_sprite_2d.play("run")


func _process(delta):
	
	en_health_bar.value = health_val
	
	if health_val > 0 and !player_chase:
		position.x += direction * SPEED * delta 
		if ray_cast_right.is_colliding():
			direction = 1
			animated_sprite_2d.flip_h = true 
		if ray_cast_left.is_colliding():
			direction = -1
			animated_sprite_2d.flip_h = false
	elif health_val < 1 and !is_dead:
		is_dead = true
		animated_sprite_2d.play("death")
		
		
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "death":
		animated_sprite_2d.play("st_death")
		en_health_bar.visible = false


		
	
