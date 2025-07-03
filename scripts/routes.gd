extends Control

var from = 0
var to = 1

var possible_routes

func _ready():
	for airport in Global.save_file.airports:
		if airport.type == "domestic" or airport.type == "hub":
			$from.add_item(airport.code)
			$from.select(0)
	$to.clear()
	var airports = Global.save_file.airports
	possible_routes = []
	for airport in airports:
		if not airport.code == airports[0].code:
			possible_routes.append(airport.code)
	for item in possible_routes:
		$to.add_item(item)

func _process(delta):
	pass

func _on_from_item_selected(index):
	$to.clear()
	from = index
	var airports = Global.save_file.airports
	possible_routes = []
	for airport in airports:
		if not airport.code == airports[index].code:
			possible_routes.append(airport.code)
	for item in possible_routes:
		$to.add_item(item)

func _on_to_item_selected(index):
	var code = possible_routes[index]
	var airport = {}
	for airport_test in Global.save_file.airports:
		if airport_test.code == code:
			airport = airport_test
			print("From: " + Global.save_file.airports[from].name + " To: " + airport.name)
			update(Global.save_file.airports[from], airport)

func get_planes(route):
	var plane_list = Global.save_file.planes
	for plane in plane_list:
		pass

func update(origin,destination):
	var distance = 0
	var planes_available = []
	distance = destination.distance[origin.code]
	$distance.text = "Distance: " + str(distance) + "NMi"
	for plane in Global.save_file.planes:
		if distance < plane.max_range:
			pass
