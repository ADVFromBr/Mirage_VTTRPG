extends Panel


# Declare member variables here. Examples:

onready var eq_ = get_parent().get_node("EquipmentSlots")
onready var adds_bkpk = get_parent().get_node("get_menu")

var can_delete := false
onready var grid_bkpk = get_parent().get_node("grid_of_carried_items")
var name_ := ""


func removed_weapon_item_array_(emiiter,_item_):
			if adds_bkpk:
				if emiiter == adds_bkpk:
						for i in adds_bkpk.items:
							if i.name_ == name_:
											can_delete = true
				else:
										can_delete = false
			else:
										can_delete = false




# var b = "text"

func ini_item_func(_name_):
		name_ = _name_
		get_parent().connect("removed_weapon_item_array",self,"removed_weapon_item_array_",[])
