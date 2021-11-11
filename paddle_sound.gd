extends Node

onready var rng = RandomNumberGenerator.new()

func _ready():

	rng.randomize()

func play():
	
	var sounds = get_children()
	var size = sounds.size()
	var index = rng.randi_range(0, size-1)
	sounds[index].play()
