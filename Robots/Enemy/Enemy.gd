extends KinematicBody2D

export var Bullet : PackedScene

var r = 25
var offset = 0
onready var player = $"../Position/Player"

var current_health

func _ready():
	randomize()
	current_health = round(rand_range(4, 10))
	
#это херота, ее надо переделать. 
#закос под босса отстреливающего в разные стороны
func danmaku():
	#var global_t = get_global_transform()
	for i in range(13):
		var angle = (PI * 2) / 13 * i + offset
		var y = r * cos(randi() % 180 / PI)#r * cos(i * randi() % 180 / pi)
		var x = r * cos(randi() % 180 / PI)#r * sin(i + randi() % 180 / pi)
				
		var bullet = Bullet.instance()
		get_parent().add_child(bullet)
		bullet.start(Vector2(position.x + x, position.y + y), angle) 

func _on_Tic_timeout():
	#вычисляем дистанцию до игрока и стреляем
	if position.distance_to(player.position) < 250:
		danmaku()

func hit() -> void:
	#var global_t = get_global_transform()
	current_health -= 1
	
	if current_health == 0:
		queue_free()
