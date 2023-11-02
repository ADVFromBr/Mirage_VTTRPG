extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
		connect("button_down",self,"pressed",[])
		get_node("TouchScreenButton").connect("pressed",self,"pressed",[])
func pressed():
		get_parent().queue_free()
	
