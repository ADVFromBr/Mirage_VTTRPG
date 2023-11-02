# Global settings for Planet Generator.
tool
extends Node

const Const := preload("../constants.gd")

var wireframe: bool = false setget set_wireframe       # Wireframe mode for newly (?) generated meshes.
var colored_patches: bool   # Colors patches of terrain randomly.
var benchmark_mode: bool   # re-generates planets even if there are still active threads.
var solar_systems: Array = []
var job_queue := JobQueue.new()   # Global queue for TerrainJobs.

func _ready():
	if Const.THREADS_ENABLED:
		set_process(false)   # Otherwise, process queue in single thread.
	

	

func _exit_tree():
	job_queue.clean_up()


func queue_terrain_patch(var data: PatchData) -> TerrainJob:
	var job := TerrainJob.new(data)
	job_queue.queue(job)
	return job


func register_solar_system(var sys: Node):
	solar_systems.append(sys)


func unregister_solar_system(var sys: Node):
	solar_systems.erase(sys)


func set_wireframe(var value: bool):
	wireframe = value
	VisualServer.set_debug_generate_wireframes(value)
	if value:
		get_viewport().set_debug_draw(Viewport.DEBUG_DRAW_WIREFRAME)
	else:
		get_viewport().set_debug_draw(Viewport.DEBUG_DRAW_DISABLED);


func _process(delta):
	job_queue.process_queue_without_threads()


func _input(event):
	if Engine.editor_hint:
		return
	if get_tree().current_scene.name == "start":
		return
	if Input.is_action_just_pressed("inv_grab") :
		if get_tree().current_scene.get_node("CanvasLayer/Inventory").visible == false and get_tree().current_scene.get_node("CanvasLayer/Control").visible == false:
				#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("open_inventory_"):
		if get_tree().current_scene.get_node("CanvasLayer/Inventory").visible == true:
			get_tree().current_scene.get_node("CanvasLayer/Inventory").visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
			if get_tree().current_scene.get_node("CanvasLayer/Inventory").get_node("get_menu").visible == true:
				for item in get_tree().current_scene.get_node("CanvasLayer/Inventory").get_node("get_menu").items_:
					for item_grid in get_tree().current_scene.get_node("CanvasLayer/Inventory").get_node("grid_of_carried_items").items_:
						for item_eq in get_tree().current_scene.get_node("CanvasLayer/Inventory").get_node("EquipmentSlots").item_inside_array:
									if item != item_grid and item.name != item_eq.name:
											get_tree().current_scene.get_node("CanvasLayer/Inventory").get_node(item.name).queue_free()
						
				get_tree().current_scene.get_node("CanvasLayer/Inventory").get_node("get_menu").visible = false

		elif get_tree().current_scene.get_node("CanvasLayer/Inventory").visible == false:
			if get_tree().current_scene.get_node("CanvasLayer/Control").visible == false:
				get_tree().current_scene.get_node("CanvasLayer/Inventory").visible = true
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			

