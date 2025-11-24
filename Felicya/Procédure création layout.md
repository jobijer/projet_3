# 🗺️ Guide d'Implémentation : Génération Procédurale de Niveau (Godot 4)

Ce guide détaille les étapes pour créer un niveau aléatoire de plateformes et de ponts, en assurant une connectivité Plateforme-Pont-Plateforme à l'aide d'un algorithme de parcours sur grille (Walker).

*Document rédigé par Gemini, ChatGPT et Felicya Lajoie Jacob, et révisé par Felicya Lajoie Jacob*

## 0. Fichiers concernés
Pour modifier **le layout, la map ou le terrain** du jeu *Survivor Arena FPS* (GDQuest), les éléments concernés sont principalement des **scènes 3D** et non des scripts.

### 🎮 A. **La scène principale du niveau**
- `res://lessons_reference/video_16/main.tscn`

On y trouve les nodes et les scènes incluses dans le jeu.

### 🧱 2. **Scènes modulaires du décor**
Nous créerons des scènes réutilisables dans le dossier :
- `res://lessons_reference/video_16/level/`

### 🎨 3. **Matériaux et textures**
- `res://lessons_reference/video_16/level/bridges.tres`
- `res://lessons_reference/video_16/level/platforms.tres`

Ils influencent **l’apparence** du terrain, mais pas sa structure.

### ✔️ Résumé
Pour changer le terrain, tu modifies **principalement** :
- `main.tscn`
- les scènes de ponts/plateformes dans `res://lessons_reference/video_16/level/`
- les matériaux `.tres` pour changer l’apparence du sol ou des murs


## 1. Préparation des Scènes et du Gestionnaire

### A. Créer les Scènes
* Pour `Plateforme.tscn`: Un CSGBox3D cubique et le spawner de monstres pré-intégré.
* Pour `Pont.tscn`: Un CSGBox3D rectangulaire.
* Pour `PlateformeDebut.tscn`: Un CSGBox3D cubique sans spawner.

### B. Valider les Scènes
* Assurez-vous que vos scènes `Plateforme.tscn` et `Pont.tscn` sont correctement dimensionnées pour s'aligner sur une grille (e.g., chaque pièce occupe `TILE_SIZE` unités).
* Elles devraient hériter de `Node3D` ou de `StaticBody3D` pour la géométrie de niveau.

### B. Créer le Gestionnaire
* Créez un nouveau nœud `Node3D` (ici, nommé `Layout`) dans votre scène principale (`game.tscn`).
* Attachez-y le script `layout.gd`.

### C. Définir les Variables Exportées et Constantes
Définissez les références des scènes et la taille de la tuile.

## 2. Code de génération d'une première matrice aléatoire

### A. Code de génération:
En gros, il a fallu ajouter les scènes d'objets du layout (Plateforme, PlateformeDebut, PontDroit) comme variables externes du fichier GDScript layout.gd.

Variables:
| Nom      | Type      | Contenu    | Rôle
| ------------- | ------------- | ------------- | ------------- |
| plateforme_scene | PackedScene | Plateforme.tscn | Objet Plateforme |
| pont_scene | PackedScene | PontDroit.tscn | Objet pont |
| plateforme_debut_scene | PackedScene | PlateformeDebut.tscn | Objet Plateforme sans spawner |
| TILE_SIZE | const | 10.0 | Indique la superficie occupée par un objet |
| MAX_PIECES | const | 24.0 | Indique le nombre de "tuiles" à générer (excepté la plateforme de départ). |
| grid_map | Dictionnaire Clé: Vector2i des coordonnées, Valeur: type d'objet | Plateformes et Ponts | Contient les tuiles à disposer sur le terrain |
| plateforme_positions | Liste | Vector2i des co0rdonnées | Permet de connaitre les coordonnées utilisées ou non pour placer les autres |
* plateforme_scene

*Voir `res://lessons_reference/video_16/layout.gd`.*

### B. Intégration au jeu de base
* Il est nécessaire de supprimer les plateformes, ponts et spawners du layout d'origine pour éviter une superposition anormale.
*Ligne à ajouter au fichier `res://lessons_reference/video_16/game.gd` (scène principale) :
```gdscript
@onready var level_generator := %layout
```

## 3. Centrer la matrice et ajouter le dynamisme
Pour pouvoir faire apparaitre des plateformes en avançant et faire disparaitre celles qu'on laisse derrère, on doit:
* Modifier la logique en ajoutant un nombre limite de plateformes à faire apparaitre à droite et à gauche
* Ajouter une fonction qui fait apparaitre et disparaitre les plateformes
* Mettre à jour le fichier `game.gd` pour qu'il récupère les coordonnées du joueur, les compare à son ancien centre et, si il s'en est suffisament éloigné, changer le centre et déclencher la mise à jour.