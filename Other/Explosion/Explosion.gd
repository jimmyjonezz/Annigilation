extends Sprite

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Boom":
		queue_free()
