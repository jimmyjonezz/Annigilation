extends "Character.gd"

signal health_changed(health)
signal die()

var knockdir

#загружаем префаб пуль
export var Bullet : PackedScene
#onready var camera = $"../../Position/Player/Camera2D"

func _ready():
	emit_signal("health_changed", health)
	$Area2D.connect("body_entered", self, "_body_entered")

func _process(delta) -> void:
	direction()
	
	#нажимаем клавиши
	get_input()
	move_and_collide(velocity * delta)

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
	
func _body_entered(body):
	if body.is_in_group("props"):
		if health < max_health:
			var kit = round(rand_range(3, 6))
			heal(kit) #add heall 1 - 4
			body.hitbox() #call function "hit" on body
	if body.is_in_group("enemy"):
		if health > 0:
			heal(-1)
	
func _physics_process(delta):
	var overlapping_bodies = $Area2D.get_overlapping_bodies()
	if not overlapping_bodies:
		return
	
	for body in overlapping_bodies:
		if body.is_in_group("enemy"):
			knockdir = body.position - self.position
			var pos = position - (knockdir * 2)
			$Tween.interpolate_property(self, "position", 
					position, pos, 0.3, 
					$Tween.TRANS_LINEAR, $Tween.EASE_IN)
			$Tween.start()
			
			if health < 1:
				emit_signal("die")