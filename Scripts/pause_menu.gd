extends Node2D

var escAlreadyPressed = false

func _ready():
	hide()

func pause():
	get_tree().paused = true
	show()

func unpause():
	get_tree().paused = false
	hide()

func _input(event):
	if event.is_action_pressed("ui_cancel") and not escAlreadyPressed:
		escAlreadyPressed = true
		if not get_tree().paused:
			pause()
		elif get_tree().paused:
			unpause()
	if not event.is_action_pressed("ui_cancel") and escAlreadyPressed:
		escAlreadyPressed = false
	