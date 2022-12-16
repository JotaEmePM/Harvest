extends CharacterBody2D

@export var move_speed: float = 100
@export var starting_direction: Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
# parameters/Idle/blend_position

var target = Vector2()

func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(delta):
	# En caso de ser inputs con teclado
#	var input_direction = Vector2(
#		Input.get_action_strength("right") - Input.get_action_strength("left"),
#		Input.get_action_strength("down") - Input.get_action_strength("up")
#	)
#	update_animation_parameters(input_direction)#
#	velocity = input_direction * move_speed	
#	move_and_slide()

# En caso de ser input click
	velocity = (target - position).normalized() * move_speed
	rotation = velocity.angle()
	if(target -position).length() > 5:
		move_and_slide()
		
	pick_new_state()	
	
	
func update_animation_parameters(move_input: Vector2):	
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)
		
func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
