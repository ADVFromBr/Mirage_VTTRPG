extends get_item


func get_item_size():
		return start_item_size

var required_materials := []
var current_materials := []
func set_item_size(next_item_):
	
	item_array_size = next_item_
func set_start_item_size(next_item_):
	if next_item_ != 0:
		start_item_size = next_item_
func _un_init_func():
	type_bag = null
	items = []
	in_inventory = []
	grid = {}

	get_parent().disconnect("removed_weapon_item_array",self,"removed_weapon_item_array_")

func update_array():
	var _item_ := []
	var value := 0
	for i in items:
		
		if i == null:
			items.remove(i )
		else:	
			_item_.append(Item.get_item(i.name_))
			value += Item.get_item(i.name_).value
	
	emit_signal("bag_update",_item_,item_array_size,value)


func _init_func_bag(type_bag_ : RigidBody,required_materials_):
	type_bag = type_bag_
	var s = get_grid_size(self)
	grid_width = s.x
	grid_height = s.y

	for x in range(grid_width):
		grid[x] = {}
		for y in range(grid_height):
			grid[x][y] = false
	eq_.visible = false

	get_parent().connect("removed_weapon_item_array",self,"removed_weapon_item_array_",[])
	required_materials = required_materials_


func get_items_():
	return items

func insert_item(item):
	if items.find(item) != -1:
		var item_pos = item.rect_global_position + Vector2(cell_size / 2, cell_size / 2)
		var g_pos = pos_to_grid_coord(item_pos)
		var item_size = get_grid_size(item)

		if is_grid_space_available(g_pos.x, g_pos.y, item_size.x, item_size.y):
					set_grid_space(g_pos.x, g_pos.y, item_size.x, item_size.y, true)
					item.rect_global_position = rect_global_position + Vector2(g_pos.x, g_pos.y) * cell_size
					
					
					return true
		else:
			print(" Failed adding")
			return false
	else:
		var item_pos = item.rect_global_position + Vector2(cell_size / 2, cell_size / 2)
		var g_pos = pos_to_grid_coord(item_pos)
		var item_size = get_grid_size(item)

		if is_grid_space_available(g_pos.x, g_pos.y, item_size.x, item_size.y):
					set_grid_space(g_pos.x, g_pos.y, item_size.x, item_size.y, true)
					item.rect_global_position = rect_global_position + Vector2(g_pos.x, g_pos.y) * cell_size

					var item_array_size_ = item_array_size + Item.get_item(item.name_).value
					items.append(item)

					print(item.name_ + " added")

					get_parent().emit_signal("removed_weapon_item_array",self,Item.get_item(item.name_))
					items.sort()
					current_materials.append(item.name_)
					return true

		
		else:
			print(" Failed adding")
			return false
func insert_item_(item):
	var item_pos = item.rect_global_position + Vector2(cell_size / 2, cell_size / 2)
	var g_pos = pos_to_grid_coord(item_pos)
	var item_size = get_grid_size(item)

	if is_grid_space_available(g_pos.x, g_pos.y, item_size.x, item_size.y):
		set_grid_space(g_pos.x, g_pos.y, item_size.x, item_size.y, true)
		item.rect_global_position = rect_global_position + Vector2(g_pos.x, g_pos.y) * cell_size
		print(item.name_ + " added")
		items.sort()
		items.append(item)
		items.sort()
		return true
	else:
		print(" Failed adding")
		return false


func removed_weapon_item_array_(emiiter,_item_):
	items.sort()

	if _item_:
		if emiiter != self:
		
				for item_inside_array in items:
							
							if item_inside_array == null:
									items.remove(items.find(item_inside_array))
									update_array()
									items.sort()
							elif	item_inside_array.name_ ==_item_.name:
									items.sort()
									items.remove(items.find(item_inside_array))
									items.sort()
									item_array_size = item_array_size  - Item.get_item(item_inside_array.name_).value
									update_array()
									print("add grid uppdated, " +str(items.find(item_inside_array)))

		elif emiiter == self:
				items.sort()
				update_array()
				
func custom_array_sort(a, b):
	if typeof(a) == typeof(b):
		return a < b;
	else:
		if typeof(a) == TYPE_STRING:
			return false;
		else:
			return true;
func remove_item_grid(item_to_release_):
	items.sort()
	for item_to_release in items:
							
									if item_to_release == null:
										item_to_release.remove(items.find(item_to_release))
										items.sort()
										update_array()
										return
									items.sort()
									items.remove(items.find(item_to_release))
									item_to_release.queue_free()
									return null
		 
func remove_item_grid_(item):

	var item_pos = item.rect_global_position + Vector2(cell_size / 2, cell_size / 2)
	var g_pos = pos_to_grid_coord(item_pos)
	var item_size = get_grid_size(item)
	set_grid_space(g_pos.x, g_pos.y, item_size.x, item_size.y, false)
	items.remove(items.find(item))
	update_array()
	return item
 

func grab_item(pos):

	var item = get_item_under_pos(pos)
	if item == null:
		return
		
	var all_materials_found := 0
	for i in required_materials:
				for i_ in current_materials:
					if i_ == i:
						all_materials_found += 1
		
	if all_materials_found == required_materials.size():
			var item_pos = item.rect_global_position + Vector2(cell_size / 2, cell_size / 2)
			var g_pos = pos_to_grid_coord(item_pos)
			var item_size = get_grid_size(item)
			set_grid_space(g_pos.x, g_pos.y, item_size.x, item_size.y, false)

			print("enough money ")
			return item

	else:
				return
		
func pos_to_grid_coord(pos):
	var local_pos = pos - rect_global_position
	var results = {}
	results.x = int(local_pos.x / cell_size)
	results.y = int(local_pos.y / cell_size)
	return results
 
func get_grid_size(item):
	var results = {}
	var s = item.rect_size
	results.x = clamp(int(s.x / cell_size), 1, 500)
	results.y = clamp(int(s.y / cell_size), 1, 500)
	return results
 
func is_grid_space_available(x, y, w ,h):
	if x < 0 or y < 0:
		return false
	if x + w > grid_width or y + h > grid_height:
		return false
	for i in range(x, x + w):
		for j in range(y, y + h):
			if grid[i][j]:
				return false
	return true
 
func set_grid_space(x, y, w, h, state):
	for i in range(x, x + w):
		for j in range(y, y + h):
			grid[i][j] = state
 
func get_item_under_pos(pos):
	for item in items:
			if item.get_global_rect().has_point(pos):
				return item
	return null
func insert_item_at_first_available_spot_at_after_ready(item):
	for y in range(grid_height):
		for x in range(grid_width):
			if !grid[x][y]:
				item.rect_global_position = rect_global_position + Vector2(x, y) * cell_size
				if Item.get_item(item.name_) != Item.ITEMS.error:
					if insert_item_(item):
						return true
	return false

func insert_item_at_first_available_spot(item):
	for y in range(grid_height):
		for x in range(grid_width):
			if !grid[x][y]:
				item.rect_global_position = rect_global_position + Vector2(x, y) * cell_size
				if insert_item_(item):
						print(items.size())
						return true


	return false
