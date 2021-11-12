extends Timer

onready var ball = get_tree().get_nodes_in_group("ball")[0]
var is_visible = true
var blink_duration = 0.2
var blink_counter = 0

func _ready():
	connect("timeout", self, "on_timeout")	
	$Blink_timer.connect("timeout", self, "on_blink_timeout")

func start_timer(duration):
	ball.is_paused = true
	#ball.enable_light(false)
	start(duration)
	blink_counter = 0
	$Blink_timer.start(blink_duration)

#func _process(delta):
#	pass

func on_timeout():
	ball.is_paused = false
	#ball.enable_light(true)
	ball.set_visible(true)
	$Blink_timer.stop()

func on_blink_timeout():
	is_visible = !is_visible
	ball.set_visible(is_visible)
	$Blink_timer.start(blink_duration)
	blink_counter += 1
	if(is_visible && blink_counter>1):
		$blink_sound.play()
