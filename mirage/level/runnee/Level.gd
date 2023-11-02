extends Spatial

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
	if name == "fight":
								var npc_instance = load(init_ramdom_npc()).instance()
								get_node("Unverse/SolarSystemDemo/EarthlikePlanet").add_child(npc_instance)
								npc_instance.global_transform.origin = get_node("Unverse").get_node("SolarSystemDemo").get_node("EarthlikePlanet").get_node("NPC_Pos").global_transform.origin
								print(npc_instance.name)
	if has_node("Unverse"):
					if has_node("SolarSystemDemo"):
						if has_node("EarthlikePlanet"):
							for i_ in get_children():
								if	i_.has_method("decrease_health"):
										i_.mode = RigidBody.MODE_KINEMATIC

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
		
		print("Body entered")
		
		if body.name == "Player":

				if !PlayeerStat.next_city.empty():
						
						if name == "fight":
							PlayeerStat.distance_to_next = PlayeerStat.distance_to_next - 1
							print(name)
							
						if PlayeerStat.distance_to_next <= 1:
					
							end(PlayeerStat.next_city)
							
						else:
								end("fight")
					
				else:
						end("world")
				
		print("body failed")



func _on_Area_body_exited(body):
	leave_entered(body)

func _on_Leave_town_body_exited(body):
	leave_entered(body)
