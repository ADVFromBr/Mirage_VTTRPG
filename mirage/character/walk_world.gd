extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed := 5
# Called when the node enters the scene tree for the first time.
func run(node,player_,path_node,path,delta):

									if path.size() > 0 and path_node < path.size():
										
										var path_convert = 	(path[path_node])
										path_convert.y = node.global_transform.origin.y
										var direction = path_convert - node.global_transform.origin
										var move_dir = Vector3.ZERO
										print( direction.length() )
										if direction.length() < 1 :
												node.path_node = node.path_node + 1
												print( path_node )

										else:

												move_dir = direction.normalized() * speed
										node.set_dir( move_dir)
										node.select_npc_actiion = node.possible_npc_actions.NPC_WALK
										node.orient_character_to_dir(direction ,delta)

									else:
										node.get_model_dir(player_.global_transform.origin)
