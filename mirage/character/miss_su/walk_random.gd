extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func walk_behavior(path_node, path,node_parent):
					if path_node < path.size():
										var path_convert = 	(path[path_node])
										path_convert.y = node_parent.global_transform.origin.y
										var direction = path_convert - node_parent.global_transform.origin

										if direction.length() < 1:
												path_node += 1

										else:

														var _move_dir = direction.normalized()
														return _move_dir
					else:
							var _move_dir = Vector3.ZERO
							return _move_dir
