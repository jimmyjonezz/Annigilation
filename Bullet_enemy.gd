extends KinematicBody2D

class_name Bullet

var speed = 940
var velocity = Vector2()

func start(pos, dir) -> void:
	rotation = dir
	position = pos
	velocity += Vector2(speed, 0).rotated(rotation)

func _physics_process(delta) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()
		if collision.collider.has_method("hit"):
			collision.collider.hit()
			
func _layer_off():
	set_collision_mask_bit(2, false)
	set_collision_mask_bit(1, false)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
