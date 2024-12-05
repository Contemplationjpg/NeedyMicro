extends Node
class_name Game_Manager

enum States {PRE, GAME, POST}
var state = States
var runningTimer = false
var deleteCount = 3
@export var deleteCounter: Label

@export var player: Sprite2D
@export var playerWin: Sprite2D
@export var playerLose: Sprite2D
@export var playerAnim: AnimationPlayer
@export var yapAnim: Animation

@onready var badButtonTemplate: PackedScene = load("res://Objects/bad_chat_message_button.tscn")
@onready var goodButtonTemplate: PackedScene	 = load("res://Objects/good_chat_message_button.tscn")
@export var chatContainer: VBoxContainer
@onready var rng = RandomNumberGenerator.new()

@onready var countdown: Countdown = $"../CountdownPanel/Countdown"
@export var prePostGameTimer: Timer 
@export var gameTimer: Timer
@export var instruction: Panel
@export var winPanel: Panel
@export var losePanel: Panel
var success = false
var buttonPressed = false
var gameOver = false
var alreadyBadMessage = false
var goodDialogue = {
	0: "hiii", 
	1: "hello",
	2: "LOL",
	3: "nanami goated",
	4: "<3",
	5: "2006 Honda Civic",
	6: "lmao",
	7: ":3",
	8: "true",
	9: "too real",
	10: "WHAT",
	11: "wow",
	12: "yeah sure",
	13: "yes",
	14: "what did I miss",
	15: "lol",
	16: "understandable",
	17: "hmm",
	18: "o7",
	19: "pog",
	20: "nice",
	21: "yeah",
	22: "yippee"
	
	
} 
var badDialogue = {
	0: "you should quit streaming", 
	1: "60.69.152.225",
	2: "EVERYONE UNSUBSCRIBE",
	3: "why is your voice like that",
	4: "i see why people don't watch you",
	5: "imagine wearing that in this decade LOL",
	6: "GUYS GO TO MY CHANNEL IM STREAMING RN",
	7: "ur disgusting"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerWin.visible = false
	playerLose.visible = false
	state = States.PRE
	runningTimer = false
	instruction.visible = true
	winPanel.visible = false
	losePanel.visible = false
	success = false
	playerAnim.play("Yapping")
	#playerAnim.active = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_update_state()
	

func _update_state():
	if not runningTimer:
		if state == States.PRE:
			print("pregame")
			prePostGameTimer.start()
		elif state == States.GAME:
			print("game")
			countdown.start_countdown()
			gameTimer.start()
		elif state == States.POST:
			print("postgame")
			prePostGameTimer.start()
		runningTimer = true
		
	if Singleton.pressed and not gameOver:
		stop_game()


func _on_game_timer_timeout() -> void:
	win_check()
	state = States.POST
	runningTimer = false
	
func win_check():
	if Singleton.success:
		winPanel.visible = true
		playerWin.visible = true
		print("win")
	else:
		losePanel.visible = true
		playerLose.visible = true
		print("lose")

func _on_pre_post_game_timer_timeout() -> void:
	if state == 0:
		instruction.visible = false
		state = 1
		runningTimer = false
	elif state == 2:
		print("game over")
		get_tree().quit()
	
func stop_game():
	gameTimer.stop()
	countdown.stop_countdown()
	win_check()
	state = States.POST
	runningTimer = false
	gameOver = true
		
func _create_chat_message(bad: bool):
	var cont = BoxContainer.new()
	var newButton
	if bad:
		newButton = badButtonTemplate.instantiate()
		var v = rng.randi_range(0,7)
		newButton.text = badDialogue.get(v)
		
	if not bad:
		newButton = goodButtonTemplate.instantiate()
		var v = rng.randi_range(0,22)
		newButton.text = goodDialogue.get(v)
		
	newButton.set_game_manager(self)
	cont.add_child(newButton)
	chatContainer.add_child(cont)
		

func _on_chat_timer_timeout() -> void:
	if state > 0 and not gameOver:
		var t = rng.randi_range(0,5)
		if not alreadyBadMessage and countdown.time<3.5:
			_create_chat_message(true)
			alreadyBadMessage = true
		elif not alreadyBadMessage and t==0:
			_create_chat_message(true)
			alreadyBadMessage = true
		else:
			_create_chat_message(false)
