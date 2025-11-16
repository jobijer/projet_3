## 1. Introduction

- Animation in games makes characters and environments feel alive.  
- In Godot, animations work in both 2D and 3D, but this guide covers 2D only.  
- There are two main ways to animate in 2D:
  - Using AnimatedSprite2D – for simple frame-based animations (like a flipbook).  
  - Using AnimationPlayer – for more complex animations that modify properties, positions, or even other nodes.  
- Understanding both will help you bring your characters, menus, and gameplay elements to life.

---

## 2. 2D Animation Nodes

| Node Type | Description | Typical Use |
|------------|-------------|--------------|
| AnimatedSprite2D | Plays through a sequence of images (frames) from a sprite sheet or frame set. | Character or item animations like walking, jumping, or spinning. |
| AnimationPlayer | Creates timeline-based animations that can affect any property of any node. | Moving objects, fading, rotating, or controlling layered animations. |
| AnimationTree | Combines multiple AnimationPlayer animations for blending and state transitions. | Character action states like idle–walk–run transitions. |

### Choosing Which to Use
- Use AnimatedSprite2D for simple looping or frame-based animations.  
- Use AnimationPlayer for anything involving multiple node movements, UI, or property changes.  
- Use AnimationTree if your character has multiple animation states (like a full player controller).

---

## 3. AnimatedSprite2D Basics

- Add an `AnimatedSprite2D` node to your scene.  
- In the Inspector, assign a SpriteFrames resource.  
- Import your sprite sheet or individual frames, and define animations (like “idle”, “run”, “jump”).  
- Use the animation dropdown to manage your frame sets.  

### Common Functions
- `play("animation_name")` → Starts a specific animation.  
- `stop()` → Stops the current animation.  
- `is_playing()` → Checks if an animation is currently playing.

### Example (GDScript)
```gdscript
extends AnimatedSprite2D

func _ready():
    play("idle")  # Start the idle animation

func _process(delta):
    if Input.is_action_pressed("ui_right"):
        play("run")
    elif Input.is_action_pressed("ui_left"):
        play("run")
        flip_h = true
    else:
        play("idle")
```

---

## 4. AnimationPlayer Basics

- Add an `AnimationPlayer` node to your scene.  
- In the bottom panel, click Animation → New Animation to create one.  
- You can animate any property (position, rotation, visibility, sprite frame, etc.).  
- Each Animation has keyframes that record property changes over time.

### Steps
1. Select a node to animate.  
2. Move to the frame you want in the timeline.  
3. Adjust a property (like position or rotation).  
4. Click the key icon to insert a keyframe.  
5. Repeat to create movement or transitions.  

### Example (GDScript)
```gdscript
extends Node2D

func _ready():
    var anim_player = $AnimationPlayer
    anim_player.play("open_door")
```

---

## 5. Useful Animation Tracks

| Track Type | What It Does | Example |
|-------------|---------------|----------|
| Value Track | Changes properties over time. | Move position, change opacity. |
| Call Method Track | Calls functions during the animation. | Play sound mid-animation. |
| Audio Track | Plays audio clips synced to animation timing. | Footsteps, voice lines. |
| Animation Track | Plays or blends other animations. | Nesting or combining effects. |

---

## 6. AnimationTree (Optional, Advanced)

If you have multiple animations (idle, walk, run, jump), you can blend and switch them easily using an AnimationTree node.

- Add an AnimationTree node and reference the same AnimationPlayer.  
- Set Active = On and choose “AnimationNodeStateMachine” mode.  
- Create states like “Idle”, “Run”, “Jump”, and connect them via transitions.  
- This helps automate switching animations during gameplay using code.

### Example (Setup)
```gdscript
var animation_tree
var state_machine

func _ready():
    animation_tree = $AnimationTree
    state_machine = animation_tree.get("parameters/playback")
    animation_tree.active = true
    state_machine.travel("Idle")  # Start in idle state
```

---

## 7. Animation Tips and Best Practices

- Keep animation names consistent, like “idle”, “run”, “jump”.  
- Loop idle and walk animations, stop others when finished.  
- Make sure all sprite frames are the same size.  
- For symmetrical actions (left/right), use the `flip_h` property to mirror sprites.  
- Consider shorter animations for snappier gameplay feedback.  
- Use AnimationPlayer for anything that needs smooth easing, scaling, or multi-node effects.

---

## 8. Applying This to Your 2D Game

For your proof-of-concept project:

- Player character: Use AnimatedSprite2D for walk/jump cycles.  
- Environmental effects (like doors or platforms): Use AnimationPlayer.  
- Special effects (like item pickups): Use a short AnimatedSprite2D loop.  
- UI transitions: Fade or move panels with AnimationPlayer.  
- Complex characters (optional): Use AnimationTree for smoother state switching.  

---

## 9. Example Animation Setup

### Simple Scene Example
```
Player (CharacterBody2D)
├── AnimatedSprite2D
└── CollisionShape2D
```

### Simple Script Example
```gdscript
extends CharacterBody2D

@export var speed = 200

func _physics_process(delta):
    var direction = Input.get_axis("ui_left", "ui_right")

    if direction != 0:
        $AnimatedSprite2D.play("run")
        $AnimatedSprite2D.flip_h = direction < 0
        velocity.x = direction * speed
    else:
        $AnimatedSprite2D.play("idle")
        velocity.x = move_toward(velocity.x, 0, speed)

    move_and_slide()
```

---

## 10. Optional Next Steps

To go further, explore:
- AnimationBlendSpace2D: For smooth directional transitions (e.g., diagonals).  
- Tween nodes (in code): For lighter, code-based motion or fades.  
- Signal connections: Start or stop animations based on events like collisions or inputs.  
- Animation resource reuse: Save SpriteFrames or Animations as reusable assets across scenes.

---

**In summary:**  
Godot’s 2D animation tools let you create both simple frame-based motion and complex property-based effects. Start small with AnimatedSprite2D, move to AnimationPlayer for custom transitions, and use AnimationTree once your characters have multiple states. These tools together can make your 2D game smooth, expressive, and visually polished.
```