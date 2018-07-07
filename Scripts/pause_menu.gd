extends Node2D

onready var click = get_node("Node2D/click")
onready var select = get_node("Node2D/select")

onready var button = [get_node("Node2D/Label"), get_node("Node2D/Label2"), get_node("Node2D/Label3")]

var escPressed = false
var downPressed = false
var upPressed = false
var acceptPressed = false

var option = 0

func _ready():
	hide()

func pause():
	get_tree().paused = true
	option = 0
	main.saved = false
	button[0].add_color_override("font_color", Color(0.98, 0.71, 0.76, 1))
	button[1].add_color_override("font_color", Color(1, 1, 1, 1))
	button[2].add_color_override("font_color", Color(1, 1, 1, 1))
	show()

func unpause():
	get_tree().paused = false
	hide()

func _input(event):
	#print(option)
	if event.is_action_pressed("ui_cancel") and not escPressed:
		escPressed = true
		if not get_tree().paused:
			pause()
		elif get_tree().paused:
			unpause()
	if not event.is_action_pressed("ui_cancel") and escPressed:
		escPressed = false
	if get_tree().paused:
		if event.is_action_pressed("ui_accept"):
			acceptPressed = true
			select.play()
			if option == 0:
				unpause()
			if option == 1:
				get_node("/root/main").save_game()
				unpause()
			if option == 2:
				get_node("/root/main").save_game()
		if not event.is_action_pressed("ui_accept") and acceptPressed:
			acceptPressed = false
		
		if event.is_action_pressed("ui_down") and not downPressed:
			if option < 2:
				option += 1
				button[option].add_color_override("font_color", Color(0.98, 0.71, 0.76, 1))
				button[option-1].add_color_override("font_color", Color(1, 1, 1, 1))
				click.play()
			downPressed = true
		if not event.is_action_pressed("ui_down") and downPressed:
			downPressed = false
		
		if event.is_action_pressed("ui_up") and not upPressed:
			if option > 0:
				option -= 1
				button[option].add_color_override("font_color", Color(0.98, 0.71, 0.76, 1))
				button[option+1].add_color_override("font_color", Color(1, 1, 1, 1))
				click.play()
			upPressed = true
		if not event.is_action_pressed("ui_up") and upPressed:
			upPressed = false

func _process(delta):
	if option == 2 and main.saved:
		unpause()
		get_tree().quit()