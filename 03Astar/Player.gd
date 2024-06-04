extends Node2D

var astar_grid: AStarGrid2D
var current_id_path: Array[Vector2i]
@onready var tile_map = $"../TileMap"

func _ready():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = tile_map.get_used_rect()
	astar_grid.cell_size = Vector2(16,16)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()

func _input(event):
	if event.is_action_pressed("move")==false:
		return
	
	var id_path = astar_grid.get_id_path(
		tile_map.local_to_map(global_position),
		tile_map.local_to_map(get_global_mouse_position())
	).slice(1)#忽略array路徑第1個元素(起點)	
	
	if id_path.is_empty()==false:
		current_id_path = id_path

func _physics_process(delta):
	if current_id_path.is_empty():
		return
	
	var target_postion = tile_map.local_to_map(current_id_path.front())
	
	global_position = global_position.move_toward(target_postion,1)
	
	if Vector2i(global_position) == target_postion:
		current_id_path.pop_front()
		
	
