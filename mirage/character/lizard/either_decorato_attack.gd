extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _distance_between_nodes(vec, vec2,distance):
						if vec.distance_to(vec2) < distance:
								get_children()[0].run()	
