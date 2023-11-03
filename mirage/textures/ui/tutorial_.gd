extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var image_array = ["res://textures/ui/book/t_1_4.png","res://textures/ui/book/t_1.png","res://textures/ui/book/t_2.png","res://textures/ui/book/t_3.png"]
var current_index := 0


func _ready():
						get_node("texture_tutorial").set_texture(load(image_array[current_index]))
						current_index = current_index +1 

func _input(event):
			if event is InputEventScreenTouch:	
				if Input.is_action_pressed("inv_grab_"):
					if current_index <= image_array.size() -1:
						get_node("texture_tutorial").set_texture(load(image_array[current_index]))
						current_index = current_index +1 
					else:
						get_node("texture_tutorial").set_texture(load(image_array[0]))
						current_index = 1 
