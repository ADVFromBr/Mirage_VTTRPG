extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var camera_ = get_parent().get_node("Camera")
onready var buttons = get_tree().current_scene.get_node("CanvasLayer").get_node("TextureRect")
onready var sprite = get_tree().current_scene.get_node("CanvasLayer").get_node("TextureRect").get_node("current_holding")
onready var sprite_in_hand = get_parent().get_node("Camera").get_node("Hand")
export (int) var collun
onready var animation_player = get_parent().get_node("AnimationPlayer")
onready var raycast = get_parent().get_node("interactor")
var can_use : bool = true
onready var parent = get_parent()
func _ready():
		get_tree().current_scene.get_node("CanvasLayer/Inventory").connect("update_weapon_item_array",self,"update_weapon_item_array",[])
		for i in PlayeerStat.items_in_hand_:
			if i.slot == "R_HAND":
					sprite.set_texture (load(i.icon))
					items_hand_ = i
					print(items_hand_.name)
					
func set_can_use(_can_use_):
	can_use = _can_use_
	if !items_hand_:
		return
	for items in items_hand_.type_fyre:
		if items == Item.type_fyre.FIRE_BEEN:
				buttons.get_node("punch").visible = can_use
		elif items == Item.type_fyre.GRAB_PHYSICS:
				buttons.get_node("grab").visible = can_use
							
		elif items == Item.type_fyre.MUSK_SHOOT:
				buttons.get_node("shoot").visible = can_use
							

var last_hit : RigidBody

var items_hand_
# Called when the node enters the scene tree for the first time.
func update_weapon_item_array(item):
		if item:
			if item.type == "weapon":
				if items_hand_== null:
						print(item.name)
						items_hand_ = item
						sprite.set_texture ( load(item.icon) )
						
						for items in item.type_fyre:
							if items == Item.type_fyre.FIRE_BEEN:
								buttons.get_node("punch").visible = true
							elif items == Item.type_fyre.GRAB_PHYSICS:
								buttons.get_node("grab").visible = true
							
							elif items == Item.type_fyre.MUSK_SHOOT:
								buttons.get_node("shoot").visible = true
							

		else:
			if items_hand_:				
						items_hand_ = null
						sprite.set_texture(null)
						print("remmoved ")

						buttons.get_node("punch").visible = false

						buttons.get_node("grab").visible = false
							

						buttons.get_node("shoot").visible = false
							

func reset_node():
		last_hit = null


func _continue_attacking():
		if last_hit:
				var rayEnd = (-camera_.global_transform.basis.z + camera_.global_transform.basis.y)  * 8 + last_hit.global_transform.basis.z

				print(last_hit.name)
				print(last_hit.get_dir())
				last_hit.set_dir(rayEnd)
				get_tree().create_timer(.01).connect("timeout",self,"_continue_attacking",[])

func type_fyre_selector(type,node_):
		node_.mode = RigidBody.MODE_CHARACTER
		var value = get_tree().current_scene.rool_a_d_twenty(self,parent.get_canva_(),"combat")
		print(value)
		if type == Item.type_fyre.PUSH:
			node_.set_dir(	node_.global_transform.origin - node_.global_transform.basis.z * 22)
			node_.select_npc_actiion = node_.possible_npc_actions.NPC_ATTACK
		elif type == Item.type_fyre.FIRE_BEEN:
			var space_state = raycast.get_world().direct_space_state
			var mouse_position = camera_.global_transform.origin
			var rayOrigin = mouse_position
			var rayEnd = rayOrigin -  camera_.global_transform.basis.z * Item.get_item(items_hand_.name)["range"]  
			var intersection = space_state.intersect_ray(rayOrigin, rayEnd)
			if not intersection.empty():
				if intersection.collider != get_parent():
					if intersection.collider.name != get_parent().name:
							if intersection.collider == null:
								return
							if intersection.collider.has_method("decrease_health"):
								intersection.collider.decrease_health(Item.get_item(items_hand_.name)["damage"] + value)
								get_tree().create_timer(.9).connect("timeout",self,"play_sound_hit",[intersection.collider])
								init_attack(intersection.collider)
		elif type == Item.type_fyre.GRAB_PHYSICS:
				node_.select_npc_actiion = node_.possible_npc_actions.NPC_HOLD
				last_hit = node_
				get_tree().create_timer(.01).connect("timeout",self,"_continue_attacking",[])

		elif type == Item.type_fyre.MUSK_SHOOT:


			var space_state = raycast.get_world().direct_space_state
			var mouse_position = camera_.global_transform.origin
			var rayOrigin = mouse_position
			var rayEnd = rayOrigin -  camera_.global_transform.basis.z * Item.get_item(items_hand_.name)["range"] 
			var intersection = space_state.intersect_ray(rayOrigin, rayEnd)
			if not intersection.empty():
				if intersection.collider != get_parent():
					if intersection.collider.name != get_parent().name:
							if intersection.collider == null:
								return
							if intersection.collider.has_method("decrease_health"):
								intersection.collider.decrease_health(Item.get_item(items_hand_.name)["damage"]  + value)
								get_tree().create_timer(.9).connect("timeout",self,"play_sound_hit",[intersection.collider])
								init_attack(intersection.collider)
func _reset_anim_player():
				sprite_in_hand.set_texture ( null )
				
func play_sound_hit(col_):

		get_parent().get_node("damage").play()

func init_attack(node):

	
	if get_tree().current_scene.get_turn_from_name(parent) == null:
		get_tree().current_scene.set_turn(parent)
		node.set_player(parent)
		get_tree().current_scene.get_turn_from_name(parent).add_to_turn_caracters_array(node)
			
		get_tree().current_scene.get_turn_from_name(parent).add_to_turn_caracters_array(parent)

		if get_tree().current_scene.get_turn_from_name(parent).current_turn_caracter == null:
					get_tree().current_scene.get_turn_from_name(parent).current_turn_caracter  = node



func attack(int_index):
		if can_use:
			sprite_in_hand.set_texture ( load(items_hand_.hold) )
			animation_player.play("sprite")
			var space_state = raycast.get_world().direct_space_state
			var mouse_position = camera_.global_transform.origin
			parent.play_sound(items_hand_.sound)
			var rayOrigin = mouse_position
			var rayEnd = rayOrigin -  camera_.global_transform.basis.z * 311
			var intersection = space_state.intersect_ray(rayOrigin, rayEnd)
			if not intersection.empty():
				if intersection.collider == null:
					return
				
				if intersection.collider != get_parent():
					if intersection.collider.name != get_parent().name:
							if intersection.collider == null:
								return

							if intersection.collider.has_method("decrease_health"):
								last_hit = intersection.collider


									
								type_fyre_selector(int_index,intersection.collider)

			if get_tree().current_scene.get_turn_from_name(parent) == null:
						return

			get_tree().current_scene.get_turn_from_name(parent).switch_current_turn_caracter(parent)
