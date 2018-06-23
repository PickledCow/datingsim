extends RichTextLabel

onready var dialogue = {"a" : "tfg"}

func parse_json(script_path):
	var json_file = File.new()
	json_file.open(script_path, json_file.READ)
	var json_text = json_file.get_as_text()
	dialogue = parse_json(json_text)
	json_file.close
	print(dialogue)
	
var page = 0
var press = false

onready var icon = get_node("../Face")

func _ready():
	#set_bbcode(dialogue[page])
	#set_visible_characters(0)
	#set_process_input(true)
	#icon.play(face[page])
	pass

func _input(event):
	parse_json("res://test.dialogue")
	#if event.is_action_pressed("ui_accept") and not press:
	#	press = true
	#	if get_visible_characters() >= get_total_character_count() and not len(dialogue) == page+1:
	#		page += 1
	#		set_visible_characters(0)
	#		set_bbcode(dialogue[page])
	#		icon.play(face[page])
	#		
	#	else:
	#		set_visible_characters(get_total_character_count())
	#if not event.is_action_pressed("ui_accept") and press:
	#	press = false	
	pass

func _on_Timer_timeout():
	#set_visible_characters(get_visible_characters()+1)
	pass
