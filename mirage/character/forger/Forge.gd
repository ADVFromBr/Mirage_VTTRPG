extends npc_merchant_court


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func open_menu(_player_):
	if !player_char:
			player_char = _player_
			if player_char == null:
				return
			if player_char.get_Inventory().visible == false:
				player_char.get_Inventory().visible = true
				var items_to_build := []
				var items_building := []
				var add_ = load("res://ui/get_menu_craft.tscn").instance()
				player_char.get_Inventory().add_child(add_)
				for i in player_char.get_Inventory().get_children():
						if i.has_method("ini_item_func"):
									player_char.get_Inventory().grid_bkpk.insert_item_at_first_available_spot_ready(i)
									if Item.get_item(i.name_).type == "book":
										items_to_build.append(Item.get_item(i.name_))
										items_building.append(Item.get_item(i.name_).build)

				player_char.get_Inventory().get_node("get_menu").visible = true
				if items_to_build.size() > 0:
					player_char.get_Inventory().get_node("get_menu")._init_func_bag(self,Item.get_item(items_to_build[0].name).required)
					player_char.get_Inventory().set_adds_bkpk(player_char.get_Inventory().get_node("get_menu"))

					for i in items_building:
							player_char.get_Inventory().pickup_item_bag(i)

				player_char.get_Inventory().get_node("get_menu").connect("bag_update",self,"removed_weapon_item_array_",[])
				player_char.connect("open_close_menu",self,"_open_close_menu",[])

