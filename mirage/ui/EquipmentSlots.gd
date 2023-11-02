extends GridContainer
 
onready var add_ = get_parent().get_node("get_menu")
var items = {}
var item_inside_array = [] 
var slots 
func _un_init_func():
	slots = get_children()
	item_inside_array = [] 
	items = {}
	slots = null
	get_parent().disconnect("removed_weapon_item_array",self,"removed_weapon_item_array_")
	init_ = false
var init_ := false
func _init_func():
	slots = get_children()
	init_ = true
	for slot in slots:
		items[slot.name] = null
	get_parent().connect("removed_weapon_item_array",self,"removed_weapon_item_array_",[])

func set_init(value : bool):
		init_ = value
		print("eq desable")
func get_item_inside_array():
	return item_inside_array

onready var grid_bkpk = get_parent().get_node("grid_of_carried_items")

func remove_item(item):
		var item_slot = Item.get_item(item.name_)["slot"]
		items[item_slot] = null
		get_parent().emit_signal("removed_weapon_item_array",self,Item.get_item(item.name_))

func removed_weapon_item_array_(emiiter,_item_):
	if _item_:
		if emiiter != self:
				if item_inside_array.find(Item.get_item(_item_.name)) != -1:
					if Item.get_item(_item_.name).type == "armor":
							get_parent().get_player_().set_armor(0)
				
				item_inside_array.remove(item_inside_array.find(Item.get_item(_item_.name)))
				
		elif emiiter == self:
					item_inside_array.append(Item.get_item(_item_.name))
			




func reinsert_item(item):
	var item_pos = item.rect_global_position + item.rect_size / 2
	var item_slot = Item.get_item(item.name_)["slot"]
	items[item_slot] = item
	var slot = get_node(item_slot)
	item.rect_global_position = slot.rect_global_position + slot.rect_size / 2 - slot.rect_size / 2

	get_parent().emit_signal("update_weapon_item_array",Item.get_item(item.name_))
	get_parent().emit_signal("removed_weapon_item_array",self,Item.get_item(item.name_))
	print("added "  + item.name_ +" to hand")

	init_ = true

func insert_item(item):
	var item_pos = item.rect_global_position + item.rect_size / 2
	var slot = get_slot_under_pos(item_pos)
	if slot == null:
		return false
 
	var item_slot = Item.get_item(item.name_)["slot"]
	if item_slot != slot.name:
		return false
	if items[item_slot] != null:
		return false
	items[item_slot] = item
	item.rect_global_position = slot.rect_global_position + slot.rect_size / 2 - item.rect_size / 2

	get_parent().emit_signal("removed_weapon_item_array",self,Item.get_item(item.name_))
	
	if Item.get_item(item.name_).has("type") and Item.get_item(item.name_).type != "armor":
				get_parent().emit_signal("update_weapon_item_array",Item.get_item(item.name_))
				print("added "  + item.name_ +" to hand")

	elif Item.get_item(item.name_).has("type") and Item.get_item(item.name_).type == "armor":
											get_parent().get_player_().set_armor(Item.get_item(item.name_).armor)

	return true
func grab_item(pos):
	var item = get_item_under_pos(pos)
	
	if item == null:
		return null

	var item_slot = Item.get_item(item.name_)["slot"]
	items[item_slot] = null
	#item_inside_array.remove(item_inside_array.find(Item.get_item(item.name))) 
	return item
 
func get_slot_under_pos(pos):
	return get_thing_under_pos(slots, pos)
 
func get_item_under_pos(pos):
	return get_thing_under_pos(items.values(), pos)
 
func get_thing_under_pos(arr, pos):
	for thing in arr:
		if thing != null and thing.get_global_rect().has_point(pos):
			return thing
	return null

