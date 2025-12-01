extends CharacterBody3D

# --- Scene References ---
@export var gun_model: Node3D
@export var war_gun_model: Node3D

# --- Game Variables ---
# Remove: var player_score: int = 0
const SWITCH_SCORE_THRESHOLD: int = 10
var current_gun: Node3D = null
var has_switched: bool = false # NEW: Prevents switching repeatedly
var game_manager = null
var better_gun = false
var recoil_accumulator: Vector3 = Vector3.ZERO
const RECOIL_DECAY: float = 2.0 # How fast the recoil wears off (higher = faster)
const GRAVITY = 9.8 * 2.0 # Example gravity value

func _ready():
	var camera = %Camera3D
	if camera:
		gun_model = camera.get_node("gun_model")
		war_gun_model = camera.get_node("war_gun_model")
		if gun_model == null or war_gun_model == null:
			push_error("Failed to find gun models under Camera3D!")
		
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	%Marker3D.rotation_degrees.y += 2.0
	_set_active_weapon(gun_model)
	gun_model.visible = true
	
	game_manager = get_parent()
	if game_manager == null or not game_manager.has_method("increase_score"): # Basic check
		push_error("Could not find the game manager node or script.")
	if gun_model != null:
		print("Gun model visibility after set:", gun_model.visible)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.5
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.2
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x, -60.0, 60.0
		)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	const SPEED = 5.5

	var input_direction_2D = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_back"
	)
	var input_direction_3D = Vector3(
		input_direction_2D.x, 0, input_direction_2D.y
	)
	var direction = transform.basis * input_direction_3D

	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

# 1. Update/Decay the recoil force
	if recoil_accumulator.length_squared() > 0.01:
		# Interpolate the accumulator back to ZERO
		recoil_accumulator = recoil_accumulator.lerp(Vector3.ZERO, delta * RECOIL_DECAY)
		velocity += recoil_accumulator * delta * 50.0 # Apply the force

	velocity.y -= 20.0 * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 10.0
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = 0.0

	move_and_slide()

	if Input.is_action_pressed("shoot") and %Timer.is_stopped():
		if not has_switched:
			shoot_bullet()
		else:
			shoot_better_bullet()


func shoot_bullet():
	const BULLET_3D = preload("bullet_3d.tscn")
	var new_bullet = BULLET_3D.instantiate()
	%Marker3D.add_child(new_bullet)

	new_bullet.global_transform = %Marker3D.global_transform

	%Timer.start()
	%AudioStreamPlayer.play()

func shoot_better_bullet():
	const BULLET_3D = preload("bullet_3d_better.tscn")
	var new_bullet = BULLET_3D.instantiate()
	
	const Y_AXIS_DAMPENING: float = 0.35 # **New Constant: Adjust this value!**
	var shooting_direction: Vector3 = %Marker3D.global_transform.basis.z
	const RECOIL_IMPULSE: float = 3.3 # A small, strong push (adjust this!)%Marker3D.add_child(new_bullet)
	%Marker3D.add_child(new_bullet)
	new_bullet.global_transform = %Marker3D.global_transform
	
	recoil_accumulator += shooting_direction * RECOIL_IMPULSE
	recoil_accumulator.y *= Y_AXIS_DAMPENING
	%Timer.start()
	%AudioStreamPlayer.play()
	
#---Main Logic ---

func _process(delta):
	# Check the global score every frame
	if game_manager != null and not has_switched:
		# Ensure game_manager (the node with game.gd) has the variable 'player_score'
		if game_manager.player_score >= SWITCH_SCORE_THRESHOLD:
			# Perform the switch
			_set_active_weapon(war_gun_model)
			%Timer.wait_time = 0.06
			has_switched = true

# Function to handle visibility and update the current_gun variable
func _set_active_weapon(target_gun: Node3D):
	# ... (same logic as before: hide all, show target) ...
	if gun_model != null:
		gun_model.visible = false
	if war_gun_model != null:
		war_gun_model.visible = false
	
	if target_gun != null:
		target_gun.visible = true
		current_gun = target_gun
		print("Switched to: ", current_gun.name)
