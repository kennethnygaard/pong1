extends Node2D

onready var restart_button = $MarginContainer/VBoxContainer/HBoxContainer8/Start_button
onready var quit_button = $MarginContainer/VBoxContainer/HBoxContainer8/Quit_button
onready var main = get_tree().get_nodes_in_group("main")[0]
onready var ball = get_tree().get_nodes_in_group("ball")[0]

func _ready():
	restart_button.connect("pressed", self, "on_restart_button_pressed")
	quit_button.connect("pressed", self, "on_quit_button_pressed")
	$Sprite.modulate.a = 0.1


func on_restart_button_pressed():
	$ClickPlayer.play()
	main.restart()
	ball.visible = true
	visible = false
	main.set_pause(false)

func on_quit_button_pressed():
	$ClickPlayer.play()
	get_tree().quit()

func set_win_player(player):
	var text = str("PLAYER ", player, " WINS!")
	$MarginContainer/VBoxContainer/HBoxContainer7/Win_label.text = text
