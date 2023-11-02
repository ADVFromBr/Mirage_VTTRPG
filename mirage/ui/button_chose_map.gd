extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var level_choice := "dungeon_2"

# Called when the node enters the scene tree for the first time.
func _ready():
			get_node("TouchScreenButton").connect("pressed",self,"_on_TouchScreenButton_pressed",[])

func _on_TouchScreenButton_pressed():
		PlayeerStat.next_city = level_choice
		PlayeerStat.distance_to_next = Globals.leve_level_selector.get(PlayeerStat.last_town)[1].distance_to(Globals.leve_level_selector.get(PlayeerStat.next_city)[1])
		var random_int_generator =  randi() % 20
		PlayeerStat.emit_signal("player_traveled",PlayeerStat.distance_to_next)
		if random_int_generator > 15:
		
			get_tree().current_scene.end("fight")
		
		else:
		
			get_tree().current_scene.end("dungeon_ramdom")

		
