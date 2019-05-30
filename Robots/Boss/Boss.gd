extends KinematicBody2D

var total_health = 220

export var Bullet : PackedScene

func hit() -> void:
	$"../../GUI/HealthBar".visible = true
	total_health -= 1
	
	#если число жизни равно ZERO - удаляем объект
	if total_health == 0:
		$"../../GUI".take_score(30)
		queue_free()