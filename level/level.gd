extends Node2D


func _ready():
	pass


func _process(delta):
	if (Input.is_key_pressed(KEY_Q)):
		GameManager.load_main_scene()












