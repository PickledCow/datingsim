extends Area2D

onready var player = get_node("../" + playerName)
export var playerName = "Player"
onready var trigger = get_node(triggerName)
export var triggerName = "CollisionShape2D"
onready var destination = get_node("../" + destinationName)
export var destinationName = "Door2"
onready var destinationOffset = Vector2(offsetX, offsetY)
export var offsetX = 2
export var offsetY = 5
export var exitAnim = ""

func _ready():
	pass

func _process(delta):
	
	if overlaps_body(player) and not player.door == true:
		player.enterDoor((destination.get_transform())[2], destinationOffset, exitAnim)