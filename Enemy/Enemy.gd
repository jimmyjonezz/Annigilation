extends KinematicBody2D

export var Bullet : PackedScene

var pi = 3.14
var r = 25

func _ready():
	pass # Replace with function body.
	
func danmaku():
	for i in range(3):
		var y = r * cos(randi() % 180 / pi)#r * cos(i * randi() % 180 / pi)
		var x = r * cos(randi() % 180 / pi)#r * sin(i + randi() % 180 / pi)
				
		var bullet = Bullet.instance()
		get_parent().add_child(bullet)
		bullet.start(Vector2(position.x + x, position.y + y), 0) 

func _on_Tic_timeout():
	 danmaku()
