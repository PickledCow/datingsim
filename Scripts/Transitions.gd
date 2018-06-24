extends Node2D

onready var player = null

var destination = null
var offset = null
var anim = null
onready var door = null
var doorname = "Door1"

func new_overworld():
	player = get_node("/root/World/Player")
	door = get_node("root/World/doors/" + doorname)




func _ready():
	pass
