extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func run_children(node,player_,path,path_node,delta):
	for i in get_children():
				if i.has_method("run"):
						i.run(node,player_,path,path_node,delta)

var delta_check_for_movement := 0.0
export var speed := 5

func delay_check_if_is_turn_character_is_null(node,player_):
		if get_tree().current_scene.get_turn_from_name(player_).current_turn_caracter == null:
					get_tree().current_scene.get_turn_from_name(player_).current_turn_caracter = node

# Called when the node enters the scene tree for the first time.
func run(node,player_,path_node,path,delta):
										if get_tree().current_scene.get_turn_from_name(player_) == null:
											get_tree().current_scene.set_turn(player_)
										

										get_tree().current_scene.get_turn_from_name(player_).add_to_turn_caracters_array(node)
										
										get_tree().current_scene.get_turn_from_name(player_).add_to_turn_caracters_array(player_)

										if get_tree().current_scene.get_turn_from_name(player_).current_turn_caracter == null:
														get_tree().create_timer(.5).connect("timeout",self,"delay_check_if_is_turn_character_is_null",[node,player_])

										if get_tree().current_scene.get_turn_from_name(player_).current_turn_caracter == node:
														print(get_tree().current_scene.get_turn_from_name(player_).current_turn_caracter.name)
														run_children(node,player_,path,path_node,delta)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
