## 1. Introduction

- Physics in games involves two key parts:
  - **Collision detection** – finding out when two objects intersect.
  - **Collision response** – determining what happens when they do.
- Godot includes a built-in physics engine for both **2D** and **3D**.
- For 2D games, you’ll focus on the 2D versions of physics nodes.
- Each collision body type behaves differently, so understanding them helps prevent bugs and improves performance.

---

## 2. 2D Collision Object Types

| Node Type | Description | Typical Use |
|------------|-------------|--------------|
| **Area2D** | Detects overlaps and can emit signals when bodies enter or exit. Can modify local physics properties (gravity, damping, etc.). | Triggers, item pickups, enemy detection zones, gravity fields |
| **StaticBody2D** | Collides with other bodies but does *not* move in response to forces. | Floors, walls, obstacles |
| **RigidBody2D** | Simulated by the physics engine. Moves and rotates due to forces, impulses, gravity, and collisions. | Physics-driven objects like crates or bouncing balls |
| **KinematicBody2D** / **CharacterBody2D** (Godot 4) | Moved via code, not physics forces. The engine handles collision detection and sliding. | Player characters or NPCs needing precise movement control |

### Choosing Which to Use
- Use **StaticBody2D** for unmoving environment objects.
- Use **RigidBody2D** for objects that should react to gravity or collisions naturally.
- Use **CharacterBody2D** for players and entities with controlled movement.
- Use **Area2D** for regions that trigger effects or detect overlaps.

---

## 3. Collision Shapes (2D)

- Every physics body needs a **collision shape** to define its boundaries.
- Common 2D shapes:
  - `CircleShape2D`
  - `RectangleShape2D`
  - `CapsuleShape2D`
  - `ConvexPolygonShape2D`
  - `ConcavePolygonShape2D`
- Use `CollisionShape2D` or `CollisionPolygon2D` nodes to attach these to physics bodies.
- **Performance Tip:** Simpler shapes and fewer collision shapes per body are more efficient.

---

## 4. RigidBody2D Details

- Controlled by the physics engine — you do not manually set position each frame.
- Move or affect it using:
  - Forces (`apply_force()`)
  - Impulses (`apply_impulse()`)
- Important properties:
  - **Mass** – affects how forces move it.
  - **Friction** – slows down sliding.
  - **Bounce (restitution)** – controls how much it rebounds on impact.
- Can “sleep” when inactive to save CPU, and “wake up” when interacted with.
- Use `_integrate_forces(state)` to customize or override physics behavior.

---

## 5. Movement and Physics Processing

- Use `_physics_process(delta)` for code related to physics and collisions.
  - Runs in sync with the physics engine.
- Use `_process(delta)` for visual or non-physics logic.
- For **CharacterBody2D**:
  - Use `move_and_slide()` or `move_and_collide()` to handle movement and collisions automatically.

---

## 6. Layers and Masks

- Every physics body has:
  - **Collision Layers** – what the object *is* (which groups it belongs to).
  - **Collision Masks** – what the object *collides with*.
- Example:
  - Player is on the “Player” layer.
  - Walls are on the “Walls” layer.
  - Coins are on the “Collectibles” layer.
- The player’s mask includes “Walls” and “Collectibles”, so it collides with both.
- Use layers and masks to fine-tune which objects interact with each other.

---

## 7. Advanced Topics

### Raycasting
- Used to detect what’s in a line or direction.
- Useful for things like:
  - Line of sight
  - Shooting or laser detection
  - Checking ground distance

### Large Worlds and Precision
- Extremely large coordinates can cause floating-point precision issues.
- Keep worlds close to origin or segment them into smaller zones.

### Troubleshooting
- Avoid directly setting position on physics bodies every frame (especially `RigidBody2D`).
- If collisions are inconsistent, check:
  - Physics step rate (in Project Settings)
  - Collision shape scaling
  - Overlapping shapes or incorrect layers

---

## 8. Applying This to Your 2D Game

For your proof-of-concept project, here’s how you might apply these principles:

- **Level Geometry:** Use `StaticBody2D` for floors, platforms, and walls.
- **Player:** Use `CharacterBody2D` for smooth, controllable movement.
- **Interactable Objects:** Use `RigidBody2D` for crates, projectiles, or bouncing objects.
- **Triggers/Events:** Use `Area2D` for collectible zones or enemy detection.
- **Movement Logic:** Place player movement and input handling in `_physics_process(delta)`.
- **Collision Layers:** Define which objects collide or trigger each other.
- **Performance Tips:**
  - Keep collision shapes simple.
  - Avoid scaling or rotating collision shapes at runtime.
  - Use sleep mode and signals where possible.

---

## 9. Optional Next Steps

To go further, explore:
- **Physics Materials:** Fine-tune bounce and friction.
- **Joints (2D):** Connect bodies together for ropes, hinges, or springs.
- **Physics Debugging Tools:** Enable visible collision shapes in the editor to visualize interactions.

---

**In summary:**  
Godot’s 2D physics system is flexible, efficient, and designed to give you the right balance between simulation and control. By combining different body types, collision shapes, and movement functions, you can create anything from platformers to puzzle games, while learning core concepts of physics-based game development.


## Exemples de code
Exemples de code concernant la physique. À noter que le code présenté est du GDScript, le language spécialisé de Godot, ce pourquoi l'affichage de code block de markdown n'est pas très beau.

### Basic player movement ('characterBody2D')
```gdscript
extends CharacterBody2D

# Adjustable variables
@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 900.0

func _physics_process(delta):
    # Apply gravity
    if not is_on_floor():
        velocity.y += gravity * delta

    # Handle movement input
    var direction = Input.get_axis("ui_left", "ui_right")
    velocity.x = direction * speed

    # Jump
    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = jump_velocity

    # Move the player and handle collisions
    move_and_slide()
```

### Static Level Collision ('staticBody2D')
Pas du code exactement, mais une représentation visuelle de la scène ou la collision doit être enregistrée

```gdscript
# Scene setup (no script required):
#  Node2D
#   └── StaticBody2D
#         └── CollisionShape2D (e.g., RectangleShape2D)

# The StaticBody2D will automatically block other bodies that collide with it.
```

### Falling crate ('rigidBody2D')
```gdscript
extends RigidBody2D

# Called when the node enters the scene tree
func _ready():
    # Example: give the crate a little push at start
    apply_impulse(Vector2(randf() * 100 - 50, -150))
```

### Collectible Area ('Area2D')
```gdscript
extends Area2D

signal collected

func _ready():
    # Connect signal when something enters the area
    connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
    if body.name == "Player":
        emit_signal("collected")
        queue_free()  # Remove the collectible
```

### Layer and Mask Setup (in Code)
```gdscript
extends RigidBody2D

func _ready():
    # Set this body to be on layer 2 ("Objects") and collide with layer 1 ("World")
    collision_layer = 1 << 1  # Layer 2
    collision_mask = 1 << 0   # Collides with Layer 1
```

### Debug: Show Collisions in Editor
1. Go to Debug → Visible Collision Shapes in the Godot editor.
2. You’ll see outlines for all physics shapes — helpful for debugging.

### Example ideas
- A player (CharacterBody2D) runs and jumps on platforms (StaticBody2D).
- Crates (RigidBody2D) fall and bounce.
- Coins (Area2D) disappear when collected.
- Use collision layers to organize interactions.