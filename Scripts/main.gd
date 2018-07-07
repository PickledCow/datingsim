extends Node2D

onready var player = get_node("")

func _ready():
	pass


# ----- SAVE -----
var alreadySaved = false
var alreadyLoaded = false
var saveID = 0
var main_menu = true
var loaded = false
var playerX = 0
var playerY = 0
var scene = ""
var continuing = false
var saved = false
export var level1 = "res://Scenes/World.tscn"

func save_game():
	saved = false
	var save_game = File.new()
	save_game.open("user://save" + str(saveID), File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("persist")
	for i in save_nodes:
		var node_data = i.call("save")
		save_game.store_line(to_json(node_data))    
	save_game.close()
	saved = true

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://save" + str(saveID)): # JUUUUST in case
		return
	
	#var save_nodes = get_tree().get_nodes_in_group("persist")
	
	save_game.open("user://save" + str(saveID), File.READ)
	var data = parse_json(save_game.get_as_text())
	
	get_tree().change_scene(data["scene"])
	
	loaded = true
	continuing = true
	
	playerX = data["pos_x"]
	playerY = data["pos_y"]
	
	save_game.close()

func new_game():
	get_tree().change_scene(level1)
	loaded = true

func _input(event):
	pass
func _process(delta):
	# Just loaded
	if loaded and has_node("/root/World/Player"):
		get_node("/root/World/Player/Camera2D/AnimationPlayer").play("instantFade")
		get_node("/root/World/Player/Camera2D").smoothing_enabled = false
		door = get_node("/root/World/doors/" + doorname)
		if continuing:
			get_node("/root/World/Player").loads(playerX, playerY)
		get_node("/root/World/Player/Camera2D").align()
		get_node("/root/World/Player/Camera2D").smoothing_enabled = true
		loaded = false
# ----- END SAVE -----	

# ----- TRANSITION -----
var destination = null
var offset = null
var anim = null
onready var door = null
var doorname = "Door0"

func record(a, b, c, d):
	destination = a
	offset = b
	anim = c
	doorname = d
	door = get_node("/root/World/doors/" + str(doorname))
	player = get_node("/root/World/Player")

func resend():
	player.enterDoor(destination, offset, anim)
	get_node("/root/World/Player/Camera2D").smoothing_enabled = false
	get_node("/root/World/Player/Camera2D").align()

func resendPart2():
	player.canMove = true
	get_node("/root/World/Player/Camera2D").smoothing_enabled = true
	door.tranStart = false
# ----- END TRANSITION -----
