extends KinematicBody2D

const speed = 256

onready var sprite = get_node("AnimatedSprite")
var anim = "rightidle"
var newAnim = false
var dominantAnim = ""

onready var canMove = true

onready var rayUpLeftA = get_node("rayUpLeftA")
onready var rayUpLeftB = get_node("rayUpLeftB")
onready var rayUpRightA = get_node("rayUpRightA")
onready var rayUpRightB = get_node("rayUpRightB")
onready var rayDownLeftA = get_node("rayDownLeftA")
onready var rayDownLeftB = get_node("rayDownLeftB")
onready var rayDownRightA = get_node("rayDownRightA")
onready var rayDownRightB = get_node("rayDownRightB")
onready var rayRightDownA = get_node("rayRightDownA")
onready var rayRightDownB = get_node("rayRightDownB")
onready var rayRightUpA = get_node("rayRightUpA")
onready var rayRightUpB = get_node("rayRightUpB")
onready var rayLeftDownA = get_node("rayLeftDownA")
onready var rayLeftDownB = get_node("rayLeftDownB")
onready var rayLeftUpA = get_node("rayLeftUpA")
onready var rayLeftUpB = get_node("rayLeftUpB")

func _ready():
	pass

func enterDoor(destination, offset, exitAnim):
	global_translate(Vector2(destination) - Vector2(get_transform()[2]) + offset)
	anim = exitAnim

func _physics_process(delta):
	if canMove:
		var runModifier = 1
		var moving = false
		
		var motion = Vector2()
		
		if Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
			motion += Vector2(0, -1)
			moving = true
	
			if (anim == "down" or anim == "downidle") and not Input.is_action_pressed("down"):
				newAnim = true
				anim = "up"
			if (anim == "left" or anim == "leftidle") and not Input.is_action_pressed("left"):
				newAnim = true
				anim = "up"
			if (anim == "right" or anim == "rightidle") and not Input.is_action_pressed("right"):
				newAnim = true
				anim = "up"
			if newAnim == false:
				newAnim = true
				anim = "up"
	
		if Input.is_action_pressed("down") and not Input.is_action_pressed("up"):
			motion += Vector2(0, 1)
			moving = true
				
			if (anim == "up" or anim == "upidle") and not Input.is_action_pressed("up"):
				newAnim = true
				anim = "down"
			if (anim == "left" or anim == "leftidle") and not Input.is_action_pressed("left"):
				newAnim = true
				anim = "down"
			if (anim == "right" or anim == "rightidle") and not Input.is_action_pressed("right"):
				newAnim = true
				anim = "down"
			if newAnim == false:
				newAnim = true
				anim = "down"
	
		if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
			motion += Vector2(-1, 0)
			moving = true
		
			if (anim == "up" or anim == "upidle") and not Input.is_action_pressed("up"):
				newAnim = true
				anim = "left"
			if (anim == "down" or anim == "downidle") and not Input.is_action_pressed("down"):
				newAnim = true
				anim = "left"
			if (anim == "right" or anim == "rightidle") and not Input.is_action_pressed("right"):
				newAnim = true
				anim = "left"	
				
			if newAnim == false:
				newAnim = true
				anim = "left"
				
		if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
			motion += Vector2(1, 0)
			moving = true
			
				
			if (anim == "up" or anim == "upidle") and not Input.is_action_pressed("up"):
				newAnim = true
				anim = "right"
			if (anim == "down" or anim == "downidle") and not Input.is_action_pressed("down"):
				newAnim = true
				anim = "right"
			if (anim == "left" or anim == "leftidle") and not Input.is_action_pressed("left"):
				newAnim = true
				anim = "right"	
			if newAnim == false:
				newAnim = true
				anim = "right"
		
		if Input.is_action_pressed("run") and moving == true:
			if runModifier > 1.5:
				runModifier = (runModifier + 0.0005)^2
			else:
				runModifier = 1.5
		else:
			if runModifier < 1:
				runModifier = (runModifier - 0.0005)^2
			else:
				runModifier = 1
		
		if motion.y < 0 and rayUpLeftA.is_colliding() and not rayUpLeftB.is_colliding():
			motion += Vector2(-1, 0)
		if motion.y < 0 and rayUpRightA.is_colliding() and not rayUpRightB.is_colliding():
			motion += Vector2(1, 0)
		if motion.y > 0 and rayDownLeftA.is_colliding() and not rayDownLeftB.is_colliding():
			motion += Vector2(-1, 0)
		if motion.y > 0 and rayDownRightA.is_colliding() and not rayDownRightB.is_colliding():
			motion += Vector2(1, 0)
		if motion.x > 0 and rayRightDownA.is_colliding() and not rayRightDownB.is_colliding():
			motion += Vector2(0, -1)
		if motion.x > 0 and rayRightUpA.is_colliding() and not rayRightUpB.is_colliding():
			motion += Vector2(0, 1)
		if motion.x < 0 and rayLeftDownA.is_colliding() and not rayLeftDownB.is_colliding():
			motion += Vector2(0, -1)
		if motion.x < 0 and rayLeftUpA.is_colliding() and not rayLeftUpB.is_colliding():
			motion += Vector2(0, 1)
	
		motion = motion.normalized() * speed * runModifier
	
		
		move_and_slide(motion)
		
		if moving == false:
			newAnim = false
			if not anim.ends_with("idle"):
				anim = str(anim + "idle")
		
	else:
		newAnim = false
		if not anim.ends_with("idle"):
			anim = str(anim + "idle")
			
	sprite.play(anim)