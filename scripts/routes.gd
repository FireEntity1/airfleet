extends Control

var from = 0
var to = 1

var route = ["XXX", "XXX"]

var plane_checkboxes: Array
var plane_data_refs: Array

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
	for i in Global.save_file.airports.size():
		if Global.save_file.airports[i].code == code:
			to = i
			airport = Global.save_file.airports[i]
			break
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
		#print(route)
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
	var route = [origin.code, destination.code]
	var planes_available = []
	distance = destination.distance[origin.code]
	$distance.text = "Distance: " + str(distance) + "NMi"
	for plane in Global.save_file.planes:
		if distance < plane.maxRange:
			planes_available.append(plane)
	var planes_sorted = get_planes([origin.code,destination.code], planes_available)
	
	for child in $scroll/planes/checked.get_children():
		$scroll/planes/checked.remove_child(child)
		child.queue_free()
	
	for child in $scroll/planes/unchecked.get_children():
		$scroll/planes/unchecked.remove_child(child)
		child.queue_free()
		
	for child in $scroll/planes/other_route.get_children():
		$scroll/planes/other_route.remove_child(child)
		child.queue_free()
	
	plane_checkboxes.clear()
	plane_data_refs.clear()

	for plane in planes_sorted.unchecked:
		var checkbox = CheckBox.new()
		checkbox.text = plane.registration + ", " + plane.id
		checkbox.button_pressed = false
		checkbox.connect("toggled", Callable(self, "_on_plane_checkbox_toggled").bind(checkbox))
		$scroll/planes/unchecked.add_child(checkbox)

		plane_checkboxes.append(checkbox)
		plane_data_refs.append(plane)
		
	for plane in planes_sorted.checked:
		var checkbox = CheckBox.new()
		checkbox.text = plane.registration + ", " + plane.id
		checkbox.button_pressed = true
		checkbox.connect("toggled", Callable(self, "_on_plane_checkbox_toggled").bind(checkbox))
		$scroll/planes/checked.add_child(checkbox)
		
		plane_checkboxes.append(checkbox)
		plane_data_refs.append(plane)
	
	for plane in planes_sorted.other_route:
		var checkbox = CheckBox.new()
		checkbox.text = "X - " + plane.registration + ", " + plane.id
		checkbox.button_pressed = false
		checkbox.connect("toggled", Callable(self, "_on_plane_checkbox_toggled").bind(checkbox))
		$scroll/planes/other_route.add_child(checkbox)
		
		plane_checkboxes.append(checkbox)
		plane_data_refs.append(plane)

func _on_plane_checkbox_toggled(pressed, checkbox):
	var index = plane_checkboxes.find(checkbox)
	var toggled_plane = plane_data_refs[index]
	for plane in Global.save_file.planes:
		if plane.registration == toggled_plane.registration:
			if pressed:
				plane.route = [Global.save_file.airports[from].code, Global.save_file.airports[to].code]
				print(plane.route)
				print("Assigned", plane.registration, "to", plane.route)
				
			else:
				plane.route = ["XXX", "XXX"]
				print("Unassigned", plane.registration)
				break
	update(Global.save_file.airports[from], Global.save_file.airports[to])
	Global.save(Global.save_file)
