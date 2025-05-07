extends Area2D

@onready var camera_2d: Camera2D = $"../CharacterBody2D/Camera2D"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var target_zoom: Vector2 = Vector2( 2 , 2)
var zoom_speed: float = 0.5

func _process(delta: float) -> void:
	camera_2d.zoom = camera_2d.zoom.lerp(target_zoom, zoom_speed * delta)


func _on_area_entered(area: Area2D) -> void:
	collision_shape_2d.position.x = -1500
	target_zoom = Vector2(1.2, 1.2)
	zoom_speed = 1.0
	camera_2d.limit_left = -500
	
	
	
	
