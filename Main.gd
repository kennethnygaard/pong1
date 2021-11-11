extends Node

func _ready():
	$Restart_timer.start_timer(2)

func _process(_delta):
	pass

func set_pause(is_paused):
	get_tree().paused = is_paused

func restart():
	$Scoreboard.reset()
	$Ball.reset()
	$Ball.set_ball_speed($Ball.ball_speed_level)
	$Ball.clamp_start_angle()
	$Restart_timer.start_timer(2)
	$Paddle.global_position.y = 300
	$Paddle2.global_position.y = 300

func set_audio(is_on):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), is_on)
