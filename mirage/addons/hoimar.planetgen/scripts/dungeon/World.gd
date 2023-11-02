tool
extends Spatial

const Cell = preload("res://addons/hoimar.planetgen/scripts/dungeon/Cell.tscn")

const Map = preload("res://addons/hoimar.planetgen/scripts/dungeon/Map.tscn")

var cells = []
	


func _ready():

		generate_map()


				
func generate_map():
	if not Map is PackedScene: return
	var map = Map.instance()
	var tileMap = map.get_tilemap()
	var used_tiles = tileMap.get_used_cells()
	map.free() # We don't need it now that we have the tile data
	for tile in used_tiles:
		var cell = Cell.instance()
		add_child(cell)
		cell.translation = Vector3(tile.x*Globals.GRID_SIZE, 0, tile.y*Globals.GRID_SIZE)
		cells.append(cell)
	for cell in cells:
		cell.update_faces(used_tiles)
