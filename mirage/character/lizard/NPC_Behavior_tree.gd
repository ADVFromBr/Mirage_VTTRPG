extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"




# Called when the node enters the scene tree for the first time.
func current_action (node,node_player,path,path_node,delta):
	for i in get_children():
		if i.has_method("run"):
			i.run(node,node_player,path,path_node,delta)
