extends Label
class_name DeleteCount

@export var gameManager:Game_Manager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_count()

func update_count() -> void:
	print("updating count")
	text = "Deletes Left: %d" % Singleton.deleteCount
