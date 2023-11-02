extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var reset_attack = true
export var range_ = 61
export var damage_ = 22

var time_additive_to_turn_off := 0
var attack_delayed := false

func run(node,player_,path_node,path,delta):
					if get_tree().current_scene.get_turn_from_name(player_).current_turn_caracter == node:
							node.select_npc_actiion = node.possible_npc_actions.NPC_ATTACK
							get_tree().create_timer(2.3).connect("timeout",self,"attack_delay_",[node,player_,path,path_node,delta])
							attack_delayed = true
							
func attack_delay_(node,player_,path,path_node,delta):
	if attack_delayed:
		attack_delayed = false
		_attack_(node,player_,path,path_node,delta)
		
func set_self_to_turn_after_delay():
	
	pass

export var time_reset := 3

func _attack_(node,player_,path,path_node,delta):
		attack_(node,player_,path,path_node,delta)
		get_tree().current_scene.get_turn_from_name(player_).switch_current_turn_caracter(node)
		node.select_npc_actiion = node.possible_npc_actions.NPC_WALK
# Called when the node enters the scene tree for the first time.
func attack_(node,player_,path,path_node,delta):
				var d_result = get_tree().current_scene.rool_a_d_twenty(node,player_.get_canva_(),"combat")
				print(name + " is attacking")
				var space_state = node.get_world().direct_space_state
				var start_pos = node.global_transform.origin 
				var rayOrigin = start_pos
				var rayEnd = rayOrigin + (node.global_transform.basis.z * range_)
				var intersection = space_state.intersect_ray(rayOrigin, rayEnd)
				print("decrease_health")

				node.play_sound("")

				if intersection.empty():
					return
				if intersection.collider == null:
					return
				if  intersection.collider != self:
					if intersection.collider.has_method("decrease_health"):
								intersection.collider.decrease_health(damage_ + d_result)
								print(intersection.collider.name + " health deccreased")
