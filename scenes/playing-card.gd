extends Sprite2D

func _ready():
	pass


func _process(delta):
	pass

func setTexture(suit: String, card: int):
	var path: String
	match card:
		1: 
			path = "res://images/cards/" + suit + "_ace.png"
		11: 
			path = "res://images/cards/" + suit + "_jack.png"
		12: 
			path = "res://images/cards/" + suit + "_queen.png"
		13: 
			path = "res://images/cards/" + suit + "_king.png"
		_: 
			path = "res://images/cards/" + suit + "_" + str(card) + ".png"
		
	print(path)
	texture = load(path)
	pass

func setPosition(x: float, y:float):
	position = Vector2(x, y)
	pass

func setRotation(degrees: int):
	set_rotation_degrees(degrees)
	pass

func setSize(newSize: float):
	scale = Vector2(newSize, newSize)
	pass
