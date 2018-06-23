extends Node2D

var alreadySaved = false
var alreadyLoaded = false
var saveID = 0
export var main_menu = false
var loaded = false
var playerX = 0
var playerY = 0
var scene = ""
export var level1 = "res://World.tscn"

func save_game():
	var save_game = File.new()
	save_game.open("user://save" + str(saveID), File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("persist")
	for i in save_nodes:
		var node_data = i.call("save")
		save_game.store_line(to_json(node_data))    
	save_game.close()

func _ready():
	pass

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://save" + str(saveID)): # JUUUUST in case
		return
	
	#var save_nodes = get_tree().get_nodes_in_group("persist")
	
	save_game.open("user://save" + str(saveID), File.READ)
	var data = parse_json(save_game.get_as_text())
	
	get_tree().change_scene(data["scene"])
	
	loaded = true
	playerX = data["pos_x"]
	playerY = data["pos_y"]
	
	save_game.close()

func new_game():
	get_tree().change_scene(level1)

func _input(event):
	if not main_menu:
		if event.is_action_pressed("save") and not alreadySaved:
			alreadySaved = true
			save_game()
		if event.is_action_released("save") and alreadySaved:
			alreadySaved = false
			
func _process(delta):
	if loaded and has_node("/root/World/Player"):
		get_node("/root/World/Player").loads(playerX, playerY)
		loaded = false