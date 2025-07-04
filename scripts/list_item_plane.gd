extends Control

@export var sprite: Texture

@export var plane: Dictionary

func _ready():
	$plane.texture = sprite
	$name.text = plane.name
	var cost_string
	if plane.cost > 1000000:
		cost_string = str(plane.cost/1000000) + " million"
	$cost.text = cost_string
	$range.text = "RANGE: " + str(plane.maxRange)

func _on_buy_button_up():
	Global.save_file.planes.append(plane)
	Global.save(Global.save_file)
