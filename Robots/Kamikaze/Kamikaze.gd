extends KinematicBody2D

class_name Kamikaze

var speed
var path : = PoolVector2Array() setget set_path
var velocity = Vector2()
var current_health
var knockdir

func _ready():
	randomize()
	current_health = round(rand_range(4, 8))
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

func hit() -> void:
	for body in $hitbox.get_overlapping_bodies():
		pass
	
	current_health -= 1
	
	if current_health == 0:
		$"../../GUI".take_score()
		queue_free()

#я так и не понял, работает через раз
# в прошлых версиях Годот все было изумительно
func _on_hitbox_body_entered(body):
	if body.is_in_group("bullet"):
		#knockdir = (body.transform.get_origin() - transform.origin) / 5
		#velocity = move_and_slide(knockdir * position)
		#print("knock: ", knockdir * position)
		#print("pos: ", position)
		pass
