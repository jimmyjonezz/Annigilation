extends "Character.gd"

#загружаем префаб пуль
export var Bullet : PackedScene
#onready var camera = $"../../Position/Player/Camera2D"

func _process(delta) -> void:
	direction()
	
	#нажимаем клавиши
	get_input()
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("hitbox"):
			collision.collider.hitbox()

	#стреляем
	shooting()
	
func shooting() -> void:
	if !is_reload:
		return
		
	if !is_shooting:
		return
		
	shoot()
	
	#сатрясам экран
	#camera.shake()
	$Gun/AFPlayer.play("fire")
	is_shooting = false

#стрельба - спавн пули, позиция и ее поворот
func shoot() -> void:
	$Shooting.start()
	var bullet = Bullet.instance()
	get_parent().add_child(bullet)
	bullet.start($Gun/Position2D.global_position, $Gun.rotation)
	#выстрел
	#take_damage(-1)