extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var health_node : TextureProgress = get_node("health")
onready var heat_node : TextureProgress = get_node("heat")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_viewport().get_camera().get_parent().connect("health_value_changed", self,"update_health",[])
	get_viewport().get_camera().get_parent().connect("heat_value_changed", self,"update_heat",[])
	
	health_node.set_value( get_viewport().get_camera().get_parent().get_health())
	heat_node.set_value( get_tree().current_scene.get_heat() )
	
func update_health(_value_):
		health_node.set_value( _value_)
		
func update_heat(value_):
		heat_node.set_value( value_)
