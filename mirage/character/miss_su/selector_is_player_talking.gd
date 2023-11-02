extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func run(node,player_,path_node,path,delta):

			if !player_:
				if get_children()[0].has_method("run"):
					get_children()[0].run(node,player_,path_node,path,delta)
					
			else:
				if get_children()[1].has_method("run"):
						get_children()[1].run(node,player_,path_node,path,delta)
