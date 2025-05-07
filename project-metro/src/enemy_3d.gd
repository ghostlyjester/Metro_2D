extends CharacterBody2D

const SPEED = 270

var direction = -1

var health_val = 90

var is_dead  = false

@onready var ray_cast_2_right: RayCast2D = $RayCast2Right
@onready var ray_cast_2_left: RayCast2D = $RayCast2Left
@onready var en_2_health_bar: ProgressBar = $En2HealthBar
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	animated_sprite_2d.play("run")
	animated_sprite_2d.flip_h = false
	
func _process(delta):
	
	en_2_health_bar.value = health_val
	
	if health_val > 0:
		position.x += direction * SPEED * delta 
		if ray_cast_2_left.is_colliding():
			direction = 1
			animated_sprite_2d.flip_h = true 
		if ray_cast_2_right.is_colliding():
			direction = -1
			animated_sprite_2d.flip_h = false
	elif health_val < 1 and !is_dead:
		is_dead = true
		animated_sprite_2d.play("death")
		

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "death":
		animated_sprite_2d.play("st_death")
		en_2_health_bar.visible = false
