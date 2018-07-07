extends RichTextLabel

onready var dialogue = {"a" : "tfg"}

func parse_dialogue(script_path):
	var json_file = File.new()
	json_file.open(script_path, json_file.READ)
	var json_text = json_file.get_as_text()
	dialogue = parse_json(json_text)
	json_file.close()
	
var page = 0
var press = false

onready var icon = get_node("../Face")

func _ready():
	parse_dialogue("res://test.dialogue")
	set_bbcode(((dialogue["passages"])[1])["text"])
	set_visible_characters(0)
	set_process_input(true)
	icon.play("debug1")
	pass

func _input(event):
	if event.is_action_pressed("ui_accept") and not press:
		press = true
		if get_visible_characters() >= get_total_character_count() and not len(dialogue) == page+1:
			page += 1
			set_visible_characters(0)
			set_bbcode(dialogue[page])
			icon.play("debug1")
			
		else:
			set_visible_characters(get_total_character_count())
	if not event.is_action_pressed("ui_accept") and press:
		press = false	

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
