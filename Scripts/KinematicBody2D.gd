extends KinematicBody2D

const speed = 256

onready var sprite = get_node("AnimatedSprite")
var anim = "rightidle"
var newAnim = 0
var dominantAnim = ""
func _ready():
	pass

func _physics_process(delta):
	var runModifier = 1
	var moving = 0
	
	# var timer = Timer.now()
	# print()
	
	var motion = Vector2()
	
	
	if Input.is_action_pressed("up"):
		motion += Vector2(0, -1)
		moving = 1
		
		if anim == "down" and not Input.is_action_pressed("down"):
			newAnim = 1
			anim = "up"
		if anim == "left" and not Input.is_action_pressed("left"):
			newAnim = 1
			anim = "up"
		if anim == "right" and not Input.is_action_pressed("right"):
			newAnim = 1
			anim = "up"
		if newAnim == 0:
			newAnim = 1
			anim = "up"
	if Input.is_action_pressed("down"):
		motion += Vector2(0, 1)
		moving = 1
		if anim == "up" and not Input.is_action_pressed("up"):
			newAnim = 1
			anim = "down"
		if anim == "left" and not Input.is_action_pressed("left"):
			newAnim = 1
			anim = "down"
		if anim == "right" and not Input.is_action_pressed("right"):
			newAnim = 1
			anim = "down"		
		if newAnim == 0:
			newAnim = 1
			anim = "down"
	if Input.is_action_pressed("left"):
		motion += Vector2(-1, 0)
		moving = 1
		if anim == "up" and not Input.is_action_pressed("up"):
			newAnim = 1
			anim = "left"
		if anim == "down" and not Input.is_action_pressed("down"):
			newAnim = 1
			anim = "left"
		if anim == "right" and not Input.is_action_pressed("right"):
			newAnim = 1
			anim = "left"	
		if newAnim == 0:
			newAnim = 1
			anim = "left"
	if Input.is_action_pressed("right"):
		motion += Vector2(1, 0)
		moving = 1
		if anim == "up" and not Input.is_action_pressed("down"):
			newAnim = 1
			anim = "right"
		if anim == "down" and not Input.is_action_pressed("sown"):
			newAnim = 1
			anim = "right"
		if anim == "left" and not Input.is_action_pressed("left"):
			newAnim = 1
			anim = "right"	
		if newAnim == 0:
			newAnim = 1
			anim = "right"
	
	if moving == 0:
		newAnim = 0
		if not anim.ends_with("idle"):
			anim = str(anim + "idle")
	sprite.play(anim)
	# print(animation)
	
	if Input.is_action_pressed("run") and moving == 1:
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