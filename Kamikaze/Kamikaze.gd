extends KinematicBody2D

class_name Kamikaze

var speed
var path : = PoolVector2Array() setget set_path
var velocity = Vector2()

func _ready():
	randomize()
	speed = rand_range(50, 65)
	set_process(false)
	
func set_path(value: PoolVector2Array) -> void:
	path = value
	if path.size() == 0:
		return
	set_process(true)
	
func _process(delta) -> void:
	if path.size() > 1:
		var distance = path[1] - global_position
		var direction = distance.normalized()
		
		if sign(direction.x) == 1:
			$Image.flip_h = true
		else:
			$Image.flip_h = false
		
		velocity = move_and_collide(direction * speed * delta)
	else:
		set_process(false)