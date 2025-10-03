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
		"id": "bcs3",
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
		"name": "Airbus A350-900ULR",
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
		"slots_used": 1,
	},
	{
		"code": "YVR",
		"name": "Vancouver Int'l",
		"type": "domestic",
		"fee": 1000,
		"demand": { "intl": 1.0, "dom": 1.0 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": ["YVR-YYC"],
		"unlocked": true,
		"distance": { "YYC": 540, "YVR": 0, "YYZ": 2100 },
		"slots_used": 1,
	},
	{
		"code": "YYZ",
		"name": "Toronto Pearson Int'l",
		"type": "domestic",
		"fee": 5000,
		"demand": { "intl": 1.1, "dom": 1.0 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 1700, "YVR": 2100, "YYZ": 0 },
		"slots_used": 0,
	},
	{
		"code": "SFO",
		"name": "San Francisco Int'l",
		"type": "international",
		"fee": 15000,
		"demand": { "intl": 1.2, "dom": 0.9 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 1100, "YVR": 900, "YYZ": 2200 },
		"slots_used": 0,
	},
	{
		"code": "LAX",
		"name": "Los Angeles Int'l",
		"type": "international",
		"fee": 30000,
		"demand": { "intl": 1.4, "dom": 1 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 1200, "YVR": 1100, "YYZ": 2300 },
		"slots_used": 0,
	},
	{
		"code": "JFK",
		"name": "John F. Kennedy Int'l",
		"type": "international",
		"fee": 50000,
		"demand": { "intl": 1.5, "dom": 1.2 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 2100, "YVR": 2500, "YYZ": 400 },
		"slots_used": 0,
	},
	{
		"code": "MEX",
		"name": "Mexico City Int'l",
		"type": "international",
		"fee": 50000,
		"demand": { "intl": 1.5, "dom": 1 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 2500, "YVR": 2300, "YYZ": 2100 },
		"slots_used": 0,
	},
	{
		"code": "LHR",
		"name": "London Heathrow",
		"type": "international",
		"fee": 40000,
		"demand": { "intl": 1.6, "dom": 1 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 3800, "YVR": 4400, "YYZ": 3600 },
		"slots_used": 0,
	},
	{
		"code": "ZRH",
		"name": "Zürich Int'l",
		"type": "international",
		"fee": 30000,
		"demand": { "intl": 1.6, "dom": 1 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 4100, "YVR": 4700, "YYZ": 3900 },
		"slots_used": 0,
	},
	{
		"code": "FRA",
		"name": "Frankfurt Int'l",
		"type": "international",
		"fee": 40000,
		"demand": { "intl": 1.6, "dom": 1 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 4000, "YVR": 4600, "YYZ": 3800 },
		"slots_used": 0,
	},
	{
		"code": "SIN",
		"name": "Singapore Int'l",
		"type": "international",
		"fee": 50000,
		"demand": { "intl": 1.7, "dom": 1 },
		"upgrades": { "lounge": false, "eco_fuel": false, "jetbridges": false },
		"connected_routes": [],
		"unlocked": false,
		"distance": { "YYC": 7100, "YVR": 7700, "YYZ": 8200 },
		"slots_used": 0,
	},
]

const ICONS = {
	"locked": preload("res://sprites/locked.png"),
	"unlocked": preload("res://sprites/unlocked.png")
}

var file

var save_file = {}

const EVENTS = [
	{
		"name": "Secondhand Aircraft for Sale",
		"id": "plane_sale",
		"description": "An airline is selling one of its aircraft! Would you like to purchase it?",
		"outcomes": ["Purchase", "No"]
	},
	{
		"name": "Domestic Tourism Boom!",
		"id": "domestic_boom",
		"description": "ALl domestic flights between YVR, YYC, and YYZ have increased demand",
		"outcomes": ["Ok"]
	},
]

var used_registrations = ["C-XXXX"]

func _ready():
	if not FileAccess.file_exists("user://airfleet.save"):
		save_file = {
			"planes": [PLANES[0].duplicate(true), PLANES[1].duplicate(true)],
			"airports": AIRPORTS.duplicate(true),
			"money": 10000000,
			"total_profit": 10000000,
			"initial_completed": false,
			"active_events": []
		}
		
		for plane in save_file.planes:
			plane.registration = generate_registration()
			if plane.id == "dhc4":
				plane.route = ["YYC", "YVR"]
			elif plane.id == "bcs3":
				plane.route = ["YYC", "YYZ"]
		save(save_file)
	else:
		load_save()

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
	else:
		reset()

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

func get_distance(route: Array) -> int:
	var destination
	for airport in save_file.airports:
		if airport.code == route[1]:
			destination = airport
	var distance = destination.distance[route[0]]
	return distance

func calculate_payout(plane: Dictionary):
	var pax = int(plane.capacity*randf_range(0.7,1.0))
	var distance = get_distance(plane.route)
	var per_pax = 100 + (distance/2)
	var subtotal = pax * per_pax
	var mult = 1.0
	var airport = {}
	for _airport in save_file.airports:
		if _airport.code == plane.route[1]:
			airport = _airport
			break
	var slots = airport.slots_used
	if slots > 5:
		mult -= ((slots-5)+0.1)
		mult = clamp(mult,0.5,999)
	var fee = airport.fee
	if airport.upgrades.lounge:
		mult += 0.2
	if airport.upgrades.jetbridges:
		mult += 0.1
	if airport.upgrades.eco_fuel:
		fee = fee/2
	subtotal = (subtotal * mult) - fee
	print(plane.id + ", $" + str(subtotal))
	return subtotal

func add_money(money: int):
	save_file.money += money
	#save_file.total_profit += money
	save(save_file)

func remove_money(cost: int):
	save_file.money -= cost
	save(save_file)

func trigger_event(id):
	var event_data = null
	for event in EVENTS:
		if event.id == id:
			event_data = event
			break
	return event_data

func reset():
	save_file = {
			"planes": [PLANES[0].duplicate(true), PLANES[1].duplicate(true)],
			"airports": AIRPORTS.duplicate(true),
			"money": 1000000,
			"total_profit": 1000000,
			"initial_completed": false,
			"active_events": []
		}
		
	for plane in save_file.planes:
		plane.registration = generate_registration()
		if plane.id == "dhc4":
			plane.route = ["YYC", "YVR"]
		elif plane.id == "bcs3":
			plane.route = ["YYC", "YYZ"]
	save(save_file)
	load_save()
