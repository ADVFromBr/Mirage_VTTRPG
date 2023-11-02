extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# var b = "text"
var level_choice = ""

# Called when the node enters the scene tree for the first time.
func _ready():
			get_node("TouchScreenButton").connect("pressed",self,"_on_TouchScreenButton_pressed",[])
			
			for i in PlayeerStat.items_inventory_bag:
				if i.name.begins_with("map_"):
							level_choice =  i.name
							break
							
							
							
							
func _on_TouchScreenButton_pressed():
		if level_choice != "":
			if get_parent().name == "map":
				if level_choice == "map_world":
					var next_map = load("res://ui/Planet2.tscn").instance()
					get_parent().get_parent().add_child(next_map)
					get_parent().queue_free()
				
			else:
					var next_map = load("res://ui/Planet1.tscn").instance()
					get_parent().get_parent().add_child(next_map)
					get_parent().queue_free()
				
				
