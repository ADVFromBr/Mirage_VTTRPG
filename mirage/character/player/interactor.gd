extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var camera_ : Camera = 	get_viewport().get_camera() 
onready var anim : AnimationPlayer
signal update_array_in_inventory(item)
onready var scene_fade = get_tree().current_scene.get_node("CanvasLayer").get_node("fade")

# Called when the node enters the scene tree for the first time.
func _interact() -> void:
	#if Input.is_action_pressed("interact"):
			var space_state = get_world().direct_space_state
			var mouse_position = camera_.global_transform.origin + camera_.global_transform.basis.y *.2
			var rayOrigin = mouse_position
			var rayEnd = rayOrigin -  camera_.global_transform.basis.z * 4
			var intersection = space_state.intersect_ray(rayOrigin, rayEnd)
			if not intersection.empty():

				if intersection.collider == null:
					return

				if intersection.collider != get_parent():
					print(intersection.collider.name)
					if intersection.collider.has_method("leave"):
								#intersection.collider.leave()
								print(intersection.collider.name)
								get_tree().current_scene.end(intersection.collider.get_parent().name)
					elif intersection.collider.name =="door":
								if 	intersection.collider.get_parent().get_parent().has_node("AnimationPlayer"):
										print(intersection.collider.get_parent().get_parent().name)
										intersection.collider.get_parent().get_parent().get_node("AnimationPlayer").play("open")

					elif intersection.collider.has_method("play_dialogue"):
						if intersection.collider.character != null:
											intersection.collider.open_menu(get_parent())
											intersection.collider.set_player(get_parent())
						else:
											intersection.collider.set_player(get_parent())
															
					elif intersection.collider.has_method("open_menu"):
							intersection.collider.open_menu(get_parent())
								
					elif Item.get_item(intersection.collider.name) != Item.ITEMS.error:
							get_parent().get_Inventory().pickup_item(intersection.collider.name)
