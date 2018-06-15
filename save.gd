extends Node2D

var alreadySaved = false
var alreadyLoaded = false

func save_game():
	var save_game = File.new()
	save_game.open("user://save.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("persist")
	for i in save_nodes:
		var node_data = i.call("save")
		save_game.store_line(to_json(node_data))
	save_game.close()

func _ready():
	pass

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://save.save"):
		return
	
	var save_nodes = get_tree().get_nodes_in_group("persist")
	#for i in save_nodes:
	#	i.queue_free()
	
	save_game.open("user://save.save", File.READ)
	var data = parse_json(save_game.get_as_text())
	
	get_node("Player").loads(data["pos_x"], data["pos_y"])
		
	save_game.close()

func _input(event):
	if event.is_action_pressed("save") and not alreadySaved:
		alreadySaved = true
		save_game()
	if event.is_action_pressed("dash") and not alreadyLoaded:
		alreadyLoaded = true
		load_game()
	if event.is_action_released("save") and alreadySaved:
		alreadySaved = false
	if event.is_action_released("dash") and alreadyLoaded:
		alreadyLoaded = false
	