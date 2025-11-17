# Godot Engine – Système Audio Complet

Ce document résume et explique en détail *toutes* les sections audio du Godot Engine :
- Audio Buses
- Audio Effects
- Audio Streams
- Synchronisation Gameplay ↔ Audio
- Enregistrement Microphone
- Text-To-Speech

---

# 1. Audio Buses

## 1.1. C’est quoi un audio bus ?
Un **audio bus** est une “ligne” par laquelle passe un ou plusieurs sons.
Chaque bus peut :
- recevoir des sons
- appliquer des effets
- ajuster leur volume
- les rediriger vers un autre bus

Ce système permet un **mixage audio professionnel**.

Exemples de buses :
- Master
- Music
- SFX
- UI
- Voice

## 1.2. Volume en décibels (dB)
Godot utilise les **décibels** :
- 0 dB = volume normal
- -6 dB = moitié aussi fort
- -12 dB = ¼ du volume
- +6 dB = deux fois plus fort

## 1.3. Routing
Tu peux router un bus vers un autre (ex. SFX → Master).

## 1.4. Désactivation automatique
Godot peut désactiver un bus inactif pour économiser la CPU.

---

# 2. Audio Effects

## 2.1. Principe
Les effets s’appliquent **sur les buses**, pas sur les sons.

## 2.2. Exemples d’effets
- Amplify
- Compressor / Limiter
- EQ6 / EQ10 / EQ21
- HighPass / LowPass / BandPass
- Reverb
- Chorus / Flanger / Phaser
- Distortion
- PitchShift
- StereoEnhance

## 2.3. Ordre des effets
L’ordre change totalement le rendu sonore.

---

# 3. Audio Streams

## 3.1. Types de lecteurs
- AudioStreamPlayer (non-spatial)
- AudioStreamPlayer2D (spatialisation 2D)
- AudioStreamPlayer3D (spatialisation 3D + distance + Doppler)

## 3.2. Types de streams
- WAV, OGG, MP3
- AudioStreamRandomizer (variations aléatoires)

## 3.3. Boucles
Support de loop points pour des musiques parfaites en boucle.

---

# 4. Synchronisation Avec l’Audio

## 4.1. Utilité
Idéal pour :
- jeux rythmiques
- événements sync sur la musique
- effets de beat

## 4.2. Comment
Godot permet d’obtenir :
- la position exacte dans la piste
- un horodatage audio précis
- une synchronisation meilleure que le simple delta()

---

# 5. Enregistrement Microphone

## 5.1. Prérequis
- Permission micro
- Activation de l’input audio

## 5.2. Pipeline
1. Capture du micro en AudioStream
2. Envoi vers bus
3. Application d’effets
4. Relecture ou sauvegarde

## 5.3. Usages
- voix du joueur
- karaoké
- mini-jeux
- visualisation audio

---

# 6. Text-To-Speech (TTS)

## 6.1. Principe
Transforme du texte en voix.

## 6.2. Paramètres
- langue
- vitesse
- pitch

## 6.3. Usages
- narration dynamique
- accessibilité
- dialogues interactifs

---

# 7. Résumé Global

| Fonction | Utilité |
|---------|---------|
| Audio Buses | Mixage global et structure |
| Audio Effects | Traitement audio professionnel |
| Audio Streams | Lecture de sons/musiques |
| Sync With Audio | Gameplay rythmique et timing |
| Microphone | Enregistrement temps réel |
| TTS | Génération vocale |

---

# 8. Recommandations Finales
- Toujours organiser les buses.
- Utiliser des EQ/compresseurs pour un mix propre.
- Utiliser Randomizer pour éviter la répétition.
- Tester casque + haut-parleurs.
- WAV pour SFX courts / OGG pour musique longue.

---

# 9. Conclusion
Godot offre un système audio complet : mixage pro, effets, spatialisation, synchronisation, enregistrement, et synthèse vocale.
