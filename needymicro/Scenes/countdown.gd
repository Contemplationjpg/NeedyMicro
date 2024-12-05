extends Label
class_name Countdown

@onready var gameTimer: Timer = $"../../GameManager/GameTimer"
var countingDown = false
var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = gameTimer.wait_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if countingDown == true:
		time-=delta
		if time<=0:
			time = 0
			countingDown = false
	text = "%.2f" % time
	
func start_countdown():
	countingDown = true

func stop_countdown():
	countingDown = false
	
