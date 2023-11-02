extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func run(node,player_,path,path_node,delta):
				if player_ == null:
					return
				if get_tree().current_scene.get_turn_from_name(player_) == null:
					return

				if get_tree().current_scene.get_turn_from_name(player_).get_current_turn_caracter() == node:
					player_.set_current_enemy(node)
					var dir_ = node.global_transform.origin -player_.global_transform.origin
					dir_= -dir_
					dir_ = dir_.normalized()
					

				player_.orient_character_to_dir_(node.global_transform.origin, delta * 8 )

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
