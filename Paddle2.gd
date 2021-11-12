extends KinematicBody2D

var cpu_move_speed = 400
var cpu_move_level = 1
var move_speed = 750
var move_vector = Vector2.ZERO
var p_controls = ["keyboard1", "keyboard2", "gamepad1", "gamepad2", "cpu"]
var P2_controls = p_controls[4]
var P2_controls_number = 4
var up_strength = 0
var down_strength = 0

signal paddle_hit(paddle, paddle_y)

onready var ball = get_tree().get_nodes_in_group("ball")[0]

func _ready():
	pass # Replace with function body.

func _process(delta):
	if(P2_controls == "cpu"):
		if(ball.move_vector.x > 0):
			var direction = -1
			if(ball.global_position.y > global_position.y):
				direction = 1
			move_vector.y = direction * cpu_move_speed
		else:
			move_vector.y = 0
	else:
		check_for_input()
		
	move_and_slide(move_vector)
	$Area2D.connect("area_entered", self, "on_area_entered")
	global_position.y = clamp(global_position.y, 45, 555)
	
func check_for_input():
	if(P2_controls == "keyboard1"):
		if(Input.is_action_just_pressed("P1_up")):
			move_vector.y -= move_speed
		if(Input.is_action_just_released("P1_up")):
			move_vector.y += move_speed
		if(Input.is_action_just_pressed("P1_down")):
			move_vector.y += move_speed
		if(Input.is_action_just_released("P1_down")):
			move_vector.y -= move_speed
		
	if(P2_controls == "keyboard2"):
		if(Input.is_action_just_pressed("P2_up")):
			move_vector.y -= move_speed
		if(Input.is_action_just_released("P2_up")):
			move_vector.y += move_speed
		if(Input.is_action_just_pressed("P2_down")):
			move_vector.y += move_speed
		if(Input.is_action_just_released("P2_down")):
			move_vector.y -= move_speed

	if(P2_controls=="gamepad1"):
		move_vector.y = 0
		up_strength = Input.get_action_strength("left_stick_up") 
		down_strength = Input.get_action_strength("left_stick_down")
		if(up_strength>0.1):
			move_vector.y -= move_speed*up_strength
		if(down_strength>0.1):
			move_vector.y += move_speed*down_strength

	if(P2_controls=="gamepad2"):
		move_vector.y = 0
		up_strength = Input.get_action_strength("left_stick_up_2") 
		down_strength = Input.get_action_strength("left_stick_down_2")
		if(up_strength>0.1):
			move_vector.y -= move_speed*up_strength
		if(down_strength>0.1):
			move_vector.y += move_speed*down_strength

func on_area_entered(area2d):
	emit_signal("paddle_hit", 2, global_position.y)

func set_controls(controller):
	P2_controls_number = controller
	P2_controls = p_controls[P2_controls_number]
	print("set P2 controls: ", P2_controls)

func set_cpu_level(level):
	cpu_move_level = level
	cpu_move_speed = 300 + level*100

