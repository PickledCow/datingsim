extends AnimatedSprite


func _ready():
	pass

export var dialogue_box = "../Player/CanvasLayer/DialogueBox/RichTextLabel"
onready var box = get_node(dialogue_box)
export var player_path = "../Player"
onready var player = get_node(player_path)
export var passage_name = ""
export var passage_2_name = ""
var start = false
var already_talked_to = false
onready var self_pos = "../../../../" + str(self.name)

func _process(delta):
	if player.loaded:
		if get_node("Area2D").overlaps_body(player):
			if not already_talked_to:
				box.passage = passage_name
			else:
				box.passage = passage_2_name
			start = true
			box.source_name = self_pos
		else:
			start = false
			if box.source_name == self_pos:
				box.talk_start = false
			
	if start and (((box.passage == passage_name) and not already_talked_to) or ((box.passage == passage_2_name) and already_talked_to)):
		box.talk_start = true
