extends KinematicBody2D

func _ready():
	randomize()
	popup()

func popup():
	$Tween.interpolate_property(self, "position", 
			position, position + Vector2(rand_range(-4, 4), rand_range(-4, 4)), 
			0.3, $Tween.TRANS_LINEAR, $Tween.EASE_IN)
	$Tween.start()

func hitbox():
	queue_free()
