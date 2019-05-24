extends Node2D

func _ready():
	pass # Replace with function body.

func _on_Start_pressed():
	var good = get_tree().change_scene("res://Main/Main.tscn")
	if good:
		print("start to game")

func _on_Exit_pressed():
	queue_free()
