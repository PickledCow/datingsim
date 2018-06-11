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
export var transition = false
export var sceneChange = 0 #Leave 0 if same scene
onready var tranStart = false
onready var transitionNode = get_node("../Transitions")

func fadeSameScene(destination, offset, exitAnim):
	get_node("../Player/Camera2D/AnimationPlayer").play("fade")
	transitionNode.record(destination, offset, exitAnim, name)
	
func _ready():
	pass

func _process(delta):
	if transition and sceneChange == 0 and overlaps_body(player) and not tranStart:
		tranStart = true
		fadeSameScene((destination.get_transform())[2], destinationOffset, exitAnim)
	
	elif overlaps_body(player) and not tranStart:
		player.enterDoor((destination.get_transform())[2], destinationOffset, exitAnim)