extends KinematicBody2D

const speed = 256

onready var sprite = get_node("AnimatedSprite")
var anim = "rightidle"
var newAnim = false
var dominantAnim = ""

onready var canMove = true

func _ready():
	pass

func save():
	var save_dict = {
		"pos_x" : position.x,
		"pos_y" : position.y,
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"scene" : "res://" + (get_tree().get_current_scene().get_name()) + ".tscn"  
	}
	return save_dict

func loads(x, y):
	global_translate(Vector2(x, y) - Vector2(get_transform()[2]))	
	
	
func enterDoor(destination, offset, exitAnim):
	global_translate(Vector2(destination) - Vector2(get_transform()[2]) + offset)
	anim = exitAnim

func _process(delta):
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