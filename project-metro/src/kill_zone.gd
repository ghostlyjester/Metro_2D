extends Area2D

@onready var timer: Timer = $Timer
@onready var health: Label = $"../CharacterBody2D/Camera2D/health"



func _on_body_entered(body): 
	timer.start()


func _on_timer_timeout():
	get_tree().reload_current_scene()
