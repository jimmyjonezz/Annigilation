extends Camera2D

var shake_amount = 1.0

func _ready():
	pass # Replace with function body.

func shake() -> void:
	set_offset(Vector2(rand_range(-1.0, 1.0) * shake_amount, 
			rand_range(-1.0, 1.0) * shake_amount))
	yield(get_tree().create_timer(0.2), "timeout")
	set_offset(Vector2(0, 0))