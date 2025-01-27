extends RigidBody3D

@export_node_path("Node3D") var gravity_center_path
@export var initial_velocity: Vector3 =  Vector3(0,0,-20)
@export var constant_gavity : float = 8.0

@onready var gravity_center_node = get_node(gravity_center_path)
@onready var phys_delta = 1.0 / Engine.physics_ticks_per_second
var first_frame: bool = true

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if first_frame:
		state.linear_velocity = initial_velocity
		first_frame = false
	
	# Get current position of gravity center
	var center_pos = gravity_center_node.global_position
	
	# Calculate vector from body to gravity center
	var force_dir = (center_pos - global_position).normalized()
	
	var force = force_dir * constant_gavity
	
	# Apply the gravitational force
	#state.apply_central_force(force) # Does nothing?
	state.apply_impulse(force * phys_delta)  # Works as intented
	

func _ready() -> void:
	# Make sure gravity is disabled as we're handling it manually
	gravity_scale = 0.0
	custom_integrator = true
