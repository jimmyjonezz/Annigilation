extends KinematicBody2D

export var Bullet : PackedScene

onready var player = get_node("../../Position/Player")

var current_health = 66
var speed = 40
var velocity = Vector2()
var shooting = false
var radius = 55

func _ready():
	randomize()
	$Popup.scale.x = 2.2
	$Popup/Progress.max_value = current_health
	$Popup/Progress.value = current_health
	$Popup.max_health = current_health
	$Popup.health = current_health
	
#это херота, ее надо переделать. 
#закос под босса отстреливающего в разные стороны
func danmaku():
	if shooting:
		var angle_dir = get_angle_to(player.global_transform.origin)
			
		for i in range(5):
			var x = radius * cos(angle_dir) + position.x
			var y = radius * sin(angle_dir) + position.y
			
			var bullet = Bullet.instance()
			get_parent().add_child(bullet)
			$Boom.play()
			bullet.start(Vector2(x, y), angle_dir + (i / PI) - 0.65)

#если пуля попала, вызывается этот метод
func hit() -> void:
	$Popup.visible = true
	$Popup.heal(-1)
	$Timer.start()
	current_health -= 1
	
	#если число жизни равно ZERO - удаляем объект
	if current_health == 0:
		$"../../GUI".take_score(30)
		queue_free()
		$"../../".for_boss()

func _physics_process(delta):
	#вычисляем нормаль - направление в сторону игрока
	var target_dir = (player.global_position - global_position).normalized()
	#дистанцию до игрока
	var target_dis = position.distance_to(player.global_position)
	if target_dis > 300 and target_dis < 700:
		#двигаем enemy
		$APlayer.play("walk")
		velocity = target_dir * speed * delta
		move_and_collide(velocity)
	else:
		$APlayer.play("idle")

func _on_Tic_timeout():
	var target_dis = position.distance_to(player.global_position)
	if target_dis < 1600:
		danmaku()
		$APlayer.play("shoot")

func _on_VisibilityNotifier2D_screen_exited():
	shooting = false

func _on_VisibilityNotifier2D_screen_entered():
	shooting = true

func _on_Timer_timeout():
	$Popup.visible = false