extends RigidBody
class_name char_


export(int)var health : int =  100
var max_health = health
var path = []
var path_node = 0
onready var _start_position := global_transform.origin
onready var footstep : AudioStreamPlayer3D = get_node("footstep")
onready var item_sound : AudioStreamPlayer3D = get_node("item_sound")
onready var a_star_grid = get_tree().get_current_scene().get_node("Unverse")
signal health_value_changed(amount_)
signal armor_value_changed(amount_)
signal heat_value_changed(amount_)
var move_dir := Vector3.ZERO
var items := []


func get_item_sound():
	return item_sound

var current_enemy : RigidBody = null

func enemy_fight(value):
	if value <= 0:
		current_enemy = null
func set_current_enemy(next_enemy):

	current_enemy = next_enemy

func get_current_enemy():
	return current_enemy 


var started := false
	
func set_collision(state):
	if started == true:
		return
	
	if state :
				mode = MODE_CHARACTER
				started = true
	else:
				mode = MODE_STATIC


enum possible_npc_actions{
	NPC_WALKING_STOP,
	NPC_TALK,
	NPC_WALK,
	NPC_WALK_RAMDOM,
	NPC_EAT,
	NPC_ATTACK,
	NPC_WALK,
	NPC_STAY,	
	NPC_HOLD

	
}


var rot_dir = Vector3.ZERO

func set_rot_dir(_rot_dir):
	rot_dir = _rot_dir
	
var player_char : RigidBody = null
var on_ready_set_action = select_npc_actiion

func get_model_dir(target_pos_ : Vector3):
		path_node = 0
		path = a_star_grid.find_path(global_transform.origin,target_pos_)
	
func set_player(_player_ : RigidBody):
		player_char = _player_

var armor_ := 0

func set_armor(_armor_):
	
	armor_ = _armor_
	emit_signal("armor_value_changed",armor_)
	print(armor_)
var heat = 39
var meve_dir_proxy := move_dir

func set_move_dir_proxy(var_meve_dir_proxy):
	meve_dir_proxy = var_meve_dir_proxy

export(possible_npc_actions) var select_npc_actiion = possible_npc_actions.NPC_WALK_RAMDOM

func set_health(helth_ : int):
	emit_signal("health_value_changed",helth_)
	health = helth_
func get_dir():
	return move_dir

func set_heat(heat_ : int):
	heat = heat_
	emit_signal("heat_value_changed",get_heat())

func hestore_health(helth_ : int):
	health = helth_


func get_heat():
	return heat
	
func get_dir_():
	return move_dir
func set_dir(dir_):
 set_move_dir_proxy(move_dir)
 move_dir = dir_

func play_sound(path_sound_):
		if path_sound_.length() > 0:
			item_sound.set_stream(load(path_sound_))
		
		item_sound.play()
func stop_footstep_sound():
		if !footstep.is_playing():
			return
		footstep.stop()
		
onready var start_pos = global_transform.origin
func get_initial_pos():
	return start_pos
	
func play_footstep_sound():
		if footstep.is_playing():
			return
		footstep.play()



		get_tree().create_timer(footstep.get_stream().get_length()).connect("timeout",self,"footstep_sound_modulate",[])
func  footstep_sound_modulate():
		footstep.set_pitch_scale(rand_range(1,1.5))
		
func stop_footstep_sound_modulate():
				footstep.stop()

func decrease_health(amount_of_health_decrease : int):
	var new_health = health + armor_ - amount_of_health_decrease 

	if new_health <= 0:
			PlayeerStat.deleted_npcs.append(name)
			if has_node("inventory"):
					get_node("inventory").item_spawn()
	
	if player_char:
		if get_tree().current_scene.get_turn_from_name(player_char) != null:
				if new_health <= 0:
						get_tree().current_scene.get_turn_from_name(player_char).remove_from_turn_caracters_array(self)
						PlayeerStat.emit_signal("player_ran",-1)
						print("from_array")
	set_health(new_health)
	emit_signal("health_value_changed",get_health())
	select_npc_actiion = possible_npc_actions.NPC_ATTACK


func get_health():
	return health

	
