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
	Global.save(Global.BASE_SAVE_FILE)
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
	
	print(plane.registration + " is flying " + plane.route[0] + " to " + plane.route[1] + " time " + str(time_secs))
	await get_tree().create_timer(time_secs).timeout
	for plane_save in Global.save_file.planes:
		if plane.registration == plane_save.registration:
			plane_save.status = "onground"
			Global.save(Global.save_file)
			break
	print(plane.registration + " has landed from route: " + plane.route[0] + " to " + plane.route[1])
	Global.save_file.money += money
	Global.save(Global.save_file)
	print(money)

func _on_update_timeout():
	for child in $tabs/Flying/container.get_children():
		$tabs/Flying/container.remove_child(child)
		child.queue_free()
	for plane in Global.save_file.planes:
			var label = Label.new()
			label.text = plane.registration + " is " + plane.status
			$tabs/Flying/container.add_child(label)
	$money.text = "$" + str(Global.save_file.money)
