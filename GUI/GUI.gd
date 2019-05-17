extends CanvasLayer

var time_start
var time_now = 0

func _ready():
	time_start = 300 #1140 = 19 минут
	
func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		$Pause.visible = new_pause_state

#таймер обратного отсчета
func timer():
	if get_tree().paused == false:
		time_now += 1
		var elapsed = time_start - time_now
		var minutes = elapsed / 60
		var seconds = elapsed % 60
		var str_elapsed = "%02d : %02d" % [minutes, seconds]
		$GUI/time.text = str_elapsed
	
		if elapsed <= 0:
			$Gameover.visible = true
			get_tree().paused = true

func _on_Tic_timeout():
	timer()

func _on_Restart_pressed():
	get_tree().reload_current_scene()
	get_tree().set_pause(false)

func _on_Exit_pressed():
	get_tree().quit()

func _on_Player_paused():
	$Pause.visible = true

func _on_Continue_pressed():
	get_tree().set_pause(false)
	$Pause.visible = false
