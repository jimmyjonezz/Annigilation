extends KinematicBody2D

class_name Kamikaze

export var Ammo : PackedScene
export var Boom : PackedScene

var speed
var path : = PoolVector2Array() setget set_path
var velocity = Vector2()
var current_health = 9
var value_damage = -1

func _ready():
	randomize()
	speed = rand_range(165, 175)
	set_process(false)
	
func set_path(value: PoolVector2Array) -> void:
	path = value
	if path.size() == 0:
		return
	set_process(true)
	
func _draw():
	if path.size() > 1:
		for p in path:
			draw_circle(p - get_global_position(), 8.8, Color(1, 0, 0))
	
func _physics_process(delta) -> void:
	var new_path = get_node("../../World/Navigation").get_simple_path(
			position, get_node("../../Position/Player").position, false)
	#new_path.remove(0)
	if new_path.size() > 1:
		path = new_path
	
		var distance = path[1] - global_position
		var direction = distance.normalized()
		
		if sign(direction.x) == 1:
			$Image.flip_h = true
		else:
			$Image.flip_h = false
		
		if $APlayer.is_playing() and $APlayer.current_animation == "atack":
			yield($APlayer, "animation_finished")
		else:
			velocity = move_and_collide(direction * speed * delta)
			$APlayer.play("walk")
	else:
		$tic.start()
		$APlayer.play("idle")
	
	update()
		
func hit() -> void:
	value_damage = rand_range(-3, -1)
	$Popup.visible = true
	current_health += value_damage
	$Popup.heal(value_damage)
	$Timer.start()
	
	if current_health <= 0:
		#сатрясам экран
		$"../../Position/Player/Camera2D/screenshake".start()
		spawn_boom()
		$"../../GUI".take_score(10)
		_spawn_props()
		queue_free()

func _on_Timer_timeout():
	#прячем healthbar
	$Popup.visible = false

func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		$APlayer.play("atack")
		#yield($APlayer, "animation_finished")

func _spawn_props():
	var rnd = randi() % 3
	match rnd:
		0:
			return
		1, 2: 
			#аптечка
			var Ammo_instance = Ammo.instance()
			Ammo_instance.set_position(global_position)
			$"../../SpawnProps/".add_child(Ammo_instance)
			
func spawn_boom():
	var Boom_instance = Boom.instance()
	Boom_instance.set_position(global_position)
	$"../../Other/".add_child(Boom_instance)