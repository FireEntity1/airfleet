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
	update(Global.save_file.airports[from], Global.save_file.airports[to])

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

func get_planes(route: Array, plane_list: Array):
	var available_planes = {
		"checked": [],
		"unchecked": [],
		"other_route": [],
		"grounded": [],
	}
	for plane in plane_list:
		if plane.status != "grounded" and plane.route == route:
			available_planes.checked.append(plane)
		elif plane.status != "grounded" and plane.route[0] == "XXX":
			available_planes.unchecked.append(plane)
		elif plane.status != "grounded" and plane.route != route:
			available_planes.other_route.append(plane)
		elif plane.status == "grounded":
			available_planes.grounded.append(plane)
		
	return available_planes

func update(origin,destination):
	var distance = 0
	var planes_available = []
	distance = destination.distance[origin.code]
	$distance.text = "Distance: " + str(distance) + "NMi"
	for plane in Global.save_file.planes:
		if distance < plane.maxRange:
			planes_available.append(plane)
	var planes_sorted = get_planes([origin,destination], planes_available)
	
	print()
	
	print(str(planes_sorted))
	
	for child in $scroll/planes/checked.get_children():
		$scroll/planes/checked.remove_child(child)
		child.queue_free()
	
	for child in $scroll/planes/unchecked.get_children():
		$scroll/planes/unchecked.remove_child(child)
		child.queue_free()
	
	for plane in planes_sorted.checked:
		var item = CheckBox.new()
		item.text = plane.registration + ", " + plane.id
		item.button_pressed = true
		$scroll/planes/checked.add_child(item)
	for plane in planes_sorted.unchecked:
		var item = CheckBox.new()
		item.text = plane.registration + ", " + plane.id
		item.button_pressed = false
		$scroll/planes/unchecked.add_child(item)
