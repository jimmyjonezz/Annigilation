extends KinematicBody2D

var speed = 340
var velocity = Vector2()

func start(pos, dir) -> void:
	rotation = dir
	position = pos
	velocity += Vector2(speed, 0).rotated(rotation)
	$Tic.start()

func _physics_process(delta) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()
	#	velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_Tic_timeout():
	queue_free()
