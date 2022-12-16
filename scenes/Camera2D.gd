extends Camera2D

var last_position = Vector2()
var velocity = Vector2()
@export var speed = 0.2

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			last_position = event.position
		else:
			velocity = Vector2.ZERO
	elif event is InputEventMouseMotion:
		velocity = (event.position - last_position) * speed
		translate(Vector2(-velocity.x, -velocity.y))
		
		last_position = event.position
