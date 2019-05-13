extends Node

onready var camera = $Position/Player/Camera2D as Camera2D
var shake_amount = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_camera_limits()
	shake()
	
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