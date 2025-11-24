extends Node3D

signal mob_spawned(mob)

@export var mob_to_spawn: PackedScene = null

@onready var marker_3d: Marker3D = $Marker3D
@onready var timer: Timer = %Timer

var current_mob: Node3D = null   # ← on garde une référence sur la bat actuelle

func _on_timer_timeout() -> void:
	# S'il y a déjà une bat encore vivante, on ne respawn pas
	if is_instance_valid(current_mob):
		return

	var new_mob = mob_to_spawn.instantiate()
	current_mob = new_mob

	add_child(new_mob)
	new_mob.global_position = marker_3d.global_position
	mob_spawned.emit(new_mob)
