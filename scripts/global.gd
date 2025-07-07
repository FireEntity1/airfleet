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
		"registration": "C-XXXX",
		"cost": 20000000,
		"capacity": 75,
		"maxRange": 1000,
		"type": "Turboprop Short-Haul",
		"speed": 270,
		"condition": 100,
		"efficiency": 0.7,
		"route": ["XXX","XXX"],
		"status": "onground",
		"upgrades": {
			"wifi": false,
			"ife_screens": false,
			"first_class": false,
			},
	},
	
	{
		"id": "bsc3",
		"name": "Airbus A220",
		"registration": "C-XXXX",
		"cost": 90000000,
		"capacity": 100,
		"maxRange": 4000,
		"type": "Jet Short-Haul",
		"speed": 490,
		"condition": 100,
		"efficiency": 0.9,
		"route": ["XXX","XXX"],
		"status": "onground",
		"upgrades": {
			"wifi": false,
			"ife_screens": false,
			"first_class": false,
			},
	},
	
	{
		"id": "a338",
		"name": "Airbus A330-800neo",
		"registration": "C-XXXX",
		"cost": 300000000,
		"capacity": 280,
		"maxRange": 8150,
		"type": "Jet Medium-Haul",
		"speed": 520,
		"condition": 100,
		"efficiency": 1.0,
		"route": ["XXX","XXX"],
		"status": "onground",
		"upgrades": {
			"wifi": false,
			"ife_screens": false,
			"first_class": false,
			},
	},
	
	{
		"id": "a359",
		"name": "Airbus A350-1000ULR",
		"registration": "C-XXXX",
		"cost": 380000000,
		"capacity": 400,
		"maxRange": 9700,
		"type": "Jet Long-Haul",
		"speed": 570,
		"condition": 100,
		"efficiency": 1.2,
		"route": ["XXX","XXX"],
		"status": "onground",
		"upgrades": {
			"wifi": false,
			"ife_screens": false,
			"first_class": false,
			},
	}
]

const AIRPORTS = [
	{
		"code": "YYC",
		"name": "Calgary Int'l",
		"type": "hub",
		"fee": 0,
		"demand": { "intl": 0.7, "dom": 1.0 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [["YYC", "YVR"]],
		"unlocked": true,
		"distance": { "YYC": 0, "YVR": 540, "YYZ": 1700 },
	},
	{
		"code": "YVR",
		"name": "Vancouver Int'l",
		"type": "domestic",
		"fee": 10000,
		"demand": { "intl": 1.0, "dom": 1.0 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": ["YVR-YYC"],
		"unlocked": true,
		"distance": { "YYC": 540, "YVR": 0, "YYZ": 2100 },
	},
	{
		"code": "YYZ",
		"name": "Toronto Pearson Int'l",
		"type": "domestic",
		"fee": 20000,
		"demand": { "intl": 1.1, "dom": 1.0 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 1700, "YVR": 2100, "YYZ": 0 },
	},
	{
		"code": "SFO",
		"name": "San Francisco Int'l",
		"type": "international",
		"fee": 30000,
		"demand": { "intl": 1.2, "dom": 0.9 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 1100, "YVR": 900, "YYZ": 2200 },
	},
	{
		"code": "LAX",
		"name": "Los Angeles Int'l",
		"type": "international",
		"fee": 50000,
		"demand": { "intl": 1.4, "dom": 1 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 1200, "YVR": 1100, "YYZ": 2300 },
	},
	{
		"code": "JFK",
		"name": "John F. Kennedy Int'l",
		"type": "international",
		"fee": 80000,
		"demand": { "intl": 1.5, "dom": 1.2 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 2100, "YVR": 2500, "YYZ": 400 },
	},
	{
		"code": "MEX",
		"name": "Mexico City Int'l",
		"type": "international",
		"fee": 80000,
		"demand": { "intl": 1.5, "dom": 1 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 2500, "YVR": 2300, "YYZ": 2100 },
	},
	{
		"code": "LHR",
		"name": "London Heathrow",
		"type": "international",
		"fee": 140000,
		"demand": { "intl": 1.6, "dom": 1 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 3800, "YVR": 4400, "YYZ": 3600 },
	},
	{
		"code": "ZRH",
		"name": "Zürich Int'l",
		"type": "international",
		"fee": 100000,
		"demand": { "intl": 1.6, "dom": 1 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 4100, "YVR": 4700, "YYZ": 3900 },
	},
	{
		"code": "FRA",
		"name": "Frankfurt Int'l",
		"type": "international",
		"fee": 120000,
		"demand": { "intl": 1.6, "dom": 1 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 4000, "YVR": 4600, "YYZ": 3800 },
	},
	{
		"code": "SIN",
		"name": "Singapore Int'l",
		"type": "international",
		"fee": 140000,
		"demand": { "intl": 1.7, "dom": 1 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 7100, "YVR": 7700, "YYZ": 8200 },
	},
]

const ICONS = {
	"locked": preload("res://sprites/locked.png"),
	"unlocked": preload("res://sprites/unlocked.png")
}

var file

var save_file = {}

var used_registrations = ["C-GHDF"]

const BASE_SAVE_FILE = {
			"planes": [PLANES[0]],
			"airports": AIRPORTS
		}

func _ready():
	if not FileAccess.file_exists("user://airfleet.save"):
		save_file = BASE_SAVE_FILE.duplicate(true)
		save_file.planes[0].registration = "C-GHDF"
		save(save_file)
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

func generate_registration():
	var reg = "C-"
	while true:
		for i in range(4):
			reg += char(randi_range(65,90))
		for registration in used_registrations:
			if registration == reg:
				reg = "C-"
		used_registrations.append(reg)
		return reg

func get_distance(route) -> int:
	var destination = AIRPORTS[route[1]]
	var distance = destination.distance[route[0]]
	return distance
	
