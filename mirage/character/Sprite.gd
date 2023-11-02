extends Sprite3D


export(int) var collun
var camera : Camera = null

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_camera(c):
	camera = c

var offset_frame = 16
onready var parent : RigidBody = get_parent()

func _ready():
	set_camera(get_viewport().get_camera() )

func _process(delta):
	if camera == null:
			return 

	if parent.get_dir().length() >  .4:

		var p_fwd = -camera.global_transform.basis.z
		var fwd = global_transform.basis.z
		var left = global_transform.basis.x
		
		var left_dot = left.dot(p_fwd)
		
		var fwd_dot = fwd.dot(p_fwd)
		var row_ = 0

		flip_h = false

		if fwd_dot < -0.85:
			row_ = 0

		elif fwd_dot > 0.85:
			row_ = 3
		
		else:

			if abs(fwd_dot) < .3:
					row_ = 2
			elif fwd_dot < 0:
					row_ = 1

			else:

				row_ = 3


		if left_dot > 0:
				flip_h = false

		else:
				flip_h = true

		row_ = row_ + 4

		if row_  >   7:
			row_ = 7

		var frame_ =  collun + row_ * 4 

		frame  = frame_

	elif parent.select_npc_actiion == parent.possible_npc_actions.NPC_ATTACK:

		var p_fwd = -camera.global_transform.basis.z
		var fwd = global_transform.basis.z
		var left = global_transform.basis.x
		
		var left_dot = left.dot(p_fwd)
		
		var fwd_dot = fwd.dot(p_fwd)
		var row_ = 0

		flip_h = false

		if fwd_dot < -0.85:
			row_ = 8

		elif fwd_dot > 0.85:
			row_ = 3

		else:

			if abs(fwd_dot) < .3:
					row_ = 2

			elif fwd_dot < 0:
					row_ = 1


			else:
				row_ = 3

		if left_dot > 0:
				flip_h = false

		else:
				flip_h = true



		row_ = row_ + 4

		if row_  >   8:
			row_ = 8

		var frame_ =  collun + row_ * 4 

		frame  = frame_

	elif parent.get_dir().length() <  .3:
		var p_fwd = -camera.global_transform.basis.z
		var fwd = global_transform.basis.z
		var left = global_transform.basis.x
		
		var left_dot = left.dot(p_fwd)
		
		var fwd_dot = fwd.dot(p_fwd)
		var row = 0

		flip_h = false

		if fwd_dot < -0.85:
			row = 0

		elif fwd_dot > 0.85:
			row = 3

		else:

			if abs(fwd_dot) < .3:
					row = 2
			elif fwd_dot < 0:
					row = 1
			else:
				row = 3

		if left_dot > 0:
				flip_h = false

		else:
				flip_h = true


		var frame_ =  collun + row  * 4 

		frame = frame_

