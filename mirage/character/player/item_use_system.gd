extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var camera_ = get_parent().get_node("Camera")
onready var sprite = get_tree().current_scene.get_node("CanvasLayer").get_node("TextureRect").get_node("current_holding")
export (int) var collun
onready var animation_player = get_parent().get_node("AnimationPlayer")
onready var raycast = get_parent().get_node("interactor")
var can_use_ : bool = true
onready var parent = get_parent()

onready var buttons = get_tree().current_scene.get_node("CanvasLayer").get_node("TextureRect")

func _ready():
		get_tree().current_scene.get_node("CanvasLayer/Inventory").connect("update_weapon_item_array",self,"update_weapon_item_array",[])
		for i in PlayeerStat.items_in_hand_:
			if i.slot == "R_HAND":
					sprite.set_texture (load(i.hold))
					_items_hand_ = i
					print(_items_hand_.icon)


var _items_hand_
# Called when the node enters the scene tree for the first time.
func update_weapon_item_array(item):
		if item:
			if item.type != "weapon":
					print(item.name)
					_items_hand_ = item
					sprite.set_texture ( load(item.icon) )


					buttons.get_node("grab").visible = true
											

		else:

						_items_hand_ = null
						sprite.set_texture(null)
						print("remmoved ")
						buttons.get_node("grab").visible = false

func _on_Timer_timeout():
		can_use_ = true
 
func pick_item_inventory(i):
						get_tree().current_scene.get_node("CanvasLayer").get_node("Inventory").pickup_item(i)

func init_item_inventory():
	get_tree().current_scene.get_node("CanvasLayer").get_node("Inventory")._init_func("")
	
func _collect(item_interact):
				if Item.ITEMS.has(_items_hand_.name + "_" + item_interact.name):
						get_parent().play_sound(_items_hand_.sound)
						var _items_hand_proxy = _items_hand_
						get_tree().current_scene.get_node("CanvasLayer").get_node("Inventory").drop_item_in_children(_items_hand_)
						get_tree().current_scene.get_node("CanvasLayer").get_node("Inventory").pickup_item(_items_hand_.name + "_" + item_interact.name)
					#	get_tree().create_timer(.5).connect("timeout",self,"init_item_inventory",[])
						_items_hand_proxy = null
						sprite.set_texture (null)
						_items_hand_ = null


func _drink(item_to_drink):
			get_parent().hestore_health( get_parent().get_health() + _items_hand_.health )
			sprite.set_texture (null)
			get_tree().current_scene.get_node("CanvasLayer").get_node("Inventory").drop_item_in_children(Item.get_item(_items_hand_.name))
			_items_hand_ = null
			sprite.set_texture (null)

func use_item():
			print("Item used")
			if _items_hand_:
				if  _items_hand_.type == "usable_drink":
						_drink(_items_hand_)

						if get_tree().current_scene.get_turn_caracters_array().size() > 0:
											get_tree().current_scene.switch_current_turn_caracter(parent)
						return
				
				elif  _items_hand_.type == "collect":
						var space_state = raycast.get_world().direct_space_state
						var mouse_position = camera_.global_transform.origin + camera_.global_transform.basis.y *.2
						var rayOrigin = mouse_position
						var rayEnd = rayOrigin -  camera_.global_transform.basis.z * 6
						var intersection = space_state.intersect_ray(rayOrigin, rayEnd)
						
						if intersection.collider != null:
							print(intersection.collider.name)
							_collect(intersection.collider)

			if get_tree().current_scene.get_turn_from_name(parent.name) == null:
						return

			get_tree().current_scene.get_turn_from_name(parent.name).switch_current_turn_caracter(parent)
