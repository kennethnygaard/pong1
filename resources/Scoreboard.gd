extends Node2D

var left_score = 0
var right_score = 0

onready var left_zone = get_tree().get_nodes_in_group("left_zone")[0]
onready var right_zone = get_tree().get_nodes_in_group("right_zone")[0]

func _ready():
	left_zone.connect("left_out", self, "on_left_out")
	right_zone.connect("right_out", self, "on_right_out")
	#$MarginContainer/HBoxContainer/Left_score.get_font("font").size = 50

func on_left_out():
	right_score += 1
	$MarginContainer/HBoxContainer/Right_score.text = str(right_score)
	$Timer.blink(2)
	
func on_right_out():
	left_score += 1
	$MarginContainer/HBoxContainer/Left_score.text = str(left_score)
	$Timer.blink(1)

func reset():
	left_score = 0
	right_score = 0
	$MarginContainer/HBoxContainer/Left_score.text = str(left_score)
	$MarginContainer/HBoxContainer/Right_score.text = str(right_score)
