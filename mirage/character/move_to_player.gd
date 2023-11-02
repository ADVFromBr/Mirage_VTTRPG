extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func run_children(node,player_,path,path_node,delta):
	for i in get_children():
				if i.has_method("run"):
						i.run(node,player_,path,path_node,delta)

export var speed := 8.0
var delta_check_for_movement := 0.0
# Called when the node enters the scene tree for the first time.
func run(node,player_,path,path_node,delta):
					if get_tree().current_scene.get_turn_from_name(player_).current_turn_caracter == node:				
										if AntithesiSystem.enable_rum_to_player_add:
												var player_dir_proxy = player_.global_transform.origin
												player_dir_proxy.y = node.global_transform.origin.y
												var move_dir = node.global_transform.origin - player_dir_proxy
												if move_dir.length() <= 11:
														node.set_dir( Vector3.ZERO)
														run_children(node,player_,path,path_node,delta)
												else:


														move_dir = -move_dir.normalized()
														node.set_dir((move_dir * speed))

														delta_check_for_movement = delta_check_for_movement + delta

														if delta_check_for_movement >= 6:
																get_tree().current_scene.get_turn_from_name(player_).switch_current_turn_caracter(node)

										else:
												var dir_ = node.global_transform.origin -player_.global_transform.origin
												dir_= -dir_
												dir_ = dir_.normalized()
												
														
												node.orient_character_to_dir(dir_, delta  * 24)
												node.set_dir( Vector3.ZERO)
												run_children(node,player_,path,path_node,delta)
					else:
												var dir_ = node.global_transform.origin -player_.global_transform.origin
												dir_= -dir_
												dir_ = dir_.normalized()
												
														
												node.set_dir( Vector3.ZERO)
												run_children(node,player_,path,path_node,delta)
