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
				
				if get_tree().current_scene.get_turn_from_name(player_).current_turn_caracter == node:
					
					for i in get_children():
						if i.has_method("run"):
							i.run(node,player_,path,path_node,delta)
					
				
				
