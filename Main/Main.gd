extends Node

onready var camera = $Position/Player/Camera2D as Camera2D
var shake_amount = 1.0
export var spawn_pos = [Vector2(64, 64), Vector2(750, 100),
		Vector2(64, 550), Vector2(750, 550)]
var pospos = []
export var distance = 300

func new_game():
	randomize()

func _ready():
	set_camera_limits()
	new_game()
	$GUI/GUI/time.text = "05 : 00"
	$GUI/GUI/score.text = "00000"
	
func set_camera_limits() -> void:
	var map_limits = get_node("World/Navigation").get_child(0).get_used_rect()
	var map_cellsize = get_node("World/Navigation").get_child(0).cell_size.round()
	
	camera.limit_left = 0
	camera.limit_right = map_limits.end.x * map_cellsize.x
	camera.limit_top = map_limits.position.y * map_cellsize.y
	camera.limit_bottom = map_limits.end.y * map_cellsize.y
	
func shake():
	camera.set_offset(Vector2(rand_range(-1.0, 1.0) * shake_amount, 
			rand_range(-1.0, 1.0) * shake_amount))
	yield(get_tree().create_timer(10.2), "timeout")
	camera.set_offset(Vector2(0,0))
	
func spawn_enemy() -> void:
	var Enemy_instance = $"/root/GL".Enemy.instance()
	
	#нужно переработать!!!!
	#подобрать дистанцию для спавна enemy с ближайшей точки
	pospos.clear()
	for x in range(spawn_pos.size()):
		pospos.append($Position/PLayer.position.distance_to(spawn_pos[x]))
	
	for i in range(pospos.size()):
		if pospos[i] < distance:
			Enemy_instance.position = spawn_pos[i]
		#elif pospos[i] > distance:  #<-переделать!
		#	return
	
	get_node("SpawnEnemy").add_child(Enemy_instance)
	var new_path = get_node("World/Navigation").get_simple_path(
			Enemy_instance.position, 
			$Position/PLayer.position)
	Enemy_instance.path = new_path

func new_path_for_enemy() -> void:
	var get_enemy = get_node("SpawnEnemy").get_child_count()
	if get_enemy:
		print("count enemy: %s" % get_enemy)
		for x in range(get_enemy):
			var new_path = get_node("World/Navigation").get_simple_path(
					get_node("SpawnEnemy").get_child(x).position, 
					$Position/PLayer.position, false)
			new_path.remove(0)
			if new_path.size() > 1:
				get_node("SpawnEnemy").get_child(x).path = new_path

# warning-ignore:unused_argument
func _process(delta) -> void:
	new_path_for_enemy()