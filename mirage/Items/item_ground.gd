extends Node






var current_item_ := []

func set_current_item(_current_item_):
	current_item_ = _current_item_



var item_array_size := 0
var start_item_size := 0
func open_menu(player_):

			if player_ == null:
				return
			if player_.get_Inventory().visible == false:
				player_.get_Inventory()._init_func("add")
				player_.get_Inventory().visible = true
				var add_ = load("res://ui/get_menu.tscn").instance()
				player_.get_Inventory().add_child(add_)
				player_.get_Inventory().get_node("get_menu").visible = true
				player_.get_Inventory().get_node("get_menu")._init_func(null)
				player_.get_Inventory().set_adds_bkpk(player_.get_Inventory().get_node("get_menu"))
				for i in current_item_:
						player_.get_Inventory().pickup_item_bag(i.name)

				player_.get_Inventory().get_node("get_menu").connect("bag_update",self,"removed_weapon_item_array_",[])
				player_.connect("open_close_menu",self,"_open_close_menu",[])


func _open_close_menu(inventory_visibility):
	if !inventory_visibility:
				return
	
	


func removed_weapon_item_array_(_item_,item_array_size_,start_item_size_new):
			current_item_ = _item_
			item_array_size = item_array_size_
			start_item_size = start_item_size_new
func get_currrent_item_():
				if current_item_:
					
					return current_item_
					
				return null


