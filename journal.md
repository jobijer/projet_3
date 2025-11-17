# SEMAINE 1

## Sujet choisi
Godot game engine

## Équipes
- Jérémie D'Amours  
- Felicya Lajoie Jacob  
- Jasmin Dubuc

## Lien GitHub
[https://github.com/jobijer/projet_3.git](https://github.com/jobijer/projet_3.git)

---
# SEMAINE 2

## Jérémie

### 2025-11-16

---
### Tâches réalisées

Lecture de la documentation suivantes :

- Kynematic character 2D
- Object class
- Audio buses
- Audio effects
- Audio streams
- Sync the gameplay with audio and music
- Recording with microphone
- Text to speech

Exercices step by step (tutorial) suivants :

- Nodes and Scenes
- Creating instances

---
### Apprentissages faits avec l’aide de l’IA

J'ai demandé au AI de m'expliquer, me résumer et de me générer un fichier MarkDown de chaque sujet m'entionné ci-dessus.

---
### Les difficultés rencontrées

Il est très dur pour moi de comprendre les concepts expliqués dans la documentation de Godot. Comme j'ai fait plus de lecture que de manipulation direct avec Godot rend la compréhension difficile. Donc les termes techniques reste abstrait.
---
### Les objectifs de la semaine suivante

Faire plus de manipulation directe avec le moteur Godot, avec un tutoriel qui part du début, pour avoir une base solide et m'aider dans ma compréhension du sujet.

Plan:
- Trouver un tutoriel de jeu 3D réalisable
- Décider comment nous allons le personnaliser







---
## Felicya

### Du 2025-11-10 au 2025-11-16

---
### Tâches réalisées
#### 2025-11-12
Tutoriel Godot Engine 4.5 documentation in English "Step by step" de la documentation officielle de Godot: [https://docs.godotengine.org/en/stable/getting_started/step_by_step/index.html](https://docs.godotengine.org/en/stable/getting_started/step_by_step/index.html)

Sections:

- Nodes and Scenes
- Creating instances
- Scripting languages
- Creating your first script
- Listening to player input
- Using signals

#### 2025-11-13
Début du tutoriel 2D, Sections:
- Setting up the project
- Creating the player scene
- Coding the player 

Tutoriel 3D Sections:
- Setting up the game area
- Player scene and input actions
- Moving the player with code
- Designing the mob scene
- Spawning monsters


#### 2025-11-15
Tutoriel 3D Sections:
- Jumping and squashing monsters
- Killing the player

Discussion avec l'IA et lectures sur l'architecture, le 3D et GDScript
---
### Apprentissages faits avec l’aide de l’IA

- Nodes
    - Blocs de construction des scènes
    - Tutoriel
        
- Langages de script
    - GDScript, C#, C++ via GDExtension

- Tutoriel, concepts généraux (structure des nodes, scènes et arbres)

- Architecture et fonctionnement
[https://chatgpt.com/share/6918e6b1-9908-800a-80e9-3035746e0b36](https://chatgpt.com/share/6918e6b1-9908-800a-80e9-3035746e0b36)

- 3D
[https://chatgpt.com/share/6918f455-b9e4-800a-8ea4-400e29d73a61](https://chatgpt.com/share/6918f455-b9e4-800a-8ea4-400e29d73a61)

- GDScript
[https://chatgpt.com/share/6918f72a-10ac-800a-bce4-9c73fa56d669](https://chatgpt.com/share/6918f72a-10ac-800a-bce4-9c73fa56d669)

- Type de gameplay offerts
    - Fonctionne bien pour les jeux linéaire grâce aux multiples scènes, aux signals, etc.
    - Jeux en boucle - fonctionne bien grâce aux boucles _process() et _physics_process() qui fonctionnent en continu, aux instances, aux signaux, etc.
    - Visual novel et jeux hybrides également
    - Restrictions: Open-world
        Pas de système de chargement par zones, tout doit être codé manuellement dont le chargement et déchargement des scènes, les collisions, l'activation/désactivation des scripts, etc.
        L'origin shifting n'est pas très robuste et il n'utilise pas des coordonnées 64-bit flottantes, juste 32-bit
        Crée des tremblements et des imprécisions dans les collisions
        Pas d'outil dédié pour créer de grands terrains
        Moteur non-optimisé pour afficher des milliers d'objets
        Pas beaucoup d'IA pour gérer le monde ouvert
        "Godot peut faire des open-world simples à intermédiaires, mais il manque les outils avancés et l’optimisation nécessaires pour un open-world AAA moderne."
        [https://chatgpt.com/share/6918fbd1-271c-800a-8f1d-92a58d26ee0c](https://chatgpt.com/share/6918fbd1-271c-800a-8f1d-92a58d26ee0c)

- Jeu open-world
    Je lui ai demandé comment serait structuré un jeu open-world dans Godot.
    [https://chatgpt.com/share/6918fbd1-271c-800a-8f1d-92a58d26ee0c](https://chatgpt.com/share/6918fbd1-271c-800a-8f1d-92a58d26ee0c)
---
### Les difficultés rencontrées
Ce n'est pas très concret de demander à l'IA quoi faire sur une interface semi-graphique, c'est beaucoup plus agréable de trouver moi-même de vrais tutoriels/vidéos/forums traitant de ce que je veux accomplir.

Ce n'est pas non plus très intéressant de lire ce que l'IA a écrit. Je préfère apprendre en suivant un tutoriel, et comme il y en a déjà sur le site officiel de Godot, je n'ai pas très envie de demander à l'IA de m'en créer un.

---
### Les objectifs de la semaine suivante
Intégrer les apprentissages dans un jeu à développer nous-mêmes en guise de démonstration.





---
## Jasmin

### 2025-11-10

---
### Tâches réalisées

Cette semaine, j'ai généré des guides pour les physiques du jeu, l'animation et le multijoueur. Les guide sont accessible dans notre projet git :

#### physics.md
#### multiplayer.md
#### animation.md

##### py
---
### Apprentissages faits avec l’aide de l’IA

Les guides ont tous été fait avec de l'IA. Je lui ai communiqué les paramètres importants qui concernent le projet, et lui ai demandé de générer un guide. Le guide présenté est celui qui a été généré après plusieurs questions et correctins de l'IA.

---
### Les difficultés rencontrées

J'ai de la difficulté à obtenir le bon résultat de mes recherches IA. Lorsque je demandait à ChatGPT de me générer une réponse en markdown, seulement la première partie de la réponse était bien formattée, et Chatgpt me jurait que tout la réponse était en markdown, quand elle ne l'était clairement pas. C'était une expérience frustrante, mais un bon rappel que tous les IA ne sont pas égaux, surtout si elles sont gratuites.

---
### Les objectifs de la semaine suivante
Intégrer les apprentissages dans un jeu à développer nous-mêmes en guise de démonstration.