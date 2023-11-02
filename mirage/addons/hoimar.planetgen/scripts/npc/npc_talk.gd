extends char_npc
class_name npc_talk


var discount = ["glove"]

var dialogue = []
export(Resource) var character

var current_item_ := []

func set_current_item(_current_item_):
	current_item_ = _current_item_



var item_array_size := 0
var start_item_size := 0
func open_menu(_player_):
	if !player_char:
			player_char = _player_
			if player_char == null:
				return
			if player_char.get_Inventory().visible == false:
				player_char.get_Inventory().visible = true
				var add_ = load("res://ui/get_menu.tscn").instance()
				player_char.get_Inventory().add_child(add_)
				var rool_d_20 = get_tree().current_scene.rool_a_d_twenty(player_char,player_char.get_canva_(),"level_rng")
				
				if rool_d_20 > 15:
					for i in current_item_:
						discount.append(i.name)				
				
				
				player_char.get_Inventory().get_node("get_menu").visible = true
				player_char.get_Inventory().get_node("get_menu")._init_func(self)
				player_char.get_Inventory().set_adds_bkpk(player_char.get_Inventory().get_node("get_menu"))
				for i in current_item_:
						player_char.get_Inventory().pickup_item_bag(i.name)

				player_char.get_Inventory().get_node("get_menu").connect("bag_update",self,"removed_weapon_item_array_",[])
				player_char.connect("open_close_menu",self,"_open_close_menu",[])


func _open_close_menu(inventory_visibility):
	if !inventory_visibility:
			player_char.get_Inventory().get_node("get_menu").disconnect("bag_update",self,"removed_weapon_item_array_")
			player_char.disconnect("open_close_menu",self,"_open_close_menu")

			player_char = null


	


func removed_weapon_item_array_(_item_,item_array_size_,start_item_size_new):
			current_item_ = _item_
			item_array_size = item_array_size_
			start_item_size = start_item_size_new
func get_currrent_item_():
				if current_item_:
					
					return current_item_
					
				return null


# Called when the node enters the scene tree for the first time.
func play_dialogue(player_):
	if character:
		open_menu(player_)
func load_dialogue():
	var file = File.new()
	if file.file_exists(character.dialogue_file):
		file.open(character.dialogue_file,file.READ)
		return parse_json(file.get_as_text())
