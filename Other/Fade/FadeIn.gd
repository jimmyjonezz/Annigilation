extends ColorRect

func fade_in():
	$AnimationPlayer.play("Fade")
	yield($AnimationPlayer, "animation_finished")
	assert(get_tree().change_scene("res://Main/Main.tscn") == OK)