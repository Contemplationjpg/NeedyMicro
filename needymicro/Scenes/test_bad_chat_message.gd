extends Button

@onready var gameManager : Game_Manager 
@export var good = false

func set_game_manager(gm : Game_Manager):
	gameManager = gm

func _ready() -> void:
	disabled = false
	visible = true


func _on_pressed() -> void:
	if gameManager.state == 1 and Singleton.pressed == false:
		#Singleton.pressed = true
		disabled = true
		visible = false
		#if good:
			#Singleton.success = false
		#else:
			#Singleton.success = true
		if not good:
			Singleton.pressed = true
			Singleton.success = true
			
