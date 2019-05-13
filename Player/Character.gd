extends KinematicBody2D

class_name Character

export (int) var speed = 80
var velocity = Vector2()
var is_reload = true
var is_shooting = false

func direction():
	if position < get_global_mouse_position():
		$Sprite.flip_h = true
		$Gun.flip_v = false
	else:
		$Sprite.flip_h = false
		$Gun.flip_v = true
	
	$Gun.look_at(get_global_mouse_position())

func get_input():
	if Input.is_action_pressed("ui_mouse_left") and $Shooting.is_stopped():
		if is_reload:
			is_shooting = true
	
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
		
	if velocity.length() > 0:
		$APlayer.play("walk")
	else:
		$APlayer.play("idle")