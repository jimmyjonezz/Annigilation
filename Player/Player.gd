extends "Character.gd"

class_name Player

export var Bullet : PackedScene

func _process(delta) -> void:
	direction()
	
	get_input()
	velocity = move_and_collide(velocity * delta)
	
	shooting()
	
func shooting() -> void:
	if !is_reload:
		return
		
	if !is_shooting:
		return
		
	shoot()
	$Gun/AFPlayer.play("fire")
	is_shooting = false

func shoot() -> void:
	$Shooting.start()
	var bullet = Bullet.instance()
	get_parent().add_child(bullet)
	bullet.start($Gun/Position2D.global_position, $Gun.rotation)
	#выстрел
	#take_damage(-1)
	
