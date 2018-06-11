extends Area2D

export onready var player = get_node("../Player")
export onready var trigger = get_node("CollisionShape2D")
export onready var destination = get_node("../Door2")

func _ready():
	pass

func _process(delta):
	
	if overlaps_body(player) and not player.door == true:
		player.door = true
		player.enterDoor((destination.get_transform())[2])