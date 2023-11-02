extends Spatial

const Constants := preload("../constants.gd")

export var _radius: float = 0.6 setget set_radius, get_radius

onready var player = get_node("Player") 
onready var _camera := $Camera
onready var _tween := $Tween
onready var _org_transform := transform



func _input(event):
	if     event is InputEventMouseMotion \
	   and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED \
	   and Input.is_action_pressed("toggle_camera_mode"):
		var _mouse_speed = event.relative * Constants.MOUSE_SENSITIVITY * 0.05
		rotate(transform.basis.y.normalized(), deg2rad(-_mouse_speed.x))
		rotate(transform.basis.x.normalized(), deg2rad(-_mouse_speed.y))


func set_radius(var new: float):
	_radius = new
	_camera.transform.origin = Vector3.ZERO
	_camera.translate_object_local(Vector3(0, 0, _radius))


func get_radius():
	return _radius
