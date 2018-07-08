extends RichTextLabel

onready var dialogue = {"a" : "tfg"}

func parse_dialogue(script_path):
	var json_file = File.new()
	json_file.open(script_path, json_file.READ)
	var json_text = json_file.get_as_text()
	dialogue = parse_json(json_text)
	json_file.close()
	
var pid = 1
var page = 0
var press = false
var option = 0

onready var icon = get_node("../Face")

func _ready():
	parse_dialogue("res://test.dialogue")
	set_bbcode(((dialogue["passages"])[page])["text"])
	set_visible_characters(0)
	set_process_input(true)
	icon.play((((dialogue["passages"])[page])["tags"])[0])

func _input(event):
	if event.is_action_pressed("ui_accept") and not press:
		press = true
		if get_visible_characters() >= get_total_character_count() and page+1 < len(dialogue["passages"]):
			icon.play((((dialogue["passages"])[page])["tags"])[0])
			for i in range(0, len(((dialogue["passages"])[page])["links"])):
				if (((((dialogue["passages"])[page])["links"])[i]).has("pid") and i == option): # wip
					pid = int(((((dialogue["passages"])[page])["links"])[i])["pid"])
					page = pid - 1
					option = 0
					set_visible_characters(0)
					set_bbcode((((dialogue["passages"])[page]))["text"])
					break
				elif (not page+1 == len(dialogue["passages"])) and i == option:
					page += 1+i
					pid += 1+i
					option = 0
					set_visible_characters(0)
					set_bbcode(((dialogue["passages"])[page])["text"])
					break
				
		else:
			set_visible_characters(get_total_character_count())
	if not event.is_action_pressed("ui_accept") and press:
		press = false	
	#print("page:" + str(page))
	#print("pid:" + str(pid))

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
