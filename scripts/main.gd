extends Control

var save_data

func _ready():
	save_data = Global.save_file
	for plane in save_data.planes:
		var label = Label.new()
		label.text = plane.name
		$tabs/planes.add_child(label)

func _process(delta):
	pass
