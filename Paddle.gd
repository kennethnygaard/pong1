extends KinematicBody2D

var move_speed = 750
var cpu_move_speed = 350
var cpu_move_level = 1
var move_vector = Vector2.ZERO
var p_controls = ["keyboard1", "keyboard2", "gamepad1", "gamepad2", "cpu"]
var P1_controls_number = 2
var P1_controls = p_controls[P1_controls_number]
var up_strength = 0
var down_strength = 0

signal paddle_hit(paddle, paddle_y)

onready var ball = get_tree().get_nodes_in_group("ball")[0]

func _ready():
	set_controls(P1_controls_number)
	pass # Replace with function body.

func _process(_delta):
	if(P1_controls == "cpu"):
		if(ball.move_vector.x < 0):
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
	if(P1_controls=="keyboard1"):
		if(Input.is_action_just_pressed("P1_up")):
			move_vector.y -= move_speed
		if(Input.is_action_just_released("P1_up")):
			move_vector.y += move_speed
		if(Input.is_action_just_pressed("P1_down")):
			move_vector.y += move_speed
		if(Input.is_action_just_released("P1_down")):
			move_vector.y -= move_speed

	if(P1_controls == "keyboard2"):
		if(Input.is_action_just_pressed("P2_up")):
			move_vector.y -= move_speed
		if(Input.is_action_just_released("P2_up")):
			move_vector.y += move_speed
		if(Input.is_action_just_pressed("P2_down")):
			move_vector.y += move_speed
		if(Input.is_action_just_released("P2_down")):
			move_vector.y -= move_speed

	if(P1_controls=="gamepad1"):
		move_vector.y = 0
		up_strength = Input.get_action_strength("left_stick_up") 
		down_strength = Input.get_action_strength("left_stick_down")
		if(up_strength>0.1):
			move_vector.y -= move_speed*up_strength
		if(down_strength>0.1):
			move_vector.y += move_speed*down_strength

	if(P1_controls=="gamepad2"):
		move_vector.y = 0
		up_strength = Input.get_action_strength("left_stick_up_2") 
		down_strength = Input.get_action_strength("left_stick_down_2")
		if(up_strength>0.1):
			move_vector.y -= move_speed*up_strength
		if(down_strength>0.1):
			move_vector.y += move_speed*down_strength

func on_area_entered(area2d):
	emit_signal("paddle_hit", 1, global_position.y)

func set_controls(controller):
	P1_controls_number = controller
	P1_controls = p_controls[P1_controls_number]

func set_cpu_level(level):
	cpu_move_level = level
	cpu_move_speed = 150 + level*200
