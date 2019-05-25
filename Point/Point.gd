extends Position2D

export var Point : PackedScene

func _ready():
	randomize()
	
func _spawn_enemy():
	var rnd = randi() % 4
	for x in range(rnd):
		var Point_instance = Point .instance()
		Point_instance.set_position(global_position)
		$"../../SpawnEnemy/".add_child(Point_instance)