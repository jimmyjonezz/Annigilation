	func _process(delta):
	sweep_box = Rect2(global_position - sweep_box_size/2, sweep_box_size)   

    for i in get_tree().get_nodes_in_group("bullet"):
        if sweep_box.has_point(i.global_position):
		# We first create a sweepbox to filter out bullets too far away
            var distance_squared = global_position.distance_squared_to(i.global_position)
            
            if distance_squared < pow(radius+i.radius, 2):
			# This tells us if the bullet is closer than the sum of the radii
                die()   
						
	#bad simple knock		
	if value.position.x > position.x:
		position.x -= 10
	if value.position.x < position.x:
		position.x += 10
	if value.position.y > position.y:
		position.y -= 10
	if value.position.x < position.x:
		position.y += 10
		
	#knockback
	func _physics_process(delta):
	var overlapping_bodies = $hitbox.get_overlapping_bodies()
	if not overlapping_bodies:
		return
	for body in overlapping_bodies:
		if body.is_in_group("bullet"):
			call_deferred("call_body", body)
		
	func call_body(value):
		knockdir = (value.transform.origin - self.transform.origin)
		print(knockdir)
		print(position)
		print(position - knockdir)
		velocity = move_and_collide(position - knockdir)
		
		
	#rand spawn props	
	var rnd = randi() % 4
	match rnd:
		0:
			return
		1: 
			#патроны
			var Ammo_instance = Ammo.instance()
			Ammo_instance.set_position(global_position)
			$"../../SpawnProps/".add_child(Ammo_instance)
		2, 3: 
			#аптечка
			var Firstkit_instance = Firstkit.instance()
			Firstkit_instance.set_position(global_position)
			$"../../SpawnProps/".add_child(Firstkit_instance)
			
			
БЫЛА в MAIN:
#находим сам путь
func new_path_for_enemy() -> void:
	var get_pos = get_node("Position/Player").position
	var get_enemy = get_node("SpawnEnemy").get_child_count()
	#print("get_enemy: %s" % get_enemy)
	if get_enemy:
		for x in range(get_enemy):
			#print("child position: %s" % get_node("SpawnEnemy").get_child(x).position)
			var new_path = get_node("World/Navigation").get_simple_path(
					get_node("SpawnEnemy").get_child(x).position, 
					get_pos, true)
			new_path.remove(0)
			if new_path.size() > 1:
				get_node("SpawnEnemy").get_child(x).path = new_path