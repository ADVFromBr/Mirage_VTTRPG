extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _remove():
	pass # Replace with function body.

func _process(delta):
	connect("animation_finished",self,"_remove",[])
