#layout.gd
extends Node3D

@export var plateforme_scene: PackedScene
@export var pont_scene: PackedScene
@export var plateforme_debut_scene: PackedScene

const TILE_SIZE = 10.0 
const MAX_PIECES = 110
@export var MAX_DISTANCE_FROM_START: int = 5 
var center_position = Vector2i(0, 0)

var grid_map = {} 
var plateforme_positions = [] 

func _ready():
	generate_level()

func generate_level():
	if plateforme_scene == null or pont_scene == null or plateforme_debut_scene == null:
		print("ERREUR: Veuillez assigner les scènes dans l'Inspecteur.")
		return
		
	var start_pos = Vector2i(0, 0)
	# CORRECTION ICI : On passe "plateforme" pour qu'elle soit ajoutée à la liste des positions valides
	place_debut_tile(start_pos, "plateforme")
	
	# Remplissage initial
	update_layout(Vector2i.ZERO, MAX_PIECES)

func place_debut_tile(grid_pos: Vector2i, type: String):
	var new_instance = plateforme_debut_scene.instantiate()
	add_child(new_instance)
	_position_instance(new_instance, grid_pos)
	_register_tile(grid_pos, type, new_instance)

func place_tile(grid_pos: Vector2i, type: String, direction: Vector2i = Vector2i.ZERO):
	var scene_to_instantiate = plateforme_scene if type == "plateforme" else pont_scene
	var new_instance = scene_to_instantiate.instantiate()
	add_child(new_instance)
	
	_position_instance(new_instance, grid_pos)

	if type == "pont" and direction.x != 0:
		new_instance.rotation_degrees.y = 90.0

	_register_tile(grid_pos, type, new_instance)

func _position_instance(instance, grid_pos):
	var x = float(grid_pos.x)
	var z = float(grid_pos.y)
	instance.global_position = Vector3(x * TILE_SIZE, 0.0, z * TILE_SIZE)

func _register_tile(grid_pos, type, instance):
	grid_map[grid_pos] = {
		"type": type,
		"instance": instance
	}
	# C'est ici que ça bloquait : "plateformedebut" n'entrait pas dans cette condition
	if type == "plateforme":
		plateforme_positions.append(grid_pos)

# --- Logique de Placement ---

func try_place_segment(platform_pos: Vector2i) -> bool:
	var directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
	directions.shuffle()

	for direction in directions:
		var pont_pos = platform_pos + direction
		var next_platform_pos = pont_pos + direction

		var dx_next = abs(next_platform_pos.x - center_position.x)
		var dz_next = abs(next_platform_pos.y - center_position.y) 

		if dx_next > MAX_DISTANCE_FROM_START or dz_next > MAX_DISTANCE_FROM_START:
			continue

		if not grid_map.has(pont_pos) and not grid_map.has(next_platform_pos):
			place_tile(pont_pos, "pont", direction)
			place_tile(next_platform_pos, "plateforme")
			return true
	return false

func try_place_closing_bridge():
	if plateforme_positions.size() < 2: return false

	var platform_A_pos = plateforme_positions.pick_random()
	var directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
	directions.shuffle()

	for direction in directions:
		var pont_pos = platform_A_pos + direction
		var platform_B_pos = pont_pos + direction
		
		var dx_pont = abs(pont_pos.x - center_position.x)
		var dz_pont = abs(pont_pos.y - center_position.y) 
		
		if dx_pont > MAX_DISTANCE_FROM_START or dz_pont > MAX_DISTANCE_FROM_START:
			continue

		if grid_map.has(pont_pos): continue
			
		if grid_map.has(platform_B_pos) and grid_map[platform_B_pos].type == "plateforme":
			if platform_B_pos != platform_A_pos:
				place_tile(pont_pos, "pont", direction)
				return true
	return false

# --- Mise à jour Dynamique ---

func update_layout(new_center_pos: Vector2i, max_attempts: int = 15):
	center_position = new_center_pos
	
	# 1. Nettoyage
	cleanup_old_tiles()
	
	# 2. Génération
	# Si c'est le tout début (peu de plateformes), on utilise la méthode brute pour remplir
	if plateforme_positions.size() < 10:
		for i in range(max_attempts): 
			if plateforme_positions.is_empty(): break
			var current_platform_pos = plateforme_positions.pick_random()
			
			var dx = abs(current_platform_pos.x - center_position.x)
			var dz = abs(current_platform_pos.y - center_position.y)
			if dx <= MAX_DISTANCE_FROM_START and dz <= MAX_DISTANCE_FROM_START:
				try_place_segment(current_platform_pos)

	else:
		# LOGIQUE DE RANGÉE UNIQUE (Runtime)
		var candidates = []
		
		for pos in plateforme_positions:
			var dx = abs(pos.x - center_position.x)
			var dz = abs(pos.y - center_position.y)
			
			# Si on est à (MAX - 2), c'est un bon candidat pour étendre
			if dx >= MAX_DISTANCE_FROM_START - 2 or dz >= MAX_DISTANCE_FROM_START - 2:
				candidates.append(pos)
		
		candidates.shuffle()
		
		for pos in candidates:
			try_place_segment(pos)
			
			if randf() < 0.2:
				try_place_closing_bridge()

func cleanup_old_tiles():
	var keys_to_remove = []
	var destruction_threshold = MAX_DISTANCE_FROM_START + 2 
	
	for grid_pos in grid_map.keys():
		var dx = abs(grid_pos.x - center_position.x)
		var dz = abs(grid_pos.y - center_position.y)
		
		if dx > destruction_threshold or dz > destruction_threshold:
			keys_to_remove.append(grid_pos)

	for grid_pos in keys_to_remove:
		if grid_map[grid_pos].has("instance") and is_instance_valid(grid_map[grid_pos].instance):
			grid_map[grid_pos].instance.queue_free()

		if grid_map[grid_pos].type == "plateforme":
			plateforme_positions.erase(grid_pos)
		
		grid_map.erase(grid_pos)
