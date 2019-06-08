extends ColorRect

func fade_in():
	$AnimationPlayer.play("Fade")
	yield(get_tree().create_timer(0.5), "timeout")
	assert(get_tree().change_scene("res://Main/Main.tscn") == OK)