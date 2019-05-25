extends Node2D

func _ready():
	get_tree().set_pause(false)
	
func _input(event):
	if Input.is_action_just_pressed("ui_f"):
		 OS.window_fullscreen = !OS.window_fullscreen
	
func _on_Start_pressed():
	$CanvasLayer/FadeIn.show()
	$CanvasLayer/FadeIn.fade_in()

func _on_Exit_pressed():
	get_tree().quit()