extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var max_distance = 6

# Called when the node enters the scene tree for the first time.
func run(node,player_,path,path_node,delta):
	if get_children().size() > 0:
			if player_ == null:
				return
			var distance_ = node.global_transform.origin.distance_to(player_.global_transform.origin)

			if distance_ > max_distance:
							if get_children()[0].has_method("run"):
								get_children()[0].run(node,player_,path,path_node,delta)
								return
			
			elif distance_ <= max_distance: 				
							if get_children()[1].has_method("run"):
								get_children()[1].run(node,player_,path,path_node,delta)
						
								

