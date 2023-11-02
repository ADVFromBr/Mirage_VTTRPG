extends inventory_system







func get_player():
	return player
	
func set_player(player_):
	player = player_
var currentitem_array := 0
export var max_item_count := 3

func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	return swipe
func _ready():
		eq_rect = eq_slots.rect_size
		visible = true
		var add_ = load("res://ui/get_menu.tscn").instance()
		add_child(add_)
		add_.visible = true
		set_adds_bkpk(add_)
		adds_bkpk._init_func(null)
		eq_slots._init_func()
		grid_bkpk._init_func()
		adds_bkpk.rect_global_position = get_node("menu_empty").rect_global_position
		adds_bkpk.rect_size = get_node("menu_empty").rect_size
		pickup_item_bag("coin_silver")
		pickup_item_bag("coin")


func insert_to_array(original_array, new_array):
	for v in new_array:
		if not original_array.has(v):
			original_array.push_back(v)
func _un_init_func():

	for i in get_children():
			if Item.get_item(i.name) != Item.ITEMS.error:
				i.queue_free()
	eq_slots._un_init_func()
	grid_bkpk._un_init_func()




func get_childs():
	return childs
	




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
										grab(_calculate_swipe(event.get_position()))

			if Input.is_action_just_released("inv_grab"):
						release(_calculate_swipe(event.get_position()))

			if item_held != null:
					item_held.rect_global_position = _calculate_swipe(event.get_position()) + item_offset
		 
		elif visible == false and item_held != null:
						release(_calculate_swipe(event.get_position()))



func grab(cursor_pos):
	if get_parent().has_node("TextureRect"):
		if get_parent().get_node("TextureRect").get_rect().has_point(cursor_pos):
			return
			
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
				if adds_bkpk.insert_item_at_first_available_spot(item_held):
					item_held = null
				else:
					return_item()

	elif c.has_method("insert_item"):

					if c == grid_bkpk:

								if c.insert_item(item_held):
									PlayeerStat.emit_signal("player_aqueried_coin",Item.get_item(item_held.name_))
									item_held = null
									get_tree().current_scene.end("dungeon")

								else:
									if adds_bkpk.insert_item_at_first_available_spot(item_held):
										item_held = null

					else:
							if adds_bkpk.insert_item_at_first_available_spot(item_held):
								item_held = null
							

	else:
				if adds_bkpk.insert_item_at_first_available_spot(item_held):
					item_held = null
					
func get_container_under_cursor(cursor_pos):

	var containers
	if adds_bkpk != null: 
		containers = [grid_bkpk,adds_bkpk, eq_slots]
	
	else:
		containers = [grid_bkpk, eq_slots]
		
	print(adds_bkpk)
	for c in containers:
			if c.get_global_rect().has_point(cursor_pos):
				return c
	return null

func drop_item():
	item_held.queue_free()
	item_held = null
 
func return_item():
	returning = true
	item_held.rect_global_position = last_pos

	if last_container.has_method("insert_item"):
		
			if last_container.insert_item(item_held):
				item_held = null
				returning = false
			else:
				if adds_bkpk.insert_item_at_first_available_spot(item_held):
					item_held = null
				else:
					return_item()


	else:
			if adds_bkpk.insert_item_at_first_available_spot(item_held):
				item_held.rect_global_position = adds_bkpk.rect_global_position
				returning = false
				item_held = null
				
			else:
				return_item()
	
func set_adds_bkpk(add_):
	adds_bkpk = add_
	
func drop_item_in_children(item_to_delete):
		get_node(item_to_delete.name).queue_free()
		eq_slots.remove_item(item_to_delete)
		emit_signal("update_weapon_item_array",null)


func drop_from_grid(item_to_delete):
	if grid_bkpk.items_.find(item_to_delete) != -1:
		grid_bkpk.remove_item_grid(get_node(item_to_delete.name))
		emit_signal("update_weapon_item_array",null)
		#get_parent().emit_signal("removed_weapon_item_array",eq_slots,Item.get_item(item_to_delete.name))
		eq_slots.remove_item(item_to_delete)
		get_node(item_to_delete.name).queue_free()

func pickup_item_bag(item_id):
	if Item.get_item(item_id) != Item.ITEMS.error:
		if !has_node(item_id):
			var item = load("res://Items/slot.tscn").instance()
			add_child(item)
			item.name = item_id
			var texture = load(Item.get_item(item_id)["icon"])
			print(item_id)
			item._set_size(texture.get_size())
			item.set_custom_minimum_size(texture.get_size())
			item.get_node("HBoxContainer/TextureRect").set_texture (load(Item.get_item(item_id)["icon"]))
			move_child(item, get_child_count())
			item.ini_item_func(item_id)
			if !adds_bkpk.insert_item_at_first_available_spot(item):
				item.queue_free()
				return false

			return true
		
func pickup_item_reinset(item_id):
	if Item.get_item(item_id) != Item.ITEMS.error:

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

			get_tree().create_timer(.8).connect("timeout",eq_slots,"reinsert_item",[get_node(item.name)])
			return true
		
func pickup_item(item_id):
	if Item.get_item(item_id) != Item.ITEMS.error:
		if !has_node(item_id):
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

