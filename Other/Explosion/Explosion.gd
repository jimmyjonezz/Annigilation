extends Sprite

func _ready():
	$AnimationPlayer.play("Boom")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Boom":
		queue_free()
