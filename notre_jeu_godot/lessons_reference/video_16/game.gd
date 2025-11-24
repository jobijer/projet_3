extends Node3D

var player_score = 0

@onready var label := %Label
# ATTENTION: Assurez-vous que le nom du nœud est bien 'Layout' dans la scène principale
@onready var level_generator := %Layout 
@onready var player_node = $"Player"
var current_grid_center = Vector2i(0, 0)

func get_player_grid_position() -> Vector2i:
	# Vérification de robustesse
	if not is_instance_valid(level_generator) or not is_instance_valid(player_node):
		return Vector2i.ZERO
		
	# Conversion de la position 3D (globale) en position de grille (Vector2i)
	var tile_size = level_generator.TILE_SIZE
	var x = round(player_node.global_position.x / tile_size)
	var z = round(player_node.global_position.z / tile_size)
	return Vector2i(int(x), int(z))


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


func increase_score():
	player_score += 1
	label.text = "Score: " + str(player_score)


func _on_kill_plane_body_entered(body):
	# Redémarrer la scène en cas de chute
	get_tree().reload_current_scene.call_deferred()


func _on_mob_spawner_3d_mob_spawned(mob):
	mob.died.connect(func():
		increase_score()
		do_poof(mob.global_position)
	)
	do_poof(mob.global_position)


func do_poof(mob_position):
	const SMOKE_PUFF = preload("res://mob/smoke_puff/smoke_puff.tscn")
	var poof := SMOKE_PUFF.instantiate()
	add_child(poof)
	poof.global_position = mob_position
