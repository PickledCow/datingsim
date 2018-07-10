extends RichTextLabel

onready var dialogue = get_node("/root/main").dialogue

var pid = 1
var page = 0
var press = false
var option = 0
var talk_start = false
var talking = false
var ended = false
export var passage = ""
var source_name = ""
onready var source = get_node(source_name)

onready var icon = get_node("../Face")

func _ready():
	get_node("../").hide()
	#set_bbcode(((dialogue[passage])[page])["text"])
	set_visible_characters(0)
	set_process_input(true)
	#icon.play((((dialogue[passage])[page])["tags"])[0])

#((((dialogue[passage])[page])["text"]).split("[[", 1)[0])

func _input(event):
	if (event.is_action_pressed("ui_accept") or (event.is_action_pressed("ui_back") and talking)) and (not press) and talk_start:
		if ended:
			ended = false
			pid = 1
			page = 0
		talking = true
		get_node("../").show()
		get_node("../../../").canMove = false
		press = true
		source = get_node(source_name)
		if get_visible_characters() >= get_total_character_count() and page < len(dialogue[passage]):
			if ((dialogue[passage])[page]).has("links"):
				for i in range(0, len(((dialogue[passage])[page])["links"])):
					if (((((dialogue[passage])[page])["links"])[i]).has("pid") and i == option): # wip
						pid = int(((((dialogue[passage])[page])["links"])[i])["pid"])
						page = pid - 1
						option = 0
						set_visible_characters(0)
						set_bbcode((((dialogue[passage])[page])["text"]).split("[[", 1)[0])
						break
					elif (not page+1 == len(dialogue[passage])) and i == option:
						page += 1+i
						pid += 1+i
						option = 0
						set_visible_characters(0)
						set_bbcode((((dialogue[passage])[page])["text"]).split("[[", 1)[0])
						break
				icon.play((((dialogue[passage])[page])["tags"])[0])
			else:
				get_node("../../../").canMove = true
				get_node("../").hide()
				talk_start = false
				talking = false
				ended = true
				source.already_talked_to = true
	
		else:
			set_visible_characters(get_total_character_count())
	if not event.is_action_pressed("ui_accept") and press:
		press = false	
	#print("page:" + str(page))
	#print("pid:" + str(pid))

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
	
func _process(delta):
	pass
