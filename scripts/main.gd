extends Control

var save_data

func _ready():
	save_data = Global.save_file
	for plane in Global.PLANES:
		var scene = preload("res://components/list_item_plane.tscn").instantiate()
		scene.plane = plane
		scene.sprite = load("res://sprites/temp_plane.png")
		$tabs/Shop/planes.add_child(scene)
	for plane in Global.save_file.planes:
		if plane.status == "flying":
			plane.status = "onground"

func _process(delta):
	for plane in Global.save_file.planes:
		if plane.status == "onground" and plane.route[0] != "XXX":
			fly(plane)

func _on_reset_button_up():
	DirAccess.remove_absolute("user://airfleet.save")
	get_tree().reload_current_scene()
	Global.load_save()

func fly(plane: Dictionary):
	var distance = Global.get_distance(plane.route)
	var time_secs = (distance/plane.speed)
	var money = Global.calculate_payout(plane)
	for plane_save in Global.save_file.planes:
		if plane.registration == plane_save.registration:
			plane_save.status = "flying"
			Global.save(Global.save_file)
			break
	
	#print(plane.registration + " is flying " + plane.route[0] + " to " + plane.route[1] + " time " + str(time_secs))
	await get_tree().create_timer(time_secs).timeout
	for plane_save in Global.save_file.planes:
		if plane.registration == plane_save.registration:
			plane_save.status = "onground"
			Global.save(Global.save_file)
			break
	#print(plane.registration + " has landed from route: " + plane.route[0] + " to " + plane.route[1])
	Global.add_money(money)
	Global.save(Global.save_file)

func _on_update_timeout():
	for child in $tabs/Flying/container/q400.get_children():
		if child.name != "text" and child.name != "line":
			$tabs/Flying/container/q400.remove_child(child)
			child.queue_free()
	for child in $tabs/Flying/container/q400.get_children():
		if child.name != "text" and child.name != "line":
			$tabs/Flying/container/a220.remove_child(child)
			child.queue_free()
	for child in $tabs/Flying/container/q400.get_children():
		if child.name != "text" and child.name != "line":
			$tabs/Flying/container/q400.remove_child(child)
			child.queue_free()
	for child in $tabs/Flying/container/q400.get_children():
		if child.name != "text" and child.name != "line":
			$tabs/Flying/container/q400.remove_child(child)
			child.queue_free()
	for plane in Global.save_file.planes:
			var label = Label.new()
			label.name = plane.registration
			label.text = plane.registration + " is " + plane.status
			match plane.id:
				"dhc4":
					$tabs/Flying/container/q400.add_child(label)
				"bsc3":
					$tabs/Flying/container/a220.add_child(label)
				"a338":
					$tabs/Flying/container/a338.add_child(label)
				"a359":
					$tabs/Flying/container/a350.add_child(label)
	$money.text = "$" + split_num(Global.save_file.money)
	
func split_num(number: int):
	var num = str(number)
	var count = 0
	for i in range(num.length() - 1, -1, -1):
		count += 1
		if count % 3 == 0 and i != 0:
			num = num.insert(i, ",")
	return num

func _on_event_timeout():
	if not Global.save_file.initial_completed:
		var event = Global.trigger_event("domestic_boom")
		if event != null:
			var window = preload("res://components/popup.tscn").instantiate()
			print(event)
			window.id = event.id
			window.title = event.name
			window.description = event.description
			window.options = event.outcomes
			add_child(window)
		$event.wait_time = randi_range(45,85)
