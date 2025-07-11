extends Control

@export var title: String
@export var description: String
@export var options: Array

func _ready():
	$popup.title = title
	$popup/container/message.text = description
	$popup.popup_centered()
