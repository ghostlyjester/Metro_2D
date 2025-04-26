extends CharacterBody2D

const SPEED = 350.0
const JUMP_VELOCITY = -600.0



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim_sprite = $AnimatedSprite2D
@onready var timer: Timer = $Camera2D/Timer

func _ready():
	# Set up initial animation state
	anim_sprite.play("idle")
	var health_c = get_node("../Camera2D") 
	
func _on_timer_timeout():
	
	get_tree().reload_current_scene()
	
	
	
func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		anim_sprite.play("idle")
		
		
	var direction := Input.get_axis("left", "right")
	
	
	if direction:
		velocity.x = direction * SPEED
		# Flip sprite based on direction
		anim_sprite.flip_h = direction < 0
		if is_on_floor():
			anim_sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			anim_sprite.play("idle")
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim_sprite.play("idle")
	
	# Handle attack animation
	if Input.is_action_just_pressed("attack_user"):  # You'll need to define this input action
		anim_sprite.play("attack")
	
	# Get the input direction and handle the movement/deceleration.
	
	move_and_slide()
	
