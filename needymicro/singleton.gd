extends Node
class_name Singelton

var deleteCount = 3
var success = false
var pressed = false

func reset():
	deleteCount = 3
	success = false
	pressed = false

func delete_count() -> void:
	if deleteCount > 1:
		deleteCount= deleteCount-1
	else:
		deleteCount = 0
		success = false
		pressed = true
