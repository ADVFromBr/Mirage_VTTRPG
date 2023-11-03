extends Spatial
class_name level_

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player_
onready var canvas = get_node("CanvasLayer/Inventory")
const Const := preload("res://addons/hoimar.planetgen/scripts/constants.gd")
func init_universe(i_):
			i_.connect("current_collision", self, "update_check_collision", [])
				
onready var scene_fade = get_tree().current_scene.get_node("CanvasLayer").get_node("fade")
export var heat_ := 30


func get_heat():
	return heat_
var _name_door := ""
func start():
				get_tree().current_scene.get_node("CanvasLayer/fade/AnimationPlayer").play("start")
				get_tree().create_timer(2).connect("timeout",self,"set_player",[])

func set_player():
					if  get_tree().get_nodes_in_group("player").size() > 0:
						for i in get_tree().get_nodes_in_group("player"):
							if i != null:
								print(i.name + " is name of player ")
								var roll_d20_start = rool_a_d_twenty_casuallity(i,i.get_canva_())
								var _ramdom_integer_for_ramdom_casuality_event = randi() % AntithesiSystem.list_of_var_array_for_casuality_effect_.size() -1
								if roll_d20_start  > 15:
										AntithesiSystem.list_of_var_array_for_casuality_effect_[_ramdom_integer_for_ramdom_casuality_event ] = true
								elif roll_d20_start  <= 15   and  roll_d20_start  > 5:
											AntithesiSystem.list_of_var_array_for_casuality_effect_[_ramdom_integer_for_ramdom_casuality_event ] = false
								else:
									for i_ in AntithesiSystem.list_of_var_array_for_casuality_effect_:
											i_ = !i_

func animation_finished(name_anim):
		if name_anim == "end":
			switch_level(_name_door)
func end(_name_door_):
		anim.play("end")
		_name_door = _name_door_ 

func init_ramdom_npc():

		var ramdom_key =  Globals.npc_list.keys()[randi() % Globals.npc_list.size() - 1]
		print(Globals.npc_list.get(ramdom_key))
		return Globals.npc_list.get(ramdom_key)

var message_sent = false
func _on_Timer_timeout():
						message_sent = true
						get_tree().create_timer(.2).connect("timeout",self,"_on_Timer_timeout",[])

func _on_Timer_timeout_():
						message_sent = false
onready var anim = get_node("CanvasLayer/fade/AnimationPlayer")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	get_tree().current_scene.get_viewport()
	get_node("CanvasLayer/fade/AnimationPlayer").connect("animation_finished",self,"animation_finished",[])
	print(name)

	if has_node("Unverse"):
					if !get_node("Unverse").has_node("SolarSystemDemo"):
						get_node("Unverse")._init_a_star(2.0,2.5)
						start()
				


	else:
						start()
	if has_node("Unverse"):
					if has_node("SolarSystemDemo"):
						if has_node("EarthlikePlanet"):
							for i_ in get_children():
								if	i_.has_method("decrease_health"):
										i_.mode = RigidBody.MODE_KINEMATIC

	if name == "fight":

					print(- AntithesiSystem.number_of_ramdom_encounter_adding_ * 2)
					var npc_instance = load(init_ramdom_npc()).instance()
					get_node("Unverse/SolarSystemDemo/EarthlikePlanet").add_child(npc_instance)
					npc_instance.global_transform.origin = get_node("Unverse").get_node("SolarSystemDemo").get_node("EarthlikePlanet").get_node("NPC_Pos").global_transform.origin
					print(npc_instance.name)
					npc_instance.mode = npc_instance.MODE_CHARACTER
									
					var npc_instance_two = load(init_ramdom_npc()).instance()
					get_node("Unverse/SolarSystemDemo/EarthlikePlanet").add_child(npc_instance_two)
					npc_instance_two.global_transform.origin = get_node("Unverse").get_node("SolarSystemDemo").get_node("EarthlikePlanet").get_node("NPC_Pos2").global_transform.origin
					npc_instance_two.global_transform.basis =  get_node("Unverse").get_node("SolarSystemDemo").get_node("EarthlikePlanet").get_node("NPC_Pos2").global_transform.basis

					npc_instance_two.mode = npc_instance_two.MODE_CHARACTER

	print(get_children()[0].name)
	for i in get_tree().get_nodes_in_group("npc"):
			if PlayeerStat.deleted_npcs.has(i.name):
					if i.has_method("decrease_health"):
							i.decrease_health(1000000)



	if PlayeerStat.next_spawn_pos_name:
		for i in  get_tree().get_nodes_in_group("gate"):
			if i.name == PlayeerStat.next_spawn_pos_name:
				if get_tree().current_scene.get_viewport().get_camera():
					get_tree().current_scene.get_viewport().get_camera().get_parent().global_transform.origin = i.get_parent().get_node(PlayeerStat.next_spawn_pos_name).global_transform.origin
					PlayeerStat.next_spawn_pos_name = ""

func update_check_collision(enable,pos):
		for i in get_node("Unverse/SolarSystemDemo/EarthlikePlanet").get_children():

				if i.has_method("set_collision"):
					if i.global_transform.origin.distance_to(pos) < Const.MIN_GENERATE_COLLISION :
						i.set_collision(true)
						print("Updated")
					

					else:
						message_sent = false
						i.set_collision(false)
						get_tree().create_timer(.5).connect("timeout",self,"_on_Timer_timeout",[])
						print("Updated")

func switch_level(_name_door_):
		PlayeerStat.items_inventory_bag = []
		PlayeerStat.items_in_hand_ = []
		if _name_door_!= "world" and name != "fight":
			PlayeerStat.last_town = _name_door_
			
		print(_name_door_)
		for i in get_tree().current_scene.get_node("CanvasLayer/Inventory").eq_slots.item_inside_array: 
					PlayeerStat.items_in_hand_.append(Item.get_item(i.name))
				
		for i in get_tree().current_scene.get_node("CanvasLayer/Inventory").grid_bkpk.items_:
					PlayeerStat.items_inventory_bag.append(Item.get_item(i.name))  
						
	
		if get_viewport().get_camera() != null:
			if get_viewport().get_camera().get_parent().has_method("get_health"):
				if get_viewport().get_camera().get_parent().get_health()>0:
					PlayeerStat.set_player_health(get_viewport().get_camera().get_parent().get_health())
				else:
						PlayeerStat.set_player_health(get_viewport().get_camera().get_parent().max_health)
		PlayeerStat.last_tempeture = heat_

		if Globals.leve_level_selector.has(_name_door_):
			
			print(Globals.leve_level_selector.get(_name_door_))
			#if Globals.leve_level_selector.has(name_door):

			if Globals.leave_pos.has(_name_door_):
						print(Globals.leave_pos.get(_name_door_))
						#if player.get_parent().has_node(Globals.leave_pos.get(name_door)):
						PlayeerStat.next_spawn_pos_name = Globals.leave_pos.get(_name_door_)


		
			get_tree().change_scene(Globals.leve_level_selector.get(_name_door_)[0])



func leave_entered(body):
		if body.name == "Player":
			if PlayeerStat.items_inventory_bag.find(Item.get_item("map")) > -1:
				
					print("Body entered")
					if !PlayeerStat.next_city.empty():

							PlayeerStat.distance_to_next = PlayeerStat.distance_to_next - 1
							print(name)
								
							if PlayeerStat.distance_to_next <= 1:
								PlayeerStat.emit_signal("player_traveled",0)
								end(PlayeerStat.next_city)
								PlayeerStat.next_city = ""
							else:
								var random_int_generator =  randi() % 20  
								print (10 - (AntithesiSystem.number_of_ramdom_encounter_adding_ * 2))
								if random_int_generator >= (10 - (AntithesiSystem.number_of_ramdom_encounter_adding_ * 2) +AntithesiSystem.current_distance_traveled_):
									get_tree().current_scene.end("fight")
								elif random_int_generator > 6:
									get_tree().current_scene.end("vallage_ramdom")
								
								elif random_int_generator <= 6:
									get_tree().current_scene.end("dungeon_ramdom")
					else:
						end("world")
				
			else:
				var ramdom_key =  Globals.leve_level_selector.keys()[randi() % Globals.leve_level_selector.size() - 1]
				end(ramdom_key)

			print("body failed")


var current_active_turns := []

func set_turn(char_that_started_fight):
		if !has_node("turn_holder"):
			var turn_holder = Node.new()
			
			add_child(turn_holder)
			turn_holder.name = "turn_holder"

		if has_node("turn_holder"):
			var node_turn_instance = turn_manager.new(char_that_started_fight.name)
			if !get_node("turn_holder").has_node(node_turn_instance.name):
				get_node("turn_holder").add_child(node_turn_instance)

				current_active_turns.append(get_node("turn_holder").get_node(node_turn_instance.name))
				node_turn_instance.connect("_mode_switched_combat_on_off",char_that_started_fight,"_mode_switched_combat_on_off_",[])
				print("turn is set and name is  " + node_turn_instance.name)

func end_turn(name_player_):
		if !has_node("turn_holder"):
				return
		if !get_node("turn_holder").has_node(name_player_.name):
				return


		get_node("turn_holder").get_node(name_player_.name).emit_signal("_mode_switched_combat_on_off",null,1)
		get_node("turn_holder").get_node(name_player_.name).queue_free()

func get_turn_from_name(node_):
		var name_= node_.name
		if !has_node("turn_holder"):
				return null
		if current_active_turns.find(get_node("turn_holder").get_node(name_)) == -1:
			return null
		else:
			return current_active_turns[current_active_turns.find(get_node("turn_holder").get_node(name_))]

func _on_Area_body_exited(body):
	leave_entered(body)

func _on_Leave_town_body_exited(body):
	leave_entered(body)

var dice_roll_type = {
	
	"level_rng" : "Your Luck Has Changed",
	"combat" : " Combat Modifier is:",
	
	
}

func get_dice_type(dice_type):
		if dice_roll_type.has(dice_type):
				return dice_roll_type[dice_type]
		else:
			return "error"

func rool_a_d20_func(node_,ui_,type_roll,d_twenty_,d_twenty_node):
		ui_.add_child(d_twenty_node)
		ui_.move_child(d_twenty_node,ui_.get_child_count())
		d_twenty_node.get_node("D_tweenty").get_node("Value").text = str(d_twenty_)
		d_twenty_node.get_node("text").text = get_dice_type(type_roll)
		
		
		get_tree().create_timer(2).connect("timeout",self,"_on_d_Timer_timeout",[d_twenty_node])


func rool_a_d_twenty(node_,ui_,type_roll):
	var d_twenty_ = randi() % 20
	var d_twenty_node = load("res://ui/d_tweenty.tscn").instance()

	if !ui_.has_node("d_tweenty"):
			rool_a_d20_func(node_,ui_,type_roll,d_twenty_,d_twenty_node)

	else:
			get_tree().create_timer(2).connect("timeout",self,"rool_a_d20_func",[node_,ui_,type_roll,d_twenty_,d_twenty_node])

	return d_twenty_

	
func rool_a_d_twenty_casuallity(node_,ui_):
	var d_twenty_ = randi() % 20
	var d_twenty_node = load("res://ui/d_tweenty_casuall]ity.tscn").instance()
	if !ui_.has_node("d_tweenty"):
			rool_a_d_twenty_casuallity_func(node_,ui_,d_twenty_,d_twenty_node)

	else:
			get_tree().create_timer(2).connect("timeout",self,"rool_a_d_twenty_casuallity_func",[node_,ui_,d_twenty_,d_twenty_node])


	return d_twenty_

func rool_a_d_twenty_casuallity_func(node_,ui_,d_twenty_,d_twenty_node):
	ui_.add_child(d_twenty_node)
	ui_.move_child(d_twenty_node,ui_.get_child_count())
	d_twenty_node.get_node("D_tweenty").get_node("Value").text = str(d_twenty_)
	d_twenty_node.get_node("text").text = get_dice_type("level_rng")
	get_tree().create_timer(2).connect("timeout",self,"_on_d_Timer_timeout",[d_twenty_node])

	
func _on_d_Timer_timeout(d_):
		d_.queue_free()


func _on_Leave_town_body_entered(body):
	pass # Replace with function body.
