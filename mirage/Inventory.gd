extends Control
class_name inventory_system




var returning := false

var current_held_item : Item = null
var last_container = null
var last_pos : Vector2 = Vector2.ZERO
var item_offset : Vector2 = Vector2.ZERO
 
#onready var inv_base = $InventoryBase
onready var grid_bkpk = $grid_of_carried_items
onready var eq_slots = $EquipmentSlots
onready var adds_bkpk = null
var item_held = null
 
var player : RigidBody = null

func get_player():
	return player
	
func set_player(player_):
	player = player_

onready var slot = load("res://Items/slot.tscn")
var current_items_in_equiments_slot = []
var current_items_in_carring_slot = []

var current_item_array = []

signal update_weapon_item_array(item_equiped)
signal removed_weapon_item_array(emitted, item_equiped)
var eq_rect


var last_grid_pos := Vector2()

var swipe_start = null
var minimum_drag = 100

func _ready():
	eq_rect = eq_slots.rect_size
	childs = get_children()
	_init_func("")

func insert_to_array(original_array, new_array):
	for v in new_array:
		if not original_array.has(v):
			original_array.push_back(v)
func set_adds_bkpk(add_):
	adds_bkpk = add_
	
func _un_init_func():

	if adds_bkpk != null:
			for i in adds_bkpk.items:
				print(i.name_ + "removvd")
				i.queue_free()
				
			get_node("get_menu").queue_free()
			adds_bkpk = null
	
	for i in get_children():
			if i.has_method("ini_item_func"):
					i.queue_free()
	eq_slots._un_init_func()
	grid_bkpk._un_init_func()



var childs := []
func get_childs():
	return childs
var player_ : RigidBody  = null	
func get_player_():
	return player_
func set_player_(_player_):
	player_ = _player_

func _init_func(add):
	
	
	
	_un_init_func()
	emit_signal("update_weapon_item_array",null)
	eq_slots._init_func()
	grid_bkpk._init_func()

	eq_slots.visible = true

	print("size of PlayeerStat.items_inventory_bag is " +str( PlayeerStat.items_inventory_bag.size()))
	for i in PlayeerStat.items_inventory_bag:
				get_tree().create_timer(0.5).connect("timeout",self,"pickup_item",[i.name])


	for i in PlayeerStat.items_in_hand_:
					get_tree().create_timer(0.6).connect("timeout",self,"pickup_item_reinset",[i.name])
					print(i.name)
					eq_slots._set_size(eq_rect)

func _process(delta):
	var cursor_pos = get_global_mouse_position()
	if visible == true:

		
			if Input.is_action_just_pressed("inv_grab"):
											
										grab(cursor_pos)

			if Input.is_action_just_released("inv_grab"):
						release(cursor_pos)

			if item_held != null:
					item_held.rect_global_position = cursor_pos + item_offset
		 
	elif visible == false and item_held != null:
						release(cursor_pos)



func _unhandled_input(event):


	if visible == true:


			if event is InputEventScreenTouch:	
				if Input.is_action_just_pressed("inv_grab"):
											grab(event.get_position())

				if Input.is_action_just_released("inv_grab"):
							release(event.get_position())                                 

				if item_held != null:
						item_held.rect_global_position = event.get_position() + item_offset
			 
			elif visible == false and item_held != null:
							release(event.get_position())


func grab(cursor_pos):
	var c = get_container_under_cursor(cursor_pos)
		
	if c != null and c.has_method("grab_item"):
		item_held = c.grab_item(cursor_pos)
		if item_held != null:
			last_container = c
			last_pos = item_held.rect_global_position
			item_offset = item_held.rect_global_position - cursor_pos
			move_child(item_held, get_child_count())

func release(cursor_pos):
	if item_held == null:
		return
	var c = get_container_under_cursor(cursor_pos)
	if c == null:
				if grid_bkpk.insert_item_at_first_available_spot(item_held):
					item_held = null
				else:
					return_item()

	elif c.has_method("insert_item") and c.visible == true:

					
					if c.insert_item(item_held):
						item_held = null
					else:
						if grid_bkpk.insert_item_at_first_available_spot(item_held):
							item_held = null
	else:
				if grid_bkpk.insert_item_at_first_available_spot(item_held):
					item_held = null
					
func get_container_under_cursor(cursor_pos):

	var containers = []
	if adds_bkpk != null: 
		containers = [grid_bkpk,adds_bkpk, eq_slots]
	
	else:
		containers = []
		containers = [grid_bkpk, eq_slots]
		
	print(adds_bkpk)
	for c in containers:
		if c != null:
			if c.has_method("get_global_rect"):
				if c.get_global_rect().has_point(cursor_pos):
					return c
	return null

func drop_item():
	item_held.queue_free()
	item_held = null
 
func return_item():
	returning = true
	item_held.rect_global_position = last_pos

	if last_container.has_method("insert_item") and last_container.visible == true:
		
			if last_container.insert_item(item_held):
				item_held = null
				returning = false
			else:
				if grid_bkpk.insert_item_at_first_available_spot(item_held):
					item_held = null
				else:
					return_item()


	else:
			if grid_bkpk.insert_item_at_first_available_spot(item_held):
				item_held.rect_global_position = grid_bkpk.rect_global_position
				returning = false
				item_held = null
				
			else:
				return_item()
	
 
func drop_item_in_children(item_to_delete_):
		var found := false
		eq_slots.item_inside_array.remove(eq_slots.item_inside_array.find(Item.get_item(item_to_delete_.name)))
		for item in grid_bkpk.items:
			if found == false:
				if	item.name_ ==item_to_delete_.name:
						grid_bkpk.items.remove(grid_bkpk.items.find(item))
						found = true
		

func drop_from_grid(item_to_delete):

		grid_bkpk.remove_item_grid(get_node(item_to_delete.name))
		emit_signal("update_weapon_item_array",null)
		#get_parent().emit_signal("removed_weapon_item_array",eq_slots,Item.get_item(item_to_delete.name))
		eq_slots.remove_item(item_to_delete)
		get_node(item_to_delete.name).queue_free()

func pickup_item_bag(item_id):

			var item = load("res://Items/slot.tscn").instance()
			add_child(item)
			item.name = item_id
			var texture = load(Item.get_item(item_id)["icon"])
			print(item_id)
			item._set_size(texture.get_size())
			item.set_custom_minimum_size(texture.get_size())
			item.get_node("HBoxContainer/TextureRect").set_texture (load(Item.get_item(item_id)["icon"]))
			move_child(item, get_child_count())
			adds_bkpk = get_node("get_menu")
			item.ini_item_func(item_id)
			if !adds_bkpk.insert_item_at_first_available_spot(item):
				item.queue_free()
				return false

			return true
func pickup_item_reinset(item_id):

			var item = load("res://Items/slot.tscn").instance()
			add_child(item)
			item.name = item_id
			var texture = load(Item.get_item(item_id)["icon"])
			print(item_id)
			item._set_size(texture.get_size())
			item.set_custom_minimum_size(texture.get_size())
			item.get_node("HBoxContainer/TextureRect").set_texture (load(Item.get_item(item_id)["icon"]))
			item.ini_item_func(item_id)
			move_child(item, get_child_count())
			if !grid_bkpk.insert_item_at_first_available_spot(item):
				pass

			get_tree().create_timer(.8).connect("timeout",eq_slots,"reinsert_item",[get_node(item.name)])
			return true


func pickup_item(item_id):

			var item = load("res://Items/slot.tscn").instance()
			add_child(item)
			item.name = item_id
			var texture = load(Item.get_item(item_id)["icon"])
			print(item_id)
			item._set_size(texture.get_size())
			item.set_custom_minimum_size(texture.get_size())
			item.get_node("HBoxContainer/TextureRect").set_texture (load(Item.get_item(item_id)["icon"]))
			item.ini_item_func(item_id)
			move_child(item, get_child_count())
			if !grid_bkpk.insert_item_at_first_available_spot(item):
				item.queue_free()
				return false

			return true


