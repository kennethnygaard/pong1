extends Timer

var blinks = 0
var player = 0

onready var left_score = get_tree().get_nodes_in_group("left_score")[0]
onready var right_score = get_tree().get_nodes_in_group("right_score")[0]

func _ready():
	print("timer ready")
	connect("timeout", self, "on_timeout")
	$Blink_timer.connect("timeout", self, "on_blink_timeout")

func blink(player_number):
	player = player_number
	blinks = 6
	start(0.20)

func on_timeout():
	blinks -= 1
	
	if(blinks > 0):
		if(player == 1):
			left_score.modulate.a = 1.0 - left_score.modulate.a
		if(player == 2):
			right_score.modulate.a = 1.0 - right_score.modulate.a
		start(0.20)

	else:
		left_score.modulate.a = 1
		right_score.modulate.a = 1
		player = 0
		
func on_blink_timeout():
	pass



