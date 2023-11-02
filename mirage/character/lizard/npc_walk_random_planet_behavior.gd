extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ramdom_pos_int = 10

export var speed : int = 15
# Called when the node enters the scene tree for the first time.
func run(node,player_,path_node,path,delta):
									
									
									if path_node < path.size():
										
										var path_convert = 	(path[path_node])
										path_convert.y = node.global_transform.origin.y
										var direction = path_convert - node.global_transform.origin

										var move_dir = Vector3.ZERO

										if direction.length() < 1:
												node.path_node = node.path_node + 1
												


										else:

												move_dir = direction.normalized() * speed
										node.set_dir( move_dir)
										node.select_npc_actiion = node.possible_npc_actions.NPC_WALK
										node.set_rot_dir( direction)
									elif path.size() <= 0:
										var next_dir = node._start_position + Vector3(rand_range(-ramdom_pos_int,ramdom_pos_int),node.global_transform.origin.y,rand_range(-ramdom_pos_int,ramdom_pos_int))

										node.get_model_dir(next_dir)


									else:
										var next_dir = node._start_position + Vector3(rand_range(-ramdom_pos_int,ramdom_pos_int),node.global_transform.origin.y,rand_range(-ramdom_pos_int,ramdom_pos_int))

										node.get_model_dir(next_dir)

