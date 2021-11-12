extends Node2D

onready var P1_button = $MarginContainer/VBoxContainer/HBoxContainer/P1_button
onready var P1_label = $MarginContainer/VBoxContainer/HBoxContainer/P1_label
onready var P2_button = $MarginContainer/VBoxContainer/HBoxContainer2/P2_button
onready var P2_label = $MarginContainer/VBoxContainer/HBoxContainer2/P2_label
onready var SFX_button = $MarginContainer/VBoxContainer/HBoxContainer3/SFX_button
onready var SFX_label = $MarginContainer/VBoxContainer/HBoxContainer3/SFX_label
onready var CPU_level_button = $MarginContainer/VBoxContainer/HBoxContainer4/CPU_level_button
onready var CPU_level_label = $MarginContainer/VBoxContainer/HBoxContainer4/CPU_level_label
onready var Speed_button = $MarginContainer/VBoxContainer/HBoxContainer5/Speed_button
onready var Speed_label = $MarginContainer/VBoxContainer/HBoxContainer5/Speed_label
onready var Restart_button = $MarginContainer/VBoxContainer/HBoxContainer8/Start_button
onready var Back_button = $MarginContainer/VBoxContainer/HBoxContainer8/Back_button
onready var Quit_button = $MarginContainer/VBoxContainer/HBoxContainer8/Quit_button

onready var main = get_tree().get_nodes_in_group("main")[0]
onready var ball = get_tree().get_nodes_in_group("ball")[0]
onready var paddles = get_tree().get_nodes_in_group("paddles")

var p_options = ["Keyboard #1", "Keyboard #2", "Gamepad #1", "Gamepad #2", "CPU"]
var p1_selected = 2
var p2_selected = 4
var sfx_on = true
var cpu_level = 1
var max_cpu_level = 3
var speed = 1
var max_speed = 3

var is_paused = true
var started_once = false

func _ready():
	$Sprite.modulate.a = 0.1
	P1_button.connect("pressed", self, "on_P1_button_pressed")
	P2_button.connect("pressed", self, "on_P2_button_pressed")
	SFX_button.connect("pressed", self, "on_sfx_button_pressed")
	CPU_level_button.connect("pressed", self, "on_cpu_level_button_pressed")
	Speed_button.connect("pressed", self, "on_speed_button_pressed")
	Restart_button.connect("pressed", self, "on_restart_button_pressed")
	Back_button.connect("pressed", self, "on_back_button_pressed")
	Quit_button.connect("pressed", self, "on_quit_button_pressed")
	
	Restart_button.text = "START"
	
	main.set_pause(true)
	
func on_P1_button_pressed():
	$ClickPlayer.play()
	p1_selected += 1
	if(p1_selected > p_options.size()-1):
		p1_selected = 0
	update_buttons()

func on_P2_button_pressed():
	$ClickPlayer.play()
	p2_selected += 1
	if(p2_selected > p_options.size()-1):
		p2_selected = 0
	update_buttons()

func on_sfx_button_pressed():
	$ClickPlayer.play()
	main.set_audio(sfx_on)

	sfx_on = !sfx_on
	update_buttons()

func on_cpu_level_button_pressed():
	$ClickPlayer.play()
	cpu_level += 1
	if(cpu_level > max_cpu_level):
		cpu_level = 1
	update_buttons()

func on_speed_button_pressed():
	$ClickPlayer.play()
	speed += 1
	if(speed > max_speed):
		speed = 1
	update_buttons()

func on_restart_button_pressed():
	$ClickPlayer.play()
	started_once = true
	Back_button.visible = true
	Restart_button.text = "RESTART"
	is_paused = false
	main.set_pause(is_paused)
	ball.ball_speed_level = speed
	
	paddles[0].set_cpu_level(cpu_level)
	paddles[1].set_cpu_level(cpu_level)
	
	visible = false
	ball.visible = true
	
	
	paddles[0].set_controls(p1_selected)
	paddles[1].set_controls(p2_selected)
	
	main.restart()

func on_back_button_pressed():
	$ClickPlayer.play()
	is_paused = false
	main.set_pause(is_paused)
	visible = false

func on_quit_button_pressed():
	$ClickPlayer.play()
	get_tree().quit()

func update_buttons():
	P1_label.text = p_options[p1_selected]
	P2_label.text = p_options[p2_selected]
	if(sfx_on):
		SFX_label.text = "ON"
	else:
		SFX_label.text = "OFF"
	CPU_level_label.text = str(cpu_level)
	Speed_label.text = str(speed)

func _process(_delta):
	if(Input.is_action_just_pressed("pause")):
		is_paused = !is_paused
		main.set_pause(is_paused)
		visible = is_paused
		reset_buttons()
	
func reset_buttons():
	speed = ball.ball_speed_level
	Speed_label.text = str(speed)
	p1_selected = paddles[0].P1_controls_number
	P1_label.text = p_options[paddles[0].P1_controls_number]
	cpu_level = paddles[0].cpu_move_level
	CPU_level_label.text = str(cpu_level)

