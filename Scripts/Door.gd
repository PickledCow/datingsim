extends Area2D

onready var player = get_node("../../" + playerName)
var playerName = "Player"
var triggerName = "CollisionShape2D"
onready var trigger = get_node(triggerName)
#export var DestinationID = 0
export(NodePath) onready var destinationName
#onready var destinationName = "Door" + str(DestinationID)
onready var destination = get_node(destinationName)
onready var destinationOffset = Vector2(0, 0)
export var offsetX = 0
export var offsetY = 0
export(String, "left", "right", "up", "down") var exitAnim = "right"
export var transition = true
export(String, "left", "right", "top", "bottom") var triggerPosition = "right"
export(String, FILE) var destination_scene
onready var tranStart = false
onready var transitionNode = get_node("/root/main")

func fadeSameScene(destination, offset, exitAnim):
	get_node("/root/main/transition/AnimationPlayer").play("fade")
	transitionNode.record(destination, offset, exitAnim, name)
	
func fadeDifferentScene(destination, scene, offset, exitAnim):
	get_node("/root/main/transition/AnimationPlayer").play("fade")
	transitionNode.record(destination, offset, exitAnim, name)
	
func _ready():
	offsetX = offsetX * 32
	offsetY = offsetY * 32
	destinationOffset = Vector2(offsetX, offsetY)
	
	if triggerPosition == "top":
		trigger.position.x = 0
		trigger.position.y = -16
		trigger.rotation = 0
	if triggerPosition == "bottom":
		trigger.position.x = 0
		trigger.position.y = 16
		trigger.rotation = 0
	if triggerPosition == "left":
		trigger.position.x = -16
		trigger.position.y = 0
		trigger.rotation = PI/2
	if triggerPosition == "right":
		trigger.position.x = 16
		trigger.position.y = 0
		trigger.rotation = PI/2
	
	

func _process(delta):
	if transition and str(destination_scene) == "Null" and overlaps_body(player) and not tranStart:
		tranStart = true
		player.canMove = false
		fadeSameScene((destination.get_transform())[2], destination.destinationOffset, destination.exitAnim)
	
	elif str(destination_scene) == "Null" and overlaps_body(player) and not tranStart:
		tranStart = true
		player.canMove = false
		fadeDifferentScene((destination.get_transform())[2], destinationOffset, exitAnim)
		
	elif str(destination_scene) == "Null" and overlaps_body(player) and not tranStart:
		player.enterDoor((destination.get_transform())[2], destinationOffset, exitAnim)
	