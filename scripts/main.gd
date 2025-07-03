extends Control

var save_data

func _ready():
	save_data = Global.save_file
	for plane in Global.PLANES:
		var scene = preload("res://components/list_item_plane.tscn").instantiate()
		scene.plane = plane
		scene.sprite = load("res://sprites/temp_plane.png")
		$tabs/planes/planes.add_child(scene)

func _process(delta):
	pass
