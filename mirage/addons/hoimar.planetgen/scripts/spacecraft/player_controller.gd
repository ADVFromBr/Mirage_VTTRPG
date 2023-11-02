extends Node

const Ship := preload("ship.gd")
const Constants := preload("../constants.gd")

var _mouse_speed := Vector2.ZERO
export onready var ship_path := $".."
onready var camera: Camera = get_parent().get_node("Camera")
onready var ship : RigidBody = get_parent()
var yaw 
var origin : Vector3 = Vector3()
var dist : float = 4.0
func _ready():

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _input(event):

	if     event is InputEventMouseMotion :
		
		var mouseVec : Vector2 = event.get_relative()
		
		yaw = fmod(yaw  - mouseVec.x * Constants.MOUSE_SENSITIVITY , 360.0)

		
		camera.set_rotation(Vector3(deg2rad(camera.global_transform.basis.get_euler().y), deg2rad(yaw), 0.0))
		camera.set_translation(origin - dist * camera.project_ray_normal(get_viewport().get_visible_rect().size * 0.5))
		
