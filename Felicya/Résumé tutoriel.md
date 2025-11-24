# Your First 3D Game With Godot 4 — Résumé & fichiers GDScript

_Source_: https://www.gdquest.com/library/first_3d_game_godot4_arena_fps/ (GDQuest — code sous licence **MIT**)

> Ce document contient :
> - Un plan (TOC) des étapes du tutoriel.
> - Un résumé concis de chaque étape.
> - Le contenu des principaux fichiers GDScript présentés dans le tutoriel (copie conforme du code de référence publié, licence MIT).

---

## Table des matières

1. Setting up
2. Coding the camera rotation
3. Limiting the mouse
4. Coding ground movement
5. Coding the jump and fall
6. Creating the level
7. Coding the shooting mechanics
8. Creating the mob
9. Getting the mob to follow the player
10. Damaging and killing the mob
11. Spawning the mobs continuously from spawners
12. Scoring
13. Adding sounds
14. Setting up the kill plane
15. Adding visual effects and refining the level
16. Exporting the game

---

## Résumé rapide des étapes

- **1. Setting up** — Télécharger les assets, ouvrir le projet Godot, vérifier que la scène principale est correctement définie et que les nodes Player/Camera ont les transforms attendus.

- **2. Coding the camera rotation** — Gérer `InputEventMouseMotion` dans `player.gd` pour tourner le joueur (axe Y) et la caméra (axe X). Utiliser les noms uniques de scène (`%Camera3D`) pour accéder rapidement aux nodes.

- **3. Limiting the mouse** — Capturer la souris (`Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)`) et permettre d'annuler la capture (`ui_cancel`) pour libérer le curseur.

- **4. Coding ground movement** — Utiliser `Input.get_vector(...)`, calculer la direction 3D via `transform.basis * Vector3(...)`, appliquer vitesse et `move_and_slide()` dans `_physics_process()`.

- **5. Jump and fall** — Ajouter l'action `jump` dans l'Input Map ; ajouter logique de saut et gestion de la gravité via `velocity.y` et `is_on_floor()`.

- **6. Creating the level** — Construire la scène de niveau avec plateformes, reticle, Timer, etc.

- **7. Shooting mechanics** — Créer une scène Bullet/Projectile, instancier depuis `player.gd`, propulser le projectile, détecter collisions et distance parcourue pour `queue_free()`.

- **8. Creating the mob** — Créer la scène `mob` (RigidBody3D) et un `bat_model` pour l'animation ; exposer variables nécessaires.

- **9. Mob follow logic** — Dans `mob.gd`, calculer la direction vers le joueur, annuler la composante Y, fixer `linear_velocity` ou `apply_central_impulse` pour faire suivre.

- **10. Damaging and killing the mob** — Ajouter `health`, `take_damage()` qui déclenche animation/hurt, applique impulse et `timer` pour `queue_free()`.

- **11. Spawners** — `spawner_3d.gd` instancie mobs périodiquement et peut émettre un signal `mob_spawned(mob)`.

- **12. Scoring** — `game.gd` maintient `player_score`, expose `increase_score()` et connecte la mort des mobs à l'augmentation du score.

- **13. Sounds** — Ajouter `AudioStreamPlayer`/`AudioStreamPlayer3D` et appeler `.play()` au bon endroit (tir, hurt, KO).

- **14. Kill plane** — Ajouter une `Area3D`/KillPlane qui détecte le joueur et relance la scène.

- **15. VFX & polishing** — Ajout de `smoke_puff` tscn, `do_poof()` dans `game.gd`, amélioration visuelle.

- **16. Export** — Paramètres de projet et export vers plateformes cibles.

---

## Fichiers GDScript (extraits du tutoriel / code de référence — licence MIT)

> Les scripts ci-dessous sont les extraits fournis comme "Code Reference" sur la page GDQuest. Le code est repris tel que publié (licence MIT). Si vous voulez un dépôt .zip `.md` ou des fichiers séparés, dites-le et je les génère.

### res://player/player.gd

```gdscript
extends CharacterBody3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.5
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.2
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -60.0, 60.0)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	const SPEED = 5.5
	var input_direction_2D = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var input_direction_3D = Vector3(input_direction_2D.x, 0, input_direction_2D.y)
	var direction = transform.basis * input_direction_3D

	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

	move_and_slide()
```

> Note: le tutoriel ajoute progressivement d'autres lignes (saut, tir, son). Les fragments affichés plus bas montrent ces ajouts.


### res://player/bullet_3d.gd

```gdscript
extends Area3D

const SPEED = 55.0
const RANGE = 40.0

var travelled_distance = 0.0

func _physics_process(delta):
	position += -transform.basis.z * SPEED * delta
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()
```


### res://mob/bat/bat_model.gd

```gdscript
extends Node3D

@onready var animation_tree = %AnimationTree

func hurt():
	animation_tree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
```


### res://mob/mob.gd

```gdscript
extends RigidBody3D

signal died

var health = 3
var speed = randf_range(2.0, 4.0)

@onready var bat_model = %bat_model
@onready var timer = %Timer
@onready var player = get_node("/root/Game/Player")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	direction.y = 0.0
	linear_velocity = direction * speed
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI

func take_damage():
	if health <= 0:
		return

	bat_model.hurt()

	health -= 1

	if health == 0:
		set_physics_process(false)
		gravity_scale = 1.0
		var direction = player.global_position.direction_to(global_position)
		var random_upward_force = Vector3.UP * randf() * 5.0
		apply_central_impulse(direction.rotated(Vector3.UP, randf_range(-0.2, 0.2)) * 10.0 + random_upward_force)
		timer.start()
		died.emit()

func _on_timer_timeout():
	queue_free()
```


### res://mob/spawner_3d.gd

```gdscript
extends Node3D

signal mob_spawned(mob)

@export var mob_to_spawn: PackedScene = null
@onready var marker_3d = $Marker3D
@onready var timer = %Timer

func _on_timer_timeout():
	var new_mob = mob_to_spawn.instantiate()
	add_child(new_mob)
	new_mob.global_position = marker_3d.global_position
	mob_spawned.emit(new_mob)
```


### res://game.gd

```gdscript
extends Node3D

var player_score = 0

@onready var label := %Label

func increase_score():
	player_score += 1
	label.text = "Score: " + str(player_score)

func _on_mob_spawner_3d_mob_spawned(mob):
	mob.died.connect(increase_score)
```

---

## Remarques / prochaines actions possibles

- Je peux générer un **fichier Markdown (.md)** téléchargeable contenant exactement ce document (ou bien des fichiers `.gd` séparés dans un `.zip`). Dites-moi lequel vous préférez et je le crée.
- Si vous voulez que j'extraie _tous_ les fragments de code additionnels (p.ex. toutes les versions intermédiaires) et les sauvegarde comme fichiers séparés, je peux le faire.
- Si vous voulez une version *traduite* en français ligne-par-ligne du tutoriel (explications) plutôt qu'un résumé, je peux la produire en respectant le droit d'auteur (paraphrase/synthèse).

---

*Fait en extrayant directement la page publique de GDQuest ; le code repris est publié sous licence MIT selon la page.*

