extends KinematicBody2D

var total_health = 320
var shooting = false
var radius = 130

export var Bullet : PackedScene
export var Boom : PackedScene
onready var player = get_node("../../Position/Player")

func hit() -> void:
	$"../../GUI/HealthBar".visible = true
	total_health -= 1
	$"../../GUI"._in_Boss(total_health)
	
	#если число жизни равно ZERO - удаляем объект
	if total_health == 0:
		$"../../Position/Player/Camera2D/screenshake".start()
		spawn_boom()
		$"../../GUI".take_score(30)
		queue_free()
		$"../../GUI".victory()

func danmaku():
	if shooting:
		var angle_dir = get_angle_to(player.global_transform.origin)
			
		for i in range(8):
			var bx = radius * cos(angle_dir + rand_range(0.5, 1)) + position.x
			var by = radius * sin(angle_dir + rand_range(0.5, 1)) + position.y
			
			var bullet = Bullet.instance()
			get_parent().add_child(bullet)
			bullet.start(Vector2(bx, by), angle_dir + (PI / 20 * i) - 0.38)
			yield(get_tree().create_timer(0.1), "timeout")

func _on_Timer_timeout():
	danmaku()
	$CollisionShape2D.rotate(deg2rad(45))

func _on_VisibilityNotifier2D_screen_entered():
	shooting = true

func _on_VisibilityNotifier2D_screen_exited():
	shooting = false
	
func spawn_boom():
	var Boom_instance = Boom.instance()
	Boom_instance.set_position(global_position)
	$"../../Other/".add_child(Boom_instance)
