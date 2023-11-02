extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var max_in_view := 61
export var lost_sight := 122


# Called when the node enters the scene tree for the first time.
func run(node,node_player,path,path_node,delta):

		if !node_player:
				var space_state = node.get_world().direct_space_state
				var start_pos = node.global_transform.origin 
				var rayOrigin = start_pos
				var rayEnd = rayOrigin + (node.global_transform.basis.z * max_in_view)
				var intersection = space_state.intersect_ray(rayOrigin, rayEnd)
				if not intersection.empty():
					
					if intersection.collider == null :
						return
						
					if intersection.collider.has_method("get_health") and intersection.collider != node:
						if intersection.collider.name.begins_with("Player"):
							for i in get_children():
									if i.has_method("run"):
										
											node.set_player(intersection.collider)
											i.run(node,node_player,path,path_node,delta)
											

		else:

				if get_tree().current_scene.get_turn_from_name(node_player) != null:
					var _distance_ = node.global_transform.origin.distance_to(node_player.global_transform.origin)
					if _distance_ > max_in_view:
								get_tree().current_scene.get_turn_from_name(node_player).remove_from_turn_caracters_array(node)
								return

				for i in get_children():
					if i.has_method("run"):
							i.run(node,node_player,path,path_node,delta)
