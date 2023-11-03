extends char_

const Constants := preload("../constants.gd")
const MAXVELOCITY := 50.0
const ROTATIONSPEED := 0.5
const SPEED_INCREMENT := 0.8
const SPEED_SCALE_MAX := 0.05
var floor_normal

var should_reset := false


var _last_strong_direction_ := Vector3.FORWARD
var local_gravity := Vector3.DOWN
onready var camera :Camera = get_node("Camera")
onready var interactor : RayCast = get_node("interactor")

const bob_frequency = 3.3
const bob_amplitude = .05
var d_bob  = 0 

var speed := 5.5
var can_rotate := false
onready var tween = $Tween

onready var weapon = get_node("weapon")
onready var item_ = get_node("item")
signal speed_scale_changed(value)

var impulse := Vector3.ZERO
var rotation_basis := transform.basis
var apply_rotation := false
onready var heat_ = get_tree().current_scene.get_heat() 
var attacking_: bool = false

onready var controller_node : Node = get_node("controller_container")



var _player_controller_ : player_controller
func _set_controller(controller_node_input : player_controller) -> void:
		for i in controller_node.get_children():
			i.queue_free()
		_player_controller_ = controller_node_input
		controller_node.add_child(controller_node_input)

		get_tree().create_timer(.5).connect("timeout",self,"ini_controller_node_child",[controller_node_input])

func ini_controller_node_child(controller_node_input):

		for i in controller_node.get_children():
			i.start_()

# Called when the node enters the scene tree for the first time.
func orient_character_to_dir_(var dir : Vector3, delta : float):

	var dir_ := dir -global_transform.origin
	dir_ = -dir_
	dir_ = dir_.normalized()
	var left_axis := -local_gravity.cross(dir_)

	var rotation_basis := Basis(left_axis, -local_gravity,dir_).orthonormalized()

	camera.global_transform.basis = camera.global_transform.basis.get_rotation_quat().slerp(

																		rotation_basis, delta * 1.2


													)
func tween_heat(_heat_):
		set_heat(_heat_)

func animation_finished(anim_):
	
	if anim_ == "end":
		if name_door.length() > 0:
			get_tree().current_scene.switch_level(name_door)


func set_collision(state):
	if state :


		if 	mode == MODE_STATIC:
				get_tree().current_scene.start()
				started = true
				print(name + " is enabled")
				mode = MODE_CHARACTER

	else:
		if 	started == false:
			print(name + " is desabled")
			mode = MODE_STATIC




var name_door = ""


func reset_inventory():
		PlayeerStat.items_inventory_bag = []
		PlayeerStat.items_in_hand_ = []

		for i in get_tree().current_scene.get_node("CanvasLayer/Inventory").eq_slots.item_inside_array: 
					PlayeerStat.items_in_hand_.append(Item.get_item(i.name))
				
		for i in get_tree().current_scene.get_node("CanvasLayer/Inventory").grid_bkpk.items_:
					PlayeerStat.items_inventory_bag.append(Item.get_item(i.name))  
						
	
		get_tree().current_scene.get_node("CanvasLayer/Inventory")._init_func("")

signal open_close_menu(visibility_)

func inventory_open_close():
		get_tree().current_scene.get_node("CanvasLayer/Inventory").set_player_(self)
		if get_tree().current_scene.get_node("CanvasLayer/Inventory").visible == true:
			get_tree().current_scene.get_node("CanvasLayer/Inventory").visible = false


		elif get_tree().current_scene.get_node("CanvasLayer/Inventory").visible == false:
			if get_tree().current_scene.get_node("CanvasLayer/Control").visible == false:
				get_tree().current_scene.get_node("CanvasLayer/Inventory").visible = true
				reset_inventory()

		emit_signal("open_close_menu",get_tree().current_scene.get_node("CanvasLayer/Inventory").visible)

func _ready():
		set_heat(get_tree().current_scene.get_heat())
		tween.interpolate_method (self, "tween_heat", PlayeerStat.last_tempeture, heat_, 277, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		_set_controller(Input_player_controller.new(self))
		set_heat(get_tree().current_scene.get_heat())
		tween.interpolate_method (self, "tween_heat", PlayeerStat.last_tempeture, heat_, 277, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		set_health(PlayeerStat.get_player_health())
		get_tree().current_scene.connect("_mode_switched_combat_on_off",self,"_mode_switched_combat_on_off_",[])	

func decrease_health(amount_of_health_decrease : int):
	var new_health = health + armor_- amount_of_health_decrease 
	new_health = new_health 
	if new_health > max_health:
		new_health = max_health
	
	set_health(new_health - (heat_ *.1))
	emit_signal("health_value_changed",get_health())
	select_npc_actiion = possible_npc_actions.NPC_ATTACK


var turn_started := false




func open_book():
	
	if !get_canva_().has_node("tutorial"):
			var tutorial_ = load("res://textures/ui/tutorial.tscn").instance()
			get_canva_().add_child(tutorial_)
	else:
		get_canva_().get_node("tutorial").queue_free()
	


func end_turn():
	get_tree().current_scene.end_turn(self)

func _mode_switched_combat_on_off_(node_,_size_):
		if node_ == self:
			if _size_ > 1 :
					_set_controller(Input_combat_player_controller.new(self))
					turn_started = true
			elif _size_ < 2:
							_set_controller(Input_player_controller.new(self))
							print("mode switched")
							if turn_started:
								get_tree().create_timer(1).connect("timeout",self,"end_turn",[])
								turn_started = false


		if _size_ < 2:
							_set_controller(Input_player_controller.new(self))
							print("mode switched")
							if turn_started:
								get_tree().create_timer(1).connect("timeout",self,"end_turn",[])
								turn_started = false

func hestore_health(helth_ : int):
	tween.interpolate_method (self, "_hestore_health_twean", get_health(), helth_, 8, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _hestore_health_twean(helth_):
	emit_signal("heat_value_changed",get_heat())
	health = helth_
	if health > max_health:
		health = max_health

	emit_signal("health_value_changed",get_health())



func _interact():
	play_sound("res://sfx/UI/click.wav")
	interactor._interact()
func _on_Timer_timeout():
	weapon.set_can_use(true)

func get_Inventory():
	return Inventory

func get_canva_():
	return get_tree().current_scene.get_node("CanvasLayer")

onready var add_menu  = get_tree().current_scene.get_node("CanvasLayer/Inventory")
onready var Inventory  = get_tree().current_scene.get_node("CanvasLayer/Inventory")
onready var canva_  = get_tree().current_scene.get_node("CanvasLayer")
onready var dialogue	= get_tree().current_scene.get_node("CanvasLayer/Control")

func _process(delta):


		if get_health() <= 0:
			get_tree().current_scene.end("dungeon")




func _attack_3():
	if weapon.items_hand_:
			if weapon.items_hand_.type_fyre.has(Item.type_fyre.MUSK_SHOOT):
					if Inventory.visible == false:
						if dialogue.visible == false:
								weapon.attack(Item.type_fyre.MUSK_SHOOT)

								weapon.set_can_use(false)
								get_tree().create_timer(3).connect("timeout",self,"_on_Timer_timeout",[])
	if item_._items_hand_:
				if Inventory.visible == false:
					if dialogue.visible == false:
							item_.use_item()


func _attack_2():
	if weapon.items_hand_:
			if weapon.items_hand_.type_fyre.has(Item.type_fyre.GRAB_PHYSICS):
					if Inventory.visible == false:
						if dialogue.visible == false:
								weapon.attack(Item.type_fyre.GRAB_PHYSICS)

								weapon.set_can_use(false)
								get_tree().create_timer(3).connect("timeout",self,"_on_Timer_timeout",[])
	if item_._items_hand_:
				if Inventory.visible == false:
					if dialogue.visible == false:
							item_.use_item()

func _attack():
	if weapon.items_hand_:
			if weapon.items_hand_.type_fyre.has(Item.type_fyre.FIRE_BEEN):
					if Inventory.visible == false:
						if dialogue.visible == false:
								weapon.attack(Item.type_fyre.FIRE_BEEN)

								weapon.set_can_use(false)
								get_tree().create_timer(3).connect("timeout",self,"_on_Timer_timeout",[])
	if item_._items_hand_:
				if Inventory.visible == false:
					if dialogue.visible == false:
							item_.use_item()

func attack(_index_):
		if _index_ == 0:
			_attack()
		elif _index_ == 1:
			_attack_2()
		elif _index_ == 2:
			_attack_3()

func _input(event):
	if Inventory.visible == false:
		if dialogue.visible == false:
			if can_rotate:
				if     event is InputEventMouseMotion :
						if Input.mouse_mode ==	Input.MOUSE_MODE_CAPTURED:
							var _mouse_speed = event.relative * Constants.MOUSE_SENSITIVITY

							camera.rotate(camera.transform.basis.y.normalized(), deg2rad(-_mouse_speed.x))
			if can_rotate:
				if     event is InputEventScreenTouch :
						if Input.mouse_mode ==	Input.MOUSE_MODE_CAPTURED:
							var _mouse_speed = event.relative * Constants.MOUSE_SENSITIVITY

							camera.rotate(camera.transform.basis.y.normalized(), deg2rad(-_mouse_speed.x))

			elif !can_rotate:
				if     event is InputEventMouseMotion :
					if Input.is_action_pressed("inv_grab"):	
							var _mouse_speed = event.relative * Constants.MOUSE_SENSITIVITY

							camera.rotate(camera.transform.basis.y.normalized(), deg2rad(-_mouse_speed.x))

func _rotate_end():
			Input.set_mouse_mode( Input.MOUSE_MODE_VISIBLE )
			if can_rotate == true:
				can_rotate = false

func _rotate():
			Input.set_mouse_mode( Input.MOUSE_MODE_CAPTURED )
			if can_rotate == false:
				can_rotate = true

func _integrate_forces(var state: PhysicsDirectBodyState):

	local_gravity = state.total_gravity.normalized()
	meve_dir_proxy = move_dir


	d_bob += state.step * ( get_linear_velocity()   * .5 ).length()
	if  move_dir != Vector3.ZERO and !footstep.is_playing():
			play_footstep_sound()

	orient_character_to_dir(local_gravity + move_dir, state.step)
	

	camera.transform.origin = handle_bob(d_bob) + camera.transform.basis.y  * 1.2 + + camera.transform.basis.z  * .3

	set_linear_velocity(((local_gravity) * 2.4) + (move_dir * speed ))


func orient_character_to_dir(var dir : Vector3, delta : float):

	var left_axis := -local_gravity.cross(camera.global_transform.basis.z)

	var rotation_basis := Basis(left_axis, -local_gravity, camera.global_transform.basis.z).orthonormalized()

	camera.global_transform.basis = camera.global_transform.basis.get_rotation_quat().slerp(

																rotation_basis, delta * 2
	)

func move(move_dir_):
	move_dir = move_dir_
func init_physics():
	mode = MODE_CHARACTER

func handle_bob(delta) -> Vector3: 
	var pos = Vector3.ZERO
	pos.y = sin(delta * bob_frequency) * bob_amplitude
	return pos
