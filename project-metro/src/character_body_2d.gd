extends CharacterBody2D

const SPEED = 350.0
const JUMP_VELOCITY = -600.0



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_attacking = false;
var in_left = false;
var in_right = false;

@onready var enemy_2d: CharacterBody2D = $"../enemy_2d"
@onready var enemy: Node2D = $"../enemy"
@onready var health_label: Label = $"../CanvasLayer/health"
@onready var health: CanvasLayer = $"../CanvasLayer"
@onready var anim_sprite = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $"../CanvasLayer/HealthBar"
@onready var door: Area2D = $"../door"



func _ready():
	# Set up initial animation state
	anim_sprite.play("idle")
	
func _on_timer_timeout():
	
	get_tree().reload_current_scene()
	
	
	
func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		anim_sprite.play("idle")
	
	if is_attacking:
		if not anim_sprite.is_playing():
			is_attacking = false
	else: 
		
		var direction := Input.get_axis("left", "right")
		
		if Input.is_action_just_pressed("attack_user") and is_on_floor(): 
			 # You'll need to define this input action
			anim_sprite.play("attack")
			is_attacking = true
		else:
			if direction:
				velocity.x = direction * SPEED
				anim_sprite.flip_h = direction < 0
				if is_on_floor():
					anim_sprite.play("run")
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				if is_on_floor():
					anim_sprite.play("idle")
					
			if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY
				anim_sprite.play("idle")
	
	move_and_slide()


func _on_damage_right_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") and is_attacking and !enemy.is_dead and !in_left:
		print("Enemy Health - 30")
		enemy.health_val = enemy.health_val - 30
		in_right = true
		
	if area.is_in_group("enemy_2d") and is_attacking and !enemy_2d.is_dead and !in_left:
		print("Enemy Health - 30")
		enemy_2d.health_val = enemy_2d.health_val - 30
		in_right = true
		
	if area.is_in_group("Door") and is_attacking and !door.is_bk:
		print("Door - 30")
		door.health = door.health - 150


func _on_damage_left_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") and is_attacking and !enemy.is_dead and !in_right:
		print("Enemy Health - 30")
		enemy.health_val = enemy.health_val - 30
		in_left = true
		
	if area.is_in_group("enemy_2d") and is_attacking and !enemy_2d.is_dead and !in_right:
		print("Enemy Health - 30")
		enemy_2d.health_val = enemy_2d.health_val - 30
		in_left = true
		
	if area.is_in_group("Door") and is_attacking and !door.is_bk:
		print("Door - 30")
		door.health = door.health - 150


func _on_pl_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy")  and !is_attacking and !enemy.is_dead :
		print("Health - 10")
		health.health_val = health.health_val - 10
		health_bar.value = health.health_val
		health_label.text = str(health.health_val)
	if area.is_in_group("enemy_2d") and !is_attacking and !enemy_2d.is_dead:
		print("Health - 10")
		health.health_val = health.health_val - 10
		health_bar.value = health.health_val
		health_label.text = str(health.health_val)
	
		
