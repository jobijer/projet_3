#game.gd
extends Node3D

var player_score = 0

@onready var label := %Label
# ATTENTION: Assurez-vous que le nom du nœud est bien 'Layout' dans la scène principale
@onready var level_generator := %Layout 
@onready var player_node = $"Player"
var current_grid_center = Vector2i(0, 0)

# --- Despawn settings ---
const DESPAWN_DISTANCE := 50.0         # distance en mètres
const DESPAWN_CHECK_INTERVAL := 1    # vérification toutes les 0.5 secondes
var _despawn_timer := 0.0

func get_player_grid_position() -> Vector2i:
	# Vérification de robustesse
	if not is_instance_valid(level_generator) or not is_instance_valid(player_node):
		return Vector2i.ZERO
		
	# Conversion de la position 3D (globale) en position de grille (Vector2i)
	var tile_size = level_generator.TILE_SIZE
	var x = round(player_node.global_position.x / tile_size)
	var z = round(player_node.global_position.z / tile_size)
	return Vector2i(int(x), int(z))
	
func _ready():
	print("Position joueur :", player_node.global_position)
	print("Case joueur :", get_player_grid_position())

func _process(delta):
	# Arrêter si les nœuds critiques ne sont pas initialisés
	if not is_instance_valid(level_generator) or not is_instance_valid(player_node):
		return
		
	var player_grid_pos = get_player_grid_position()
	
	# Seuil de déclenchement : si le joueur est à 1 tuile du bord de la zone de génération,
	# le centre doit se décaler.
	var update_limit = 1 
	
	var needs_update = false

	# Décalage de 1 tuile sur X
	if abs(player_grid_pos.x - current_grid_center.x) >= update_limit:
		current_grid_center.x += sign(player_grid_pos.x - current_grid_center.x)
		needs_update = true

	# Décalage de 1 tuile sur Y (qui correspond à l'axe Z du jeu)
	if abs(player_grid_pos.y - current_grid_center.y) >= update_limit:
		current_grid_center.y += sign(player_grid_pos.y - current_grid_center.y)
		needs_update = true

	if needs_update:
		# Appel la fonction de mise à jour du layout avec la nouvelle position centrale
		level_generator.update_layout(current_grid_center)
	# --- Despawn check ---
	_despawn_timer += delta
	if _despawn_timer >= DESPAWN_CHECK_INTERVAL:
		_despawn_timer = 0.0
		_check_and_despawn_far_mobs()


func increase_score():
	player_score += 1
	label.text = "Score: " + str(player_score)


func _on_kill_plane_body_entered(body):
	# Redémarrer la scène en cas de chute
	get_tree().reload_current_scene.call_deferred()


func _on_mob_spawner_3d_mob_spawned(mob):
	#N'est pas connecté au mobs qui spawn en ce moment
	mob.add_to_group("mobs")
	mob.died.connect(increase_score)
	do_poof(mob.global_position)
	
func _check_and_despawn_far_mobs():
	if not is_instance_valid(player_node):
		return

	var player_pos = player_node.global_position

	for mob in get_tree().get_nodes_in_group("mobs"):
		if not is_instance_valid(mob):
			continue

		var dist = player_pos.distance_to(mob.global_position)
		if dist > DESPAWN_DISTANCE:
			mob.queue_free()


func do_poof(mob_position):
	const SMOKE_PUFF = preload("res://mob/smoke_puff/smoke_puff.tscn")
	var poof := SMOKE_PUFF.instantiate()
	add_child(poof)
	poof.global_position = mob_position
