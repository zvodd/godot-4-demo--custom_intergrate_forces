extends Node3D

@export var rotation_speed : float = 2.0;
@export var direction : Vector3 = Vector3.UP;
#@onready var rot : float = 0

func _process(delta: float) -> void:
	var rot = fmod(rotation_speed * delta, TAU) 
	transform.basis *= Basis(Quaternion(direction,  rot))
