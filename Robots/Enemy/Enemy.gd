extends KinematicBody2D

export var Bullet : PackedScene

onready var player = get_node("../../Position/Player")

var current_health
var speed = 40
var velocity = Vector2()
var shooting = false
var radius = 55

func _ready():
	randomize()
	current_health = 66 #round(rand_range(60, 66))
	
#это херота, ее надо переделать. 
#закос под босса отстреливающего в разные стороны
func danmaku():
	if shooting:
		var angle_dir = get_angle_to(player.global_transform.origin)
			
		for i in range(5):
			var x = radius * cos(angle_dir) + position.x
			var y = radius * sin(angle_dir) + position.y
			
			var bullet = Bullet.instance()
			if get_parent().name == "SpawnEnemy":
				bullet.set_collision_mask_bit(2, false)
			get_parent().add_child(bullet)
			bullet.start(Vector2(x, y), angle_dir + (i / PI) - 0.6)

#если пуля попала, вызывается этот метод
func hit() -> void:
	$Popup.visible = true
	$Popup.heal(-1)
	$Timer.start()
	current_health -= 1
	
	#если число жизни равно ZERO - удаляем объект
	if current_health == 0:
		queue_free()

func _physics_process(delta):
	#вычисляем нормаль - направление в сторону игрока
	var target_dir = (player.global_position - global_position).normalized()
	#дистанцию до игрока
	var target_dis = position.distance_to(player.global_position)
	if target_dis > 300 and target_dis < 700:
		#двигаем игрока
		velocity = target_dir * speed * delta
		move_and_collide(velocity)

func _on_Tic_timeout():
	danmaku()

func _on_VisibilityNotifier2D_screen_exited():
	shooting = false

func _on_VisibilityNotifier2D_screen_entered():
	shooting = true

func _on_Timer_timeout():
	$Popup.visible = false
