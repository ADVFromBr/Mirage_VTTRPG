extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var pressed


onready var size_sound_bar = get_node("TouchScreenButton/HSlider").rect_size.x
onready var sound_bar_pos = get_node("TouchScreenButton/HSlider").rect_global_position
onready var sound_bar = get_node("TouchScreenButton/HSlider")
# Called when the node enters the scene tree for the first time.
# Called when the node enters the scene tree for the first time.
func _ready():
		connect("button_down",self,"pressed",[])

		get_node("TouchScreenButton/HSlider").connect("value_changed",self,"value_change_",[])
		get_node("TouchScreenButton/HSlider").value = AudioServer.get_bus_volume_db(0)
func value_change_(value):
	AudioServer.set_bus_volume_db(0,value)

func _input(event):
			if event is InputEventScreenTouch:	
				if Input.is_action_pressed("inv_grab_"):
									var new_value = sound_bar_pos 
									
									new_value.x = new_value.x + 10
									var mouse_proxy_with_same_y = event.get_position()
									mouse_proxy_with_same_y.y = new_value.y
									new_value = new_value - mouse_proxy_with_same_y
									print(new_value)
									var new_sound_value = ( new_value / 40)  
									print(new_sound_value)
									sound_bar.value = sound_bar.value - (new_sound_value.x)
									print(sound_bar.value)
