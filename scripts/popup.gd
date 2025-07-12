extends Control

@export var title: String
@export var description: String
@export var options: Array
@export var id: String

func _ready():
	$popup.title = title
	$popup/container/message.text = description
	$popup.popup_centered()
	for option in options:
		var button = Button.new()
		button.text = option
		button.pressed.connect(_on_option_selected.bind(option))
		button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		button.size_flags_vertical = Control.SIZE_EXPAND_FILL
		$popup/container.add_child(button)

func _on_option_selected(option_text: String):
	if option_text == "Ok":
		$popup.hide()
		queue_free()
