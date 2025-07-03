extends Control

var active_airport = 0

func _ready():
	for airport in Global.save_file.airports:
		$airport_picker.add_item(airport.name)
		$airport_picker.select(0)

func _process(delta):
	pass

func _on_airport_picker_item_selected(index):
	print(Global.save_file.airports[index])
	var airport = Global.save_file.airports[index]
	active_airport = index
	$code.text = airport.code
	$name.text = airport.name
	
	if airport.upgrades.lounge:
		$lounge.icon = Global.ICONS.unlocked
	else:
		$lounge.icon = Global.ICONS.locked
		
	if airport.upgrades.jetbridges:
		$jetbridge.icon = Global.ICONS.unlocked
	else:
		$jetbridge.icon = Global.ICONS.locked
		
	if airport.upgrades.eco_fuel:
		$eco_fuel.icon = Global.ICONS.unlocked
	else:
		$eco_fuel.icon = Global.ICONS.locked
	


func _on_lounge_button_up():
	if not Global.save_file.airports[active_airport].upgrades.lounge:
		Global.save_file.airports[active_airport].upgrades.lounge = true
		Global.save(Global.save_file)

func _on_jetbridge_button_up():
	if not Global.save_file.airports[active_airport].upgrades.jetbridges:
		Global.save_file.airports[active_airport].upgrades.jetbridges = true
		Global.save(Global.save_file)

func _on_eco_fuel_button_up():
	if not Global.save_file.airports[active_airport].upgrades.eco_fuel:
		Global.save_file.airports[active_airport].upgrades.eco_fuel = true
		Global.save(Global.save_file)
