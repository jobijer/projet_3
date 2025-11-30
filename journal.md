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

Plan:
- Trouver un tutoriel de jeu 3D réalisable
- Décider comment nous allons le personnaliser
- Regarder l'intégrité du tutoriel
- Débuter la personnalisation
    - Choisir le type de niveaux ou de monde ouvert à implémenter
    - Explorer le fonctionnement de la scène du setting actuelle
    - Créer des nouvelles scènes de la map
    - Créer la matrice aléatoire
    - Instancier les différentes scènes de la map
    - Décharger les scènes distantes
    - Détruire les objets distants






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







# SEMAINE 3

## Jérémie

### 2025-11-23

---
### Tâches réalisées

J'ai intégré les chauvres-souris dans les 'spawner'
J'ai augmenté la taille des chauvres-souris ainsi que leur hitbox
J'ai modifié leur couleur pour vert/rouge (thématique noel ahah)
J'ai identifié où était toute les instance de spawner (caché dans 	temporary_level.tscn)
J'ai limité les spawner à 1 chauvre-souris max
J'ai réduit la vitesse des chauvres-souris
J'ai réduit les points de vie à 1 (donc une seule balle pour les tuer)


---
### Apprentissages faits avec l’aide de l’IA

Chat GPT ma guidé tout le long : J'ai envoyé le projet en ZIP à GPT pour qu'il analyse la structure du projet. Ensuite, lorsque je cherchais des objets, des scripts ou des fonctionnalités spécifiques, je prenais des captures d’écran du code ou de l’éditeur et je les envoyais à ChatGPT. Il pouvait ensuite localisé la fonctionnalité et m'expliquer son rôle etc ...

---
### Les difficultés rencontrées

La structure en générale, trouver les fonctionnalités, les objets, les scènes, les settings, les options .. etc

---
### Les objectifs de la semaine suivante

Modifier séparément les instances de chauvres-souris (au lieu de toute les modifier ensemble)

Peut-être faire une chauvres-souris élite (un genre de boss)




---
## Felicya

### Du 2025-11-17 au 2025-11-23

---
### Tâches réalisées
- Choisir le tutoriel et le projet de base sur lesquels nous allons extrapoler
- Trouver comment transmettre le projet via Git

- Création du plan du layout et de la map du jeu
- Création des scènes des plateformes et ponts à réutiliser
- Travail sur la logique à intégrer

*** VOIR LE FICHIER `Felicya/Procédure création layout.md` ***
---
### Apprentissages faits avec l’aide de l’IA
- Contenu du .gitignore normalement recommandé par Godot
[https://chatgpt.com/share/691b36ae-8288-800a-9fb6-2297499ee976](https://chatgpt.com/share/691b36ae-8288-800a-9fb6-2297499ee976)

- Résumé du tutoriel de création du jeu de base (voir Felicya/Résumé tutoriel.md)
- Détermination des premières étapes à effectuer (scènes pour plateformes réutilisables)
- Construction de la logique de génération aléatoire du terrain
- Ajustements à faire à la logique de génération
- Ajustements à faire pour récupérer les coordonnées du joueur dans `game.md`et comment activer la mise à jour du layout
---
### Les difficultés rencontrées
- Manque d'inspiration en début de semaine
- Manque de motivation vu la difficulté à collaborer avec l'IA
- Plus j'avance dans le travail, plus l'IA a du mal à comprendre mes requêtes étant donné qu'elles sont de plus en plus pointues; l'IA fait de plus en plus d'erreurs.
---
### Les objectifs de la semaine suivante
* Rendre l'apparition et la destruction de plateformes plus fluides et éliminer les bugs
* Réutiliser la même logique pour le début de la génération des monstres, la fin de leur génération et leur disparition
Intégrer les apprentissages dans un jeu à développer nous-mêmes en guise de démonstration.

---
## Jasmin

### 2025-11-10

Cette semaine, en classe, on a été trouvé un exemple de code simple pour un FPS dans Godot. Notre but cette semaine est de joueur avec les plus de paramètres possible pour optimmiser notre jeu. Mes tâches sont de :
1. Trouver comment remplacer le gun_model.glb par la version gun_model_2.glb que j'ai modifié avec Blender
2. Modifier les paramètres de tir pour que le nouveau modèle d'arme aie son comportement propre à lui (Les projectiles sont plus gros, font plus de dégat, l'arme tire plus lentement, etc)
3. Trouver un moyen de permettre les deux versions de l'arme dans le jeu. Par exemple, l'arme du joueur pourrait automatiquement s'améliorer lorsque le score atteinds 10 points
4. Appliquer les connaissances acquises dans la manipulation des armes pour créer une version alternée des enemis
5. Si possible, coder de nouveau comportement pour les enemis aussi
---
### Tâches réalisées

##### Update 1
J'avais importé et modifié un fichier sur blender, et avait beaucoup de difficulté à bien l'importer dans Godot. Je me suis rendu compte que je n'en savais pas asser pour même comprendre ou était mon erreur, et j'ai
décidé de prendre du temps pour me familiariser avec Blender d'abord. J'ai changé d'IA et j'ai demandé à Gemini cette fois-ci de m'aider dans ma recherche. L'analyse elle-même était très comparable à mon expérience
avec ChatGPT, mais en plus l'IA m'a donné un lien sur une bonne vidéo Youtube sur le sujet. Je suis reparti de tout début avec mon fichier, et au final je suis arrivé avec war_gun_model.glb, qui est mieux fait que le premier. Il me reste à revérifier si j'ai bien exporté le fichier, mais je me sens maintenant en meilleure position pour trouver le problème.
---
### Apprentissages faits avec l’aide de l’IA

- J'ai commencé à demander à Chatgpt des questions sur les modèles d'arme contenu dans le jeu. Chatgpt m'a indiqué quels fichiers seraient compatible avec Blender, et m'a expliqué comment les réimporter pour Godot. Chatgpt m'a aussi expliqué somairement comment Godot gérer ces modèles. Godot utilise bel et bien des fichiers glb, mais avant de pouvoir être utilisé, ces fichiers sont manipulé dans des versions .glb.import qui contiennent toutes les données importantes pour Godot.

Au moment de ce commit, c'est ou je suis rendu. J'ai mon gun_model_2.glb, et j'essaye de remplacer le modèle précédent avec.
---
### Les difficultés rencontrées


---
### Les objectifs de la semaine suivante



# SEMAINE 4
---
## Felicya

### Du 2025-11-24 au 2025-11-30

---
### Tâches réalisées
- Gestion de la distance des mobs et des spawners
- Amélioration du fichier de procédure de mon travail

*** VOIR LE FICHIER `Felicya/Procédure création layout.md` ***
---
### Apprentissages faits avec l’aide de l’IA
- Les fonctions à modifier pour gérer les distances
- Les fonctions à utiliser
---
### Les difficultés rencontrées
- Fin des tâches planifiées -> manque d'inspiration sur quoi faire ensuite
- Manque de temps vu les évaluations dans d'autres cours
- Préparation à un examen médical qui m'a davantage affecté que prévu.
---
### Les objectifs de la semaine suivante
* Voir ce que je peux faire pour élaborer mon travail encore (j'ai déjà touché à beaucoup de fonctions, fichiers et contenu)