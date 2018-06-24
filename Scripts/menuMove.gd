extends Sprite

#528 303
#1028
var movement = 0

func _ready():
	pass

func _process(delta):
	movement += 0.004
	if movement >= 360:
		movement = 0
	global_translate(Vector2(750 + (cos(movement)*225),303) - Vector2(get_transform()[2]))