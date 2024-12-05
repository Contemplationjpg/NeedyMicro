extends Label
class_name DeleteCount

@export var gameManager:Game_Manager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateCount()

func updateCount() -> void:
	text = "Deletes Left: %d" % gameManager.deleteCount
