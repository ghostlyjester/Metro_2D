extends CharacterBody2D

const SPEED = 350.0
const JUMP_VELOCITY = -600.0



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_attacking = false;

@onready var health_label: Label = $"../CanvasLayer/health"
@onready var health: CanvasLayer = $"../CanvasLayer"
@onready var anim_sprite = $AnimatedSprite2D
@onready var timer: Timer = $Camera2D/Timer

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
				
			
	
	#if direction:
		#velocity.x = direction * SPEED
		# Flip sprite based on direction
		#anim_sprite.flip_h = direction < 0
		#if is_on_floor():
			#anim_sprite.play("run")
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#if is_on_floor():
			#anim_sprite.play("idle")
	# Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		#anim_sprite.play("idle")
	
	# Handle attack animation
	#if Input.is_action_just_pressed("attack_user"):  # You'll need to define this input action
	#	anim_sprite.play("attack")
	
	# Get the input direction and handle the movement/deceleration.
	
	move_and_slide()
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Collided")
	if area.is_in_group("enemy") and !is_attacking:
		print("Health - 10")
		health.health_val = health.health_val - 10
		health_label.text = str(health.health_val)
		
	elif area.is_in_group("enemy") and is_attacking:
		print("Enemy Health - 10")	
	
