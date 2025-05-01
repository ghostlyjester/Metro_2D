extends CanvasLayer

@onready var timer: Timer = $Timer
@onready var health_bar: ProgressBar = $HealthBar

var health_val = 120


func _ready():
	$Label.text= "Health:       /100"
	$health.text = str(health_val)
	health_bar.value = health_val

func _input(event):

	if event.is_action_pressed("user_health") && (health_val > 1):
		
		health_val -= 20
		
		health_bar.value = health_val
		
		$health.text = str(health_val)
	
	if(health_val < 1):
		
		$health.text = "..."
		
		health_bar.value = health_val
		
		timer.start()

	
