extends KinematicBody2D

export var Bullet : PackedScene

var pi = 3.14
var r = 25

func _ready():
	pass # Replace with function body.
	
func danmaku():
	for i in range(10):
		var y = r * cos(i * randi() % 180 / pi)
		var x = r * sin(i * randi() % 180 / pi)
				
		var bullet = Bullet.instance()
		get_parent().add_child(bullet)
		bullet.start(Vector2( x + position.x , y + position.y ), rand_range(0, 360) * i) 

func _on_Tic_timeout():
	 danmaku()
