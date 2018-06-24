extends Sprite

func _ready():
	if is_main_menu:
		main_menu = true
		var save_game = File.new()
		if not save_game.file_exists("user://save" + "0"):
			no_save = true
			length = 0
			pos = 444
			get_node("../Continue").self_modulate = Color(1,1,1,0.75)

export var pos = 384
export var is_main_menu = false
export var length = 1
var menu_position = 0
onready var no_save = false
var up_pressed = false
var down_pressed = false
var main_menu = false
onready var click = get_node("AudioStreamPlayer")
onready var select = get_node("AudioStreamPlayer2")

func _input(event):
	if event.is_action_pressed("ui_up") and not up_pressed:
		up_pressed = true
		if menu_position > 0:
			menu_position -= 1
			pos -= 64
			click.play()
	if event.is_action_pressed("ui_down") and not down_pressed:
		down_pressed = true
		if menu_position < length:
			menu_position += 1
			pos += 64
			click.play()
	if event.is_action_released("ui_up") and up_pressed:
		up_pressed = false
	if event.is_action_released("ui_down") and down_pressed:
		down_pressed = false
	
	if event.is_action_pressed("ui_accept"):
		if main_menu:
			if menu_position == 0 and not no_save:
				select.play()
				get_node("/root/main").load_game()
			if (menu_position == 0 and no_save) or menu_position == 1:
				select.play()
				get_node("/root/main").new_game()
			
			
	position.y = pos
	