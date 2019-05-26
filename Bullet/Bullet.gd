extends KinematicBody2D

class_name Bullet

var speed = 940
var velocity = Vector2()
var switch = false

func _ready(): 
	if get_parent().name == "SpawnEnemy":
		$Image.texture = load("res://Image/enemy_02/bullet_red.png")
		_layer_off()
		switch = true

func start(pos, dir) -> void:
	rotation = dir
	position = pos
	velocity += Vector2(speed, 0).rotated(rotation)

func _physics_process(delta) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()
		if switch:
			if collision.collider.has_method("hit_player"):
				collision.collider.hit_player()
		else:
			if collision.collider.has_method("hit"):
				collision.collider.hit()
			
			
func _layer_off():
	set_collision_mask_bit(3, false)
	set_collision_mask_bit(6, false)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
