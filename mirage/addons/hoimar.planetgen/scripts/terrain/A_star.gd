extends Spatial



var grid_step 
var grid_y 
var points := {}
var astar = AStar.new()

var cube_mesh = CubeMesh.new()
var red_material = SpatialMaterial.new()
var green_material = SpatialMaterial.new()
var pathables_ = []


func _init_a_star(grid_step_,grid_y_) -> void:
	grid_step = grid_step_
	grid_y = grid_y_
	pathables_ = get_tree().get_nodes_in_group("geode")
	_add_points(pathables_)
	_connect_points()
	print("size of pathables_ " + str(pathables_.size()))

func reset_path():
		astar.clear()

func _add_points(pathables: Array):
	for pathable in pathables:
		var mesh = pathable
		
		if mesh.has_method("get_transformed_aabb"):
			var aabb: AABB = mesh.get_transformed_aabb()

			var start_point = aabb.position

			var x_steps = aabb.size.x / grid_step
			var z_steps = aabb.size.z / grid_step

			for x in x_steps:
				for z in z_steps:
					var next_point = start_point + Vector3(x * grid_step, 0, z * grid_step)
					_add_point(next_point)
		

func _add_point(point: Vector3):
	point.y = grid_y
	var id = astar.get_available_point_id()

	astar.add_point(id, point)
	points[world_to_astar(point)] = id


func _connect_points():
	for point in points:
		var pos_str = point.split(",")
		var world_pos := Vector3(pos_str[0], pos_str[1], pos_str[2])
		var adjacent_points = _get_adjacent_points(world_pos)
		var current_id = points[point]
		for neighbor_id in adjacent_points:
			if not astar.are_points_connected(current_id, neighbor_id):
				astar.connect_points(current_id, neighbor_id)




func _get_adjacent_points(world_point: Vector3) -> Array:
	var adjacent_points = []
	var search_coords = [-grid_step, 0, grid_step]
	for x in search_coords:
		for z in search_coords:
			var search_offset = Vector3(x, 0, z)
			if search_offset == Vector3.ZERO:
				continue

			var potential_neighbor = world_to_astar(world_point + search_offset)
			if points.has(potential_neighbor):
				adjacent_points.append(points[potential_neighbor])
	return adjacent_points


func handle_obstacle_added(obstacle: Spatial):
	var normalized_origin = obstacle.global_transform.origin
	normalized_origin.y = grid_y

# Uncomment this line if you want to disable/enabled adjacent points
# of an obstacle.
#	var adjacent_points: Array = _get_adjacent_points(normalized_origin)
	var adjacent_points: Array = []
	var point_key = world_to_astar(normalized_origin)
	var astar_id = points[point_key]
	adjacent_points.append(astar_id)

	for point in adjacent_points:
		if not astar.is_point_disabled(point):
			astar.set_point_disabled(point, true)


func handle_obstacle_removed(obstacle: Spatial):
	var normalized_origin = obstacle.global_transform.origin
	normalized_origin.y = grid_y

# Uncomment this line if you want to disable/enabled adjacent points
# of an obstacle.
#	var adjacent_points: Array = _get_adjacent_points(normalized_origin)
	var adjacent_points: Array = []
	var point_key = world_to_astar(normalized_origin)
	var astar_id = points[point_key]
	adjacent_points.append(astar_id)

	for point in adjacent_points:
		if astar.is_point_disabled(point):
			astar.set_point_disabled(point, false)


func find_path(from: Vector3, to: Vector3) -> Array:
	var start_id = astar.get_closest_point(from)
	var end_id = astar.get_closest_point(to)
	return astar.get_point_path(start_id, end_id)


func world_to_astar(world: Vector3) -> String:
	var x = stepify(world.x, grid_step)
	var y = grid_y
	var z = stepify(world.z, grid_step)
	return "%d,%d,%d" % [x, y, z]

