extends command
class_name interact_command

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const Constants := preload("res://addons/hoimar.planetgen/scripts/constants.gd")

func execute(player_ : Node,data: Object) -> void:
	
				player_._interact()
	

