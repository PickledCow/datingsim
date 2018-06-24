extends Area2D


onready var main = get_node("/root/main")
onready var player = get_node("../Player")
onready var audio = get_node("AudioStreamPlayer")
var touching = false
var audioPlaying = false

func _ready():
	pass

func _process(delta):
	if player.loaded:
		if overlaps_body(player) and not touching:
			touching = true
			if not audioPlaying:
				audio.volume_db = 0
				audio.play()
				audioPlaying = true
			else:
				audio.volume_db = 0
		elif not overlaps_body(player) and touching:
			touching = false
			audio.volume_db = -80
	
	if get_tree().paused and not audio.bus == "Paused":
		audio.bus = "Paused"
	elif not get_tree().paused and not audio.bus == "Master":
		audio.bus = "Master"