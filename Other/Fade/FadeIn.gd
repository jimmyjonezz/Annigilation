extends ColorRect

func fade_in():
	$AnimationPlayer.play("Fade")
	yield(get_tree().create_timer(.5), "timeout")
	get_tree().change_scene("res://Main/Main.tscn")