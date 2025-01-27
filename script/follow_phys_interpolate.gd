extends Node3D

@export_node_path var target_path: NodePath = NodePath()
@export_range(0.0001, 1.0, 0.0001) var max_interoplate : float = 1.0
var target_node: Node3D
var prev_transform: Transform3D
var cur_transform: Transform3D
var update_required :bool = false

func _ready() -> void:
	self.top_level = true # As we are using this, we can set self.transform insted of global_transform
	target_node = get_node(target_path)
	
	transform  = target_node.global_transform
	prev_transform = transform
	cur_transform = transform

func _physics_process(delta) -> void:
	update_required =  true


func _process(delta) -> void:
	if update_required:
		prev_transform = cur_transform
		cur_transform = target_node.global_transform
	# Interpolate between physics steps
	var physics_fraction = clampf(Engine.get_physics_interpolation_fraction(), 0.0, 1.0)
	transform = prev_transform.interpolate_with(cur_transform, physics_fraction)
