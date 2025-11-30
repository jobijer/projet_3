extends Area3D

const SPEED = 60.0
const RANGE = 60.0
const MESH_PATH = "Projectile"
const bullet_color = Color.LIME_GREEN
var travelled_distance = 0.0

func _ready():
	# 1. Get the MeshInstance3D node
	var mesh: MeshInstance3D = get_node(MESH_PATH)

	if mesh:
		var material = mesh.get_surface_override_material(0)
		
		if material == null:
			material = mesh.mesh.surface_get_material(0)
			if material:
				material = material.duplicate()
				mesh.set_surface_override_material(0, material) # Apply the duplicated material

		# 3. Apply the desired color to the material's albedo
		if material is StandardMaterial3D:
			material.albedo_color = bullet_color
			print("Bullet color set to: ", bullet_color)
		elif material:
			# Handle other material types if necessary (e.g., ShaderMaterial)
			print("Mesh material found but is not StandardMaterial3D.")
	else:
		print("Error: Mesh node not found at path: ", MESH_PATH)

func _physics_process(delta):
	position += -transform.basis.z * SPEED * delta
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(2)
