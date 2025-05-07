extends Area2D

var health = 150

@onready var door_health: ProgressBar = $"Door Health"
@onready var hb: Area2D = $hb
@onready var door_tm: TileMap = $"../door tm"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var door: Area2D = $"."



var is_bk = false

func _ready():
	animated_sprite_2d.play("idle")



func _process(delta):
	door_health.value = health
	
	if health < 1:
		animated_sprite_2d.play("broken")
		

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "broken":
		door.visible = false
		door_tm.position.y = - 1500
