extends KinematicBody2D

#export var Ammo : PackedScene
export var Firstkit : PackedScene

func _ready():
	randomize()

func hit():
	_spawn_props()
	queue_free()
	
func _spawn_props():
	var rnd = randi() % 4
	match rnd:
		0:
			return
		1, 2, 3: 
			#аптечка
			var Firstkit_instance = Firstkit.instance()
			Firstkit_instance.set_position(global_position)
			$"../../SpawnProps/".add_child(Firstkit_instance)
	
	
