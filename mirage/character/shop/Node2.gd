extends inventory_


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_item("ring")
	add_item("vessel")
	add_item("miner")
	add_item("book")
	add_item("map_world")

	get_parent().set_current_item(items)
