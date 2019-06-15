extends "Character.gd"

signal die()

var inbody = false

#загружаем префаб пуль
export var Bullet : PackedScene

func _ready() -> void:
	$Area2D.connect("body_entered", self, "_body_entered")
	$Area2D.connect("body_exited", self, "_body_exited")

func _process(delta) -> void:
	_knockback(delta)
	direction()
	
	#нажимаем клавиши
	get_input()

	#стреляем
	shooting()
	
func shooting() -> void:
	if !is_reload:
		return
		
	if !is_shooting:
		return
	
	if count > 1:
		shoot()
		damage(-1)
	
		$Gun/AFPlayer.play("fire")
		$Reload.stop()
	
	is_shooting = false
	$Reload.start()

#стрельба - спавн пули, позиция и ее поворот
func shoot() -> void:
	$Shooting.start()
	var bullet = Bullet.instance()
	get_parent().add_child(bullet)
	bullet.start($Gun/Position2D.global_position, $Gun.rotation)
	
func _body_entered(body):
	if body.is_in_group("props"):
		if health < max_health:
			var kit = round(rand_range(3, 6))
			heal(kit) #add heall 1 - 4
			body.hitbox() #call function "hit" on body
	if body.is_in_group("ammo"):
		var value = round(rand_range(9, 12))
		if count < 60:
			damage(value)
			body.hitbox()
			
	if body.is_in_group("enemy"):
		if health > 0:
			heal(-1)

func _body_exited(body):
	if body.is_in_group("enemy"):
		inbody = false
		
func _knockback(delta):
	var overlapping_bodies = $Area2D.get_overlapping_bodies()
	if not overlapping_bodies:
		return
	
	for body in overlapping_bodies:
		if body.is_in_group("enemy"):
			inbody = true
			#реализован метод knockback - отталкивание перса
			var target_dir = (position - body.position).normalized()
			#print("position: %s, target: %s, pos: %s" % [position, target_dir, position * target_dir])
			move_and_collide(position * target_dir * delta * 2.8)
			
			if health < 1:
				emit_signal("die")
	
func _physics_process(delta):
	move_and_collide(velocity * delta)

func hit():
	if health > 0:
		heal(-1)
	if health < 1:
		emit_signal("die")
		
func hit_player():
	hit()

func _on_Damage_timeout():
	if inbody == true:
		hit()

func _on_Reload_timeout():
	if count < 60:
		damage(1)
