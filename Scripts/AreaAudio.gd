extends Area2D


onready var main = get_node("/root/main")
onready var player = get_node("../Player")
onready var audio = get_node("Audio")
export var play = true
var touching = false
var audioPlaying = false
export var autoplay = false
export var bus = "Master"
var started_autoplay = false
export var persistent = false

func _ready():
	pass

func _process(delta):
	if player.loaded and play:
		if autoplay and not started_autoplay:
			audio.play()
			if not persistent:
				audio.volume_db = -80
			started_autoplay = true
		if overlaps_body(player) and not touching:
			touching = true
			if not audioPlaying and not autoplay:
				audio.volume_db = 0
				audio.play()
				audioPlaying = true
			else:
				audio.volume_db = 0
		elif not overlaps_body(player) and touching:
			touching = false
			audio.volume_db = -80
	if get_tree().paused and not audio.bus == "Paused":
		if audio.bus == "Master":
			audio.bus = "Paused"
		elif audio.bus == "Low_Pass":
			audio.bus = "Low_Pass_Paused"
	elif not get_tree().paused and not audio.bus == bus:
		audio.bus = bus