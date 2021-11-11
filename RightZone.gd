extends Area2D

onready var ball = get_tree().get_nodes_in_group("ball")[0]
onready var restart_timer = get_tree().get_nodes_in_group("restart_timer")[0]

onready var out_audio = get_tree().get_nodes_in_group("out_audio")[0]

signal right_out

func _ready():
	connect("area_entered", self, "on_area_entered")

func on_area_entered(area2d):
	ball.reset_position()
	restart_timer.start_timer(2)	
	emit_signal("right_out")
	out_audio.play()
