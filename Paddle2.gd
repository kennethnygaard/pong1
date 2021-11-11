extends KinematicBody2D

var move_speed = 400
var move_vector = Vector2.ZERO
var p_controls = ["gamepad1", "gamepad2", "keyboard1", "keyboard2", "cpu"]
var P2_controls = p_controls[4]
var up_strength = 0
var down_strength = 0

enum Mode {CPU, PLAYER}

var mode = Mode.CPU
onready var ball = get_tree().get_nodes_in_group("ball")[0]

func _ready():
	pass # Replace with function body.

func _process(delta):
	if(P2_controls == "cpu"):
		if(ball.move_vector.x > 0):
			var direction = -1
			if(ball.global_position.y > global_position.y):
				direction = 1
			move_vector.y = direction * move_speed
		else:
			move_vector.y = 0

	else:
		check_for_input()
		
	move_and_slide(move_vector)
	global_position.y = clamp(global_position.y, 45, 555)
	
func check_for_input():
	if(Input.is_action_just_pressed("P2_up")):
		move_vector.y -= move_speed
	if(Input.is_action_just_released("P2_up")):
		move_vector.y += move_speed
	if(Input.is_action_just_pressed("P2_down")):
		move_vector.y += move_speed
	if(Input.is_action_just_released("P2_down")):
		move_vector.y -= move_speed
