extends KinematicBody2D

class_name Character

signal paused

#переменные: скорость передвижения, вектор направления, перезарядка и стрельба
export (int) var speed = 80
var velocity = Vector2()
var is_reload = true
var is_shooting = false

func pos():
	return self.position

#спрайт у Игрока зеркалим и ган тоже (вертикально)
func direction():
	if position < get_global_mouse_position():
		$Sprite.flip_h = true
		$Gun.flip_v = false
	else:
		$Sprite.flip_h = false
		$Gun.flip_v = true
	
	#вертим ган взяв за основу позицию мыши
	$Gun.look_at(get_global_mouse_position())

func get_input():
	#пауза + сигналим другой ноде (GUI)
	if Input.is_action_just_pressed("ui_cancel"):
		emit_signal("paused")
		get_tree().set_pause(true)
	
	#если нажата левая клавиша и остановлен таймер стрельбы то...
	if Input.is_action_pressed("ui_mouse_left") and $Shooting.is_stopped():
		if is_reload:
			is_shooting = true
	
	#клавиши управления наше все
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	#вместо конечного автомата: анимация покоя и бега
	if velocity.length() > 0:
		$APlayer.play("walk")
	else:
		$APlayer.play("idle")