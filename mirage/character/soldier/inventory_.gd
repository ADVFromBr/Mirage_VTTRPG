extends Node
class_name inventory_

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var item = load("res://Items/Item_ground.tscn")

var items := []

func add_item(item_name):
		items.append(Item.get_item(item_name))
		print(item_name)



func item_spawn():
	var item_intance = item.instance()
	get_parent().get_parent().add_child(item_intance)
	item_intance.global_transform.origin = get_parent().global_transform.origin  
	item_intance.get_node("grab").set_current_item(items)

