extends Node

const PLANES = [
	
	# 0 - dash 8
	# 1 - a220
	# 2 - a330
	# 3 - a350
	
	# UNITS!!!
	# i don wna put it in the key names to keep it clean
	# -----------
	# range NMi
	# speed KTS
	# capacity PAX
	# efficiency %
	# efficiency X multiplier
	# possible statuses: onground, flying, grounded
	
	{
		"id": "dhc4",
		"name": "De Havilland Dash 8-400",
		"capacity": 75,
		"maxRange": 1102,
		"type": "Turboprop Short-Haul",
		"speed": 270,
		"condition": 100,
		"efficiency": 0.7,
		"route": "XXX-XXX",
		"status": "onground",
	},
	
	{
		"id": "bsc3",
		"name": "Airbus A220",
		"capacity": 100,
		"maxRange": 4000,
		"type": "Jet Short-Haul",
		"speed": 490,
		"condition": 100,
		"efficiency": 0.9,
		"route": "XXX-XXX",
		"status": "onground",
	},
	
	{
		"id": "a338",
		"name": "Airbus A330-800neo",
		"capacity": 280,
		"maxRange": 8150,
		"type": "Jet Medium-Haul",
		"speed": 520,
		"condition": 100,
		"efficiency": 1.0,
		"route": "XXX-XXX",
		"status": "onground",
	},
	
	{
		"id": "a359",
		"name": "Airbus A350-1000ULR",
		"capacity": 400,
		"maxRange": 9700,
		"type": "Jet Long-Haul",
		"speed": 570,
		"condition": 100,
		"efficiency": 1.2,
		"route": "XXX-XXX",
		"status": "onground",
	}
]



var file

var save_file = {}

func _ready():
	if not FileAccess.file_exists("user://airfleet.save"):
		save_file = {
			"planes": [PLANES[0].duplicate(true)]
		}
	else:
		load_save()

func _process(delta):
	pass

func save(data):
	var json = JSON.stringify(data)
	var file = FileAccess.open("user://airfleet.save", FileAccess.WRITE)
	file.store_string(json)
	file.close()

func load_save():
	if FileAccess.file_exists("user://airfleet.save"):
		var file = FileAccess.open("user://airfleet.save", FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		save_file = JSON.parse_string(content)
