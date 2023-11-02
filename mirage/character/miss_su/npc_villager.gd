extends npc_talk


const MAXVELOCITY := 50.0
const ROTATIONSPEED := 0.5
const SPEED_INCREMENT := 0.8
const SPEED_SCALE_MAX := 0.05
var floor_normal



onready var current_pos = global_transform.origin




var _last_strong_direction_ := Vector3.FORWARD
var local_gravity_ := Vector3.DOWN


const bob_frequency = 4.5
const bob_amplitud = .003
var d_bob  = 0 

onready var initial_pos_ = global_transform.origin
func get_initial_pos():
	return initial_pos_

var speed = 8
onready var sprite_3d_without_health = preload("res://character/death.tscn")



onready var sprite = get_node("Sprite3D")

onready var npc_behavior_tree = get_node("NPC_Behavior_tree")
onready var npc_behavior_walk = get_node("NPC_Behavior_tree").get_node("walk_random")

signal speed_scale_changed(value)

var impulse := Vector3.ZERO
var rotation_basis := transform.basis
var apply_rotation := false

func _ready():
	set_npc_name()



func _process(delta):

	npc_behavior_tree.current_action(self,player_,path_node,path,delta)

	if get_health() <= 0:
			var sprite_3d_without_health_instance = sprite_3d_without_health.instance()
			get_parent().add_child(sprite_3d_without_health_instance)
			sprite_3d_without_health_instance.global_transform.origin = global_transform.origin
			sprite_3d_without_health_instance.global_transform.basis = global_transform.basis

			sprite_3d_without_health_instance.get_node("Sprite3D").set_texture( sprite.texture )
			sprite_3d_without_health_instance.get_node("Sprite3D").hframes = 4
			sprite_3d_without_health_instance.get_node("Sprite3D").vframes = 15
			sprite_3d_without_health_instance.get_node("Sprite3D").frame = 32 
			queue_free()

func orient_character_to_dir_(var dir : Vector3, delta : float):

	
	var left_axis := -local_gravity_.cross(dir)

	var rotation_basis := Basis(left_axis, -local_gravity_, dir).orthonormalized()

	global_transform.basis = global_transform.basis.get_rotation_quat().slerp(

																rotation_basis, delta * 114

	)

func get_dir():

	return move_dir  * speed

func _integrate_forces(var state: PhysicsDirectBodyState):
	local_gravity_ = state.total_gravity.normalized()

	set_linear_velocity(local_gravity_ +  move_dir * speed )
	var meve_dir_proxy = move_dir
	if  move_dir != Vector3.ZERO and !footstep.is_playing():
			play_footstep_sound()

	orient_character_to_dir_((rot_dir) + (global_transform.basis.x * 111), state.step)
