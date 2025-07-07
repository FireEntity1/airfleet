extends Control

var save_data

func _ready():
	save_data = Global.save_file
	for plane in Global.PLANES:
		var scene = preload("res://components/list_item_plane.tscn").instantiate()
		scene.plane = plane
		scene.sprite = load("res://sprites/temp_plane.png")
		$tabs/shop/planes.add_child(scene)

func _process(delta):
	for plane in Global.save_file.planes:
		if plane.status == "onground" and plane.route[0] != "XXX":
			fly(plane)
			

func _on_reset_button_up():
	Global.save(Global.BASE_SAVE_FILE)

func fly(plane: Dictionary):
	var distance = Global.get_distance(plane.route)
	var time_secs = (distance/plane.speed)/60
	print(time_secs)
