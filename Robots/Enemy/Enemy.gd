extends KinematicBody2D

export var Bullet : PackedScene

var r = 25
var offset = 0
onready var player = $"../Position/Player"

func _ready():
	pass
	
#это херота, ее надо переделать. 
#закос под босса отстреливающего в разные стороны
func danmaku():
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
