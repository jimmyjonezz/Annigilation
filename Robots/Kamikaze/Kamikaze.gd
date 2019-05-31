extends KinematicBody2D

class_name Kamikaze

export var Ammo : PackedScene

var speed
var path : = PoolVector2Array() setget set_path
var velocity = Vector2()
var current_health = 9

func _ready():
	randomize()
	speed = rand_range(165, 175)
	
func set_path(value: PoolVector2Array) -> void:
	path = value
	if path.size() == 0:
		return
	set_process(true)
	
func _physics_process(delta) -> void:
	var new_path = get_node("../../World/Navigation").get_simple_path(
			position, get_node("../../Position/Player").position, false)
	new_path.remove(0)
	if new_path.size() > 1:
		path = new_path
	
	if path.size() > 1:
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
		$APlayer.play("idle")
		
func hit() -> void:
	$Popup.visible = true
	current_health -= 1
	$Popup.heal(-1)
	$Timer.start()
	
	if current_health <= 0:
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
