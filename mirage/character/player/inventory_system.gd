extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


var current_item_array = [] 

func add_current_item_array(item):
	
	current_item_array.append(item)
	
