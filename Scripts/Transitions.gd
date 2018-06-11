extends Node2D

onready var player = get_node("../Player")

var destination = null
var offset = null
var anim = null
onready var door = get_node("../" + doorname)
var doorname = "Door1"


func record(a, b, c, d):
	destination = a
	offset = b
	anim = c
	doorname = d
	door = get_node("../" + str(doorname))

func resend():
	player.enterDoor(destination, offset, anim)
	get_node("../Player/Camera2D").smoothing_enabled = false
	get_node("../Player/Camera2D").align()

func resendPart2():
	get_node("../Player/Camera2D").smoothing_enabled = true
	door.tranStart = false

func _ready():
	pass

func _process(delta):
	player.canMove = not door.tranStart