# Architecture d'un Open-World dans Godot (Godot 4.x)

## 1. Structure générale d'un open-world

Un open-world doit être **découpé en zones** pour optimiser le
chargement, la performance et la gestion des assets.

### Structure de dossiers recommandée

    res://
      world/
        zones/
          zone_grasslands/
            terrain.tscn
            props/
            npcs/
          zone_forest/
          zone_mountain/
        world_manager.gd
        zone_streamer.gd
      player/
        player.tscn
        player.gd
      systems/
        save_system.gd
        time_system.gd
        weather_system.gd
        quest_manager.gd
      ui/
        hud.tscn
        map.tscn
      global/
        globals.gd (AutoLoad)

------------------------------------------------------------------------

## 2. Structure d'une zone

Chaque zone est une scène indépendante et doit contenir :

-   un **terrain**
-   des **props/décors statiques**
-   des **points d'intérêt (POI)**
-   des **NPCs/ennemis**
-   un **Area3D servant de ZoneBounds**

Exemple :

    zone_forest.tscn
      ├── TerrainForest (MeshInstance3D)
      ├── Props
      ├── NPCs
      └── ZoneBounds (Area3D)

------------------------------------------------------------------------

## 3. Système de streaming du monde

Godot ne possède pas de streaming automatique, donc il faut créer un
**ZoneStreamer**.

    Node3D (ZoneStreamer)
      ├── CurrentZones = []
      ├── LoadRadius = 2

Chaque zone équivaut à un carreau logique (ex. 512 × 512 m).

------------------------------------------------------------------------

## 4. WorldManager (chargement/déchargement des zones)

Tâches :

-   Gérer les zones proches du joueur
-   Décharger celles trop éloignées
-   Gérer l'**origin shifting**
-   Activer/désactiver les NPCs et IA
-   Gérer les LOD

Pseudo-code :

``` gdscript
func _process(delta):
    var player_pos = player.global_position
    var current_tile = world_to_tile(player_pos)

    for tile in tiles_around(current_tile, load_radius):
        if tile not yet loaded:
            load_zone(tile)

    for loaded in loaded_zones:
        if loaded too far:
            unload_zone(loaded)
```

------------------------------------------------------------------------

## 5. Activation/désactivation des éléments (optimisation)

Chaque zone doit exposer deux fonctions :

``` gdscript
func activate_zone():
    for npc in npcs:
        npc.set_process(true)
    for obj in props:
        obj.visible = true

func deactivate_zone():
    for npc in npcs:
        npc.set_process(false)
    for obj in props:
        obj.visible = false
```

------------------------------------------------------------------------

## 6. Le Player comme pivot du streaming

Le player détecte quand il change de tuile.

``` gdscript
signal moved_tile(tile_id)

var last_tile = null

func _physics_process(delta):
    var t = world.world_to_tile(global_position)
    if t != last_tile:
        emit_signal("moved_tile", t)
        last_tile = t
```

------------------------------------------------------------------------

## 7. Origin Shifting

Permet de recentrer le monde autour du joueur pour éviter les
imprécisions liées aux floats 32-bit.

``` gdscript
func shift_origin_to_player():
    var p = player.global_position
    if p.length() > 2000:
        shift_scene_tree_origin(p)
```

------------------------------------------------------------------------

## 8. Systèmes globaux

Ils doivent être indépendants des zones :

-   météo
-   cycle jour/nuit
-   quêtes
-   sauvegarde
-   inventaire

Exemple globals.gd :

``` gdscript
var time_of_day = 12.0
var weather = "clear"
var quests = {}
```

------------------------------------------------------------------------

## 9. Carte et minimap

La carte doit fonctionner même si les zones ne sont pas chargées :

-   index global des zones
-   pré-génération d'une image 2D
-   bounding boxes des zones

------------------------------------------------------------------------

## 10. Architecture modulaire résumée

    WorldManager
      ├── ZoneStreamer
      ├── Load/Unload zones
      ├── Origin shifting
      └── Activation/LOD

    Player
      ├── Camera
      ├── Movement
      └── Tile detection

    UI
      ├── HUD
      ├── Compass
      └── Map

    Systems
      ├── Time system
      ├── Weather system
      ├── Save system
      ├── Quest system
      └── Inventory

    Zones
      ├── Terrain
      ├── Props
      ├── NPC AI
      └── Points of interest

------------------------------------------------------------------------

## 11. Exemple de code complet

### WorldManager

``` gdscript
extends Node3D

var loaded_zones = {}
var load_radius = 1
var zone_size = 512

func world_to_tile(pos: Vector3) -> Vector2i:
    return Vector2i(floor(pos.x / zone_size), floor(pos.z / zone_size))

func load_zone(tile: Vector2i):
    var scene_path = "res://world/zones/" + tile_to_name(tile) + ".tscn"
    var s = load(scene_path).instantiate()
    add_child(s)
    loaded_zones[tile] = s

func unload_zone(tile: Vector2i):
    loaded_zones[tile].queue_free()
    loaded_zones.erase(tile)
```

### Connexion Player → WorldManager

``` gdscript
player.connect("moved_tile", world_manager._on_player_moved_tile)

func _on_player_moved_tile(tile):
    refresh_zones_around(tile)
```

### Interface Zone

``` gdscript
func activate_zone():
    set_process(true)
    visible = true

func deactivate_zone():
    set_process(false)
    visible = false
```

------------------------------------------------------------------------

## Conclusion

Un open-world dans Godot repose sur :

-   découpage en zones
-   streaming manuel
-   désactivation des NPC hors-champ
-   player comme pivot
-   systèmes globaux
-   carte indépendante

Cette architecture permet un open-world performant malgré les
limitations de Godot.
