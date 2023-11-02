extends npc_talk
class_name npc_merchant_court

const MAXVELOCITY := 50.0
const ROTATIONSPEED := 0.5
const SPEED_INCREMENT := 0.8
const SPEED_SCALE_MAX := 0.05
var floor_normal



var should_reset := false

onready var current_pos = global_transform.origin

var _last_strong_direction_ := Vector3.FORWARD
var local_gravity := Vector3.DOWN
onready var npc_behavior_tree = get_node("NPC_Behavior_tree")

export (int) var distance = 3

export (int) var damage_ = 7
export (int) var range_ = 51



var speed = 5
onready var sprite_3d_without_health = preload("res://character/death.tscn")
onready var current_look_at = Vector2(global_transform.origin.z,global_transform.origin.x)


onready var sprite = get_node("Sprite3D")



func _process(delta):
		

		if get_health() <= 0:
			var sprite_3d_without_health_instance = sprite_3d_without_health.instance()
			get_parent().add_child(sprite_3d_without_health_instance)
			sprite_3d_without_health_instance.global_transform.origin = global_transform.origin
			sprite_3d_without_health_instance.global_transform.basis = global_transform.basis
			
			sprite_3d_without_health_instance.get_node("Sprite3D").texture = sprite.texture
			sprite_3d_without_health_instance.get_node("Sprite3D").hframes = 4
			sprite_3d_without_health_instance.get_node("Sprite3D").vframes = 15
			sprite_3d_without_health_instance.get_node("Sprite3D").frame = 36 
			queue_free()

func orient_character_to_dir(var dir_  : Vector3, delta : float):


	if dir_ == Vector3.ZERO:
		return
		
	var left_axis := -local_gravity.cross(dir_)

	var rotation_basis := Basis(left_axis, -local_gravity,dir_).orthonormalized()

	global_transform.basis = global_transform.basis.get_rotation_quat().slerp(

																rotation_basis, delta * 2

		)



func _integrate_forces(var state: PhysicsDirectBodyState):	
		set_dir( Vector3.ZERO)
		local_gravity = state.total_gravity.normalized()
				
		npc_behavior_tree.current_action(self,player_char,path_node,path,state.step)
		set_linear_velocity((local_gravity * 3) + move_dir)
		orient_character_to_dir(-move_dir.normalized(), state.step)
		
		print(rot_dir)
		
		if  move_dir != Vector3.ZERO and !footstep.is_playing():
			play_footstep_sound()

func _attack_timer():
			get_tree().create_timer(5.7).connect("timeout",self,"_attack_timer",[])

func _on_Timer_timeout():
			if select_npc_actiion == possible_npc_actions.NPC_WALK or select_npc_actiion == possible_npc_actions.NPC_ATTACK:
					print("timer is out")
					get_model_dir( player_char.global_transform.origin )	
					get_tree().create_timer(0.8).connect("timeout",self,"_on_Timer_timeout",[])
					
