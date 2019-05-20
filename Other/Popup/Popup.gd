extends Node2D

var new_health
var current_health = 0
var max_health = 6
var health = 6

func _ready():
	$Progress.value = health
	
func heal(amount):
	health += amount
	health = min(health, max_health)
	healthf(health)

func healthf(new_health):
	#анимируем прогрессбар жизни
	animate_value(current_health, new_health)
	#новое значение текщей жизни
	current_health = new_health
	
func animate_value(start, end):
	$Tween.interpolate_property($Progress, "value", start, end, 0.2, $Tween.EASE_IN, $Tween.EASE_OUT)
	$Tween.start()
