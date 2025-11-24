# Tutoriel Godot — Notes et Réponses

Ce document regroupera **toutes mes réponses à partir de maintenant**, au format **Markdown**, afin de bâtir un tutoriel clair et structuré.

---

## 📌 Réponse 1 — Configuration du format
À partir d’aujourd’hui, toutes les réponses seront automatiquement ajoutées ici en Markdown.

---

*(Les prochaines réponses seront ajoutées ci‑dessous.)

---

## 📌 Réponse 2 — Fichiers qui concernent le layout / map / terrain
Pour modifier **le layout, la map ou le terrain** du jeu *Survivor Arena FPS* (GDQuest), les éléments concernés sont principalement des **scènes 3D** et non des scripts.

### 🎮 1. **La scène principale du niveau**
- `res://main.tscn` *(ou parfois `Game.tscn` selon la version du projet)*

Tu peux y modifier :
- le sol
- les plateformes
- les murs
- la forme générale de l’arène
- la position du joueur
- les spawners

### 🧱 2. **Scènes modulaires du décor** *(si présentes)*
Certains projets GDQuest utilisent des scènes réutilisables :
- `res://level/Platform.tscn`
- `res://level/Block.tscn`
- `res://level/FloorTile.tscn`

Modifier ces scènes change automatiquement le layout si elles sont utilisées dans la scène principale.

### 🎨 3. **Matériaux et textures**
- `res://materials/floor_material.tres`
- `res://materials/wall_material.tres`

Ils influencent **l’apparence** du terrain, mais pas sa structure.

### ✔️ Résumé
Pour changer le terrain, tu modifies **principalement** :
- `main.tscn` *(ou `Game.tscn`)*
- les scènes de blocs/plateformes dans `res://level/`
- les matériaux `.tres` pour changer l’apparence du sol ou des murs

Aucun script n’a besoin d’être modifié si tu changes uniquement le layout du niveau.*

