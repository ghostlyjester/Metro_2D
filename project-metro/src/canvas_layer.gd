extends CanvasLayer

@onready var timer: Timer = $Timer

var health_val = 100


func _ready():
	$Label.text= "Health: "
	$health.text = str(health_val)

func _input(event):
	
	if event.is_action_pressed("user_health") && (health_val > 1):
		
		health_val -= 20
		
		$health.text = str(health_val)
	
	if(health_val < 1):
		
		$health.text = "..."
		
		timer.start()

	
