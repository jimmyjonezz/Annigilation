extends Sprite

func _ready():
	$Kabooom.play()
	$AnimationPlayer.play("Kaboom")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Kaboom":
		queue_free()
