class_name Input_combat_player_controller
extends player_controller

func _init(_parent_ : Node):
		self.parent = _parent_
		
		

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func start_() -> void:


		get_tree().current_scene.get_node("CanvasLayer/TextureRect").get_node("rotate").connect("button_down",self,"_rotate",[])
		get_tree().current_scene.get_node("CanvasLayer/TextureRect").get_node("rotate").connect("button_up",self,"_rotate_end",[])
		get_tree().current_scene.get_node("CanvasLayer/TextureRect").get_node("attack_button").connect("button_down",self,"_attack",[])
		get_tree().current_scene.get_node("CanvasLayer/TextureRect").get_node("touch_button").connect("button_down",self,"_interact",[])
		get_tree().current_scene.get_node("CanvasLayer/TextureRect").get_node("attack_push").connect("button_down",self,"_attack",[])
		get_tree().current_scene.get_node("CanvasLayer/TextureRect").get_node("shoot_button").connect("button_down",self,"_attack",[])

		
		#mobile_
		get_tree().current_scene.get_node("CanvasLayer/TextureRect").get_node("back_button_t").connect("pressed",self,"inventory_open_close",[])
		get_tree().current_scene.get_node("CanvasLayer/TextureRect").get_node("attack_button_t").connect("pressed",self,"_attack",[0])
		get_tree().current_scene.get_node("CanvasLayer/TextureRect").get_node("touch_button_t").connect("pressed",self,"_interact",[])
		get_tree().current_scene.get_node("CanvasLayer/TextureRect").get_node("attack_push_t").connect("pressed",self,"_attack",[1])
		get_tree().current_scene.get_node("CanvasLayer/TextureRect").get_node("shoot_button_t").connect("pressed",self,"_attack",[2])

var input_ : Vector3
var index_attack : int
		# Called when the node enters the scene tree for the first time.

func  _attack(_index_):
		index_attack = _index_
		_attack_command.execute(parent,self)

func  _interact():
		_interact_command.execute(parent,self)
		
func  inventory_open_close():
		_inventory_command.execute(parent,self)


onready var last_pos_proxy  = parent.global_transform.origin
onready var last_pos  = parent.global_transform.origin
var delta_check_for_movement := 0.0
func _process(delta):

		if get_tree().current_scene.get_turn_from_name(parent) == null:
						return

		if get_tree().current_scene.get_turn_from_name(parent).current_turn_caracter == parent:
				_get_model_oriented_input()

				if input_ != Vector3.ZERO:
							delta_check_for_movement = delta_check_for_movement + delta

							if delta_check_for_movement >= 1.5:
									delta_check_for_movement = 0.0
									get_tree().current_scene.get_turn_from_name(parent).switch_current_turn_caracter(parent)
									delta_check_for_movement = 0.0
				else:
							delta_check_for_movement = 0.0
		else :
			delta_check_for_movement = 0.0
			input_  = Vector3.ZERO
			_input_command.execute(parent,self)
		
func _get_model_oriented_input():
	
		var input_left_right = (
			
			Input.get_action_strength("ui_left")-
			
			Input.get_action_strength("ui_right")
			
		)
		var input_forward = (

			Input.get_action_strength("ui_up")-

			Input.get_action_strength("ui_down")

		)




		var input := Vector3.ZERO

		input.x = -input_left_right

		input.z = -input_forward
		
		input = input.normalized()
		input = parent.camera.global_transform.basis.xform(input)
		input_ = input

		_input_command.execute(parent,self)

