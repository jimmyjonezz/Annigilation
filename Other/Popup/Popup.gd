extends Node2D

export var max_health = 0
var health = 0

func _ready():
	if get_parent().name == "Enemy":
		max_health = 66
		$Progress.max_value = max_health
		health = max_health
	else:
		max_health = 9
		$Progress.max_value = max_health
		health = max_health
	
func heal(amount):
	health += amount
	health = min(health, max_health)
	healthf(health)

func healthf(new_health):
	#анимируем прогрессбар жизни
	animate_value(health, new_health)
	#новое значение текщей жизни
	health = new_health
	
func animate_value(start, end):
	$Tween.interpolate_property($Progress, "value", start, end, 0.2, $Tween.EASE_IN, $Tween.EASE_OUT)
	$Tween.start()
