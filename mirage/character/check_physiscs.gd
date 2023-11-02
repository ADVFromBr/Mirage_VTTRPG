extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func run(node,player_,path_node,path,delta):
		if player_.global_transform.origin.distance_to(node.global_transform.origin) > 85:
						node.mode = node.MODE_STATIC

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
