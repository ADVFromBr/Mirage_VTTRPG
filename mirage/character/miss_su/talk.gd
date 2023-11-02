extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func run(node,player_,path_node,path,delta):
					var dir_ = player_.global_transform.origin - node.global_transform.origin
					dir_ = dir_.normalized()
					node.orient_character_to_dir((dir_ ),delta)

					node.set_dir( Vector3.ZERO)
