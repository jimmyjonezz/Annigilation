extends ColorRect

func fade_in():
	$AnimationPlayer.play("Fade")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade":
		get_tree().change_scene("res://Main/Main.tscn")
