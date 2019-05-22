extends KinematicBody2D

export var Bullet : PackedScene

onready var player = get_node("../../Position/Player")

var current_health

func _ready():
	randomize()
	current_health = round(rand_range(15, 20))
	
#это херота, ее надо переделать. 
#закос под босса отстреливающего в разные стороны
func danmaku():
	#var global_t = get_global_transform()
	
	for i in range(6):
		#угол между игроком и enemy
		var angle_dir = get_angle_to(player.global_transform.origin)
		
		var bullet = Bullet.instance()
		get_parent().add_child(bullet)
		bullet.start(Vector2(position.x, position.y), angle_dir + sin(i) / PI)

func hit() -> void:
	#var global_t = get_global_transform()
	current_health -= 1
	
	if current_health == 0:
		queue_free()

func _process(delta):
	pass

func _on_Tic_timeout():
	danmaku()
