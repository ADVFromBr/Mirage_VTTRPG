extends Node


# Declare member variables here. Examples:
# var a = 2
 
# Called when the node enters the scene tree for the first time.
func run(node,node_player,path,path_node,delta):
		
		if node_player:
			
						for i in get_children():
								if i.has_method("run"):
										i.run(node,node_player,path,path_node,delta)

		else:

					return
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
