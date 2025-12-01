extends Node3D

signal mob_spawned(mob)

@export var mob_normal: PackedScene
@export var mob_big: PackedScene

@onready var marker_3d: Marker3D = $Marker3D
@onready var timer: Timer = %Timer

var current_mob: Node3D = null   # on garde une référence sur la bat actuelle

func _on_timer_timeout() -> void:
	# Vérifie la distance joueur → spawner
	var player = get_node_or_null("/root/Game/Player")
	if player != null:
		var distance_to_player = global_position.distance_to(player.global_position)
		if distance_to_player > 30.0:
			return

	# S'il y a déjà un mob vivant, ne pas respawn
	if is_instance_valid(current_mob):
		return

	# Choix aléatoire : 1 chance sur 5 = grosse bat
	var scene_to_spawn: PackedScene
	if randi() % 5 == 0:
		scene_to_spawn = mob_big
	else:
		scene_to_spawn = mob_normal

	var new_mob = scene_to_spawn.instantiate()
	current_mob = new_mob
	add_child(new_mob)
	new_mob.global_position = marker_3d.global_position

	mob_spawned.emit(new_mob)
