extends Panel

var items = []
var in_inventory = []
var items_ = []
var grid = {}
var cell_size = 82
var grid_width = 0
var grid_height = 0
 
onready var eq_ = get_parent().get_node("EquipmentSlots")
func  _un_init_func():
	items = []
	in_inventory = []
	items_ = []
	grid = {}
	cell_size = 41
	grid_width = 0
	grid_height = 0
	init_ = false
	get_parent().disconnect("removed_weapon_item_array",self,"removed_weapon_item_array_")
var init_ := false
func _init_func():
	var s = get_grid_size(self)
	grid_width = s.x
	grid_height = s.y
	init_ = true
	for x in range(grid_width):
		grid[x] = {}
		for y in range(grid_height):
			grid[x][y] = false
	get_parent().connect("removed_weapon_item_array",self,"removed_weapon_item_array_",[])

func get_items_():
	return items_

func removed_weapon_item_array_(emiiter,_item_):
	if _item_:
		if emiiter != self:
					print(items_.size())

					items.sort()
					var found : bool = false
					for item in items:

								if item == null:
									return
								if found == false:
										if	item.name_ ==_item_.name:
													items_.remove(items_.find(Item.get_item(_item_.name)))
													items.remove(items.find(item))
													found = true
													break
													return

		elif emiiter == self:
					items_.append(Item.get_item(_item_.name))


func insert_item(item):
	
	if items.find(item) > -1:
		var item_pos = item.rect_global_position + Vector2(cell_size / 2, cell_size / 2)
		var g_pos = pos_to_grid_coord(item_pos)
		var item_size = get_grid_size(item)

		if is_grid_space_available(g_pos.x, g_pos.y, item_size.x, item_size.y):
			if eq_.get_item_inside_array().find(Item.get_item(item.name_)) != -1:
				get_parent().emit_signal("update_weapon_item_array", null)
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
			if eq_.get_item_inside_array().find(Item.get_item(item.name_)) != -1:
				get_parent().emit_signal("update_weapon_item_array", null)
			set_grid_space(g_pos.x, g_pos.y, item_size.x, item_size.y, true)
			item.rect_global_position = rect_global_position + Vector2(g_pos.x, g_pos.y) * cell_size

			items.append(item)		
			get_parent().emit_signal("removed_weapon_item_array", self,Item.get_item(item.name_))

			return true
		else:
			print(" Failed adding")
			return false


func insert_item_(item):
	var item_pos = item.rect_global_position + Vector2(cell_size / 2, cell_size / 2)
	var g_pos = pos_to_grid_coord(item_pos)
	var item_size = get_grid_size(item)

	if is_grid_space_available(g_pos.x, g_pos.y, item_size.x, item_size.y):
		if eq_.get_item_inside_array().find(Item.get_item(item.name_)) != -1:
			get_parent().emit_signal("update_weapon_item_array", null)
		set_grid_space(g_pos.x, g_pos.y, item_size.x, item_size.y, true)
		item.rect_global_position = rect_global_position + Vector2(g_pos.x, g_pos.y) * cell_size

		items.append(item)

		print(item.name_ + " added")

	
		return true
	else:
		print(" Failed adding")
		return false

func remove_item_grid(item):

	var item_pos = item.rect_global_position + Vector2(cell_size / 2, cell_size / 2)
	var g_pos = pos_to_grid_coord(item_pos)
	var item_size = get_grid_size(item)
	set_grid_space(g_pos.x, g_pos.y, item_size.x, item_size.y, false)
	items.remove(items.find(item))
	get_parent().emit_signal("removed_weapon_item_array",self,Item.get_item(item.name_))
	return item
 

func grab_item(pos):
	var item = get_item_under_pos(pos)
	if item == null:
		return null
 
	var item_pos = item.rect_global_position + Vector2(cell_size / 2, cell_size / 2)
	var g_pos = pos_to_grid_coord(item_pos)
	var item_size = get_grid_size(item)
	set_grid_space(g_pos.x, g_pos.y, item_size.x, item_size.y, false)
	return item
 
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
	items.sort()
	for item in items:
		if item != null:
				if item.get_global_rect().has_point(pos):
					return item
	return null
func insert_item_at_first_available_spot_ready(item):
	for y in range(grid_height):
		for x in range(grid_width):
			if !grid[x][y]:
				item.rect_global_position = rect_global_position + Vector2(x, y) * cell_size
				if insert_item_(item):
					return true
	return false

func insert_item_at_first_available_spot(item):
	for y in range(grid_height):
		for x in range(grid_width):
			if !grid[x][y]:
				item.rect_global_position = rect_global_position + Vector2(x, y) * cell_size
				if insert_item(item):
					return true
	return false
