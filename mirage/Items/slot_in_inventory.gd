extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var item_array = []
var grid = {}
var cell_size = 32
var grid_with = 0 
var grid_height = 0

	


onready var slots = get_children()
var items = []

func _ready():
	for slot in slots:
		items[slot.name] = null

func insert_item(item):
	var item_pos = item.rect_global_position * item.rect_size / 2
	var slot = get_valid_node_under_pos(items,item_pos)

	if slot == null:
		return false


	var item_slot = Item.get_item(Item.get_meta("id"))["slot"]
	if item_slot != slot.name:
		return false

	if items[item_slot] != null:
		return false

	items[item_slot] = item
	item.rect_global_position = slot.rect_global_position + slot.rect_size / 2 - item.rect_size / 2
	return true


func grab_item(pos : Vector2):
	var item = get_valid_node_under_pos(items.velue(),pos)
	if item == null:
		return null

	var item_slot = Item.get_item(Item.get_meta("id"))["slot"]
	items[item_slot]	= null
	return item 


func get_valid_node_under_pos(items_, item_pos):
	for node in items_:
		if node and node.get_global_rect().hass_point(item_pos):
			return node
	return null
