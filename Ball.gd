extends KinematicBody2D

var move_speed = 300
var move_vector = Vector2.ZERO
var ball_speed = 600
var is_paused = true
var ball_speed_level = 1

onready var paddlecolliders = get_tree().get_nodes_in_group("paddlecolliders")
onready var boundaries = get_tree().get_nodes_in_group("boundaries")
onready var paddle1 = get_tree().get_nodes_in_group("paddles")[0]
onready var paddle2 = get_tree().get_nodes_in_group("paddles")[1]
var angle = 0

func _ready():
	move_vector = Vector2(-300, -50)
	move_vector = move_vector.normalized()
	
	set_ball_speed(ball_speed_level)
	
	set_vector_from_angle(PI/16)
	
	for p in paddlecolliders:
		p.connect("area_entered", self, "on_paddle_touched")
	for b in boundaries:
		b.connect("area_entered", self, "on_boundary_touched")
	paddle1.connect("paddle_hit", self, "on_paddle_hit")
	paddle2.connect("paddle_hit", self, "on_paddle_hit")
	
func _process(delta):
	if not is_paused:
		move_and_slide(move_vector*ball_speed)
	
func on_paddle_touched(area2d):
	move_vector.x = -move_vector.x
	$paddle_sound.play()
	
func on_boundary_touched(area2d):
	move_vector.y = -move_vector.y
	$sides_sound.play()

func on_paddle_hit(paddle, paddle_y):
	if(paddle==1):
		var diff = global_position.y - paddle_y
		angle = move_vector.angle()
		angle += diff/90
		clamp_angle(PI/4)
		set_vector_from_angle(angle)
	if(paddle==2):
		var diff = global_position.y - paddle_y
		angle = move_vector.angle()
		angle -= diff/90
		clamp_angle(PI/4)
		set_vector_from_angle(angle)
		

func reset_position():
	global_position = Vector2(500, 300)
	angle = move_vector.angle()
	clamp_start_angle()

func set_visible(is_visible):
	$Sprite.visible = is_visible

func enable_light(is_enabled):
	$Sprite/Light2D.enabled = is_enabled

func clamp_angle(clamp_angle):
	while(angle < 0):
		angle += 2*PI
	while(angle > 2*PI):
		angle -= 2*PI
		
	var max_angle = clamp_angle
	
	if(angle > PI/2 && angle < 3*PI/2):
		angle = clamp(angle, PI-max_angle, PI+max_angle)

	if(angle < PI/2):
		angle = clamp(angle, 0, max_angle)

	if(angle > 3*(PI/2)):
		angle = clamp(angle, 2*PI-max_angle, 2*PI)

	

	#angle = clamp(angle, -max_angle, max_angle)
	move_vector = Vector2(cos(angle), sin(angle))
	
func clamp_start_angle():
	clamp_angle(PI/16)

func set_vector_from_angle(vec_angle):
		move_vector = Vector2(cos(vec_angle), sin(vec_angle))

func set_ball_speed(speed):
	ball_speed = 400 + 300*speed

func reset():
	global_position = Vector2(512, 300)
