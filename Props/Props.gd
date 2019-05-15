extends KinematicBody2D

func _ready():
	pass # Replace with function body.

func hit():
	pass
	
func _spawn_props():
	var rnd = randi() % 4
	match rnd:
		0:
			return
		1, 2: 
			#патроны
			var Ammo_instance = $"/root/GL"
			Ammo_instance.set_position(global_position)
			$"../../SpawnProps/".add_child(Ammo_instance)
		3: 
			#аптечка
			var Map_Props = $"/root/GL"
			Map_Props.set_position(global_position)
			$"../../SpawnProps/".add_child(Map_Props)
