extends inventory_


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
			add_item("vessel")
			get_parent().set_current_item(items)
