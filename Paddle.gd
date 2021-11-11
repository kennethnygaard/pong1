extends KinematicBody2D

var move_speed = 750
var move_vector = Vector2.ZERO
var p_controls = ["keyboard1", "keyboard2", "gamepad1", "gamepad2", "cpu"]
var P1_controls_number = 2
var P1_controls = p_controls[P1_controls_number]
var up_strength = 0
var down_strength = 0

signal paddle_hit(paddle, paddle_y)

func _ready():
	set_controls(P1_controls_number)
	pass # Replace with function body.

func _process(_delta):
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

	if(P1_controls=="gamepad1"):
		move_vector.y = 0
		up_strength = Input.get_action_strength("left_stick_up") 
		down_strength = Input.get_action_strength("left_stick_down")
		if(up_strength>0.1):
			move_vector.y -= move_speed*up_strength
		if(down_strength>0.1):
			move_vector.y += move_speed*down_strength

func on_area_entered(area2d):
	emit_signal("paddle_hit", 1, global_position.y)

func set_controls(controller):
	P1_controls_number = controller
	P1_controls = p_controls[P1_controls_number]
	print("set P1 controls: ", P1_controls)
	
