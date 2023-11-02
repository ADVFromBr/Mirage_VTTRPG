extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var menu_ = load("res://ui/menu_open.tscn")

# Called when the node enters the scene tree for the first time.

# Called when the node enters the scene tree for the first time.
func _ready():
		connect("button_down",self,"pressed",[])
		get_node("TouchScreenButton").connect("pressed",self,"pressed",[])
func pressed():
		if get_child_count() < 2:
			var menu = menu_.instance()
			add_child(menu)
		
