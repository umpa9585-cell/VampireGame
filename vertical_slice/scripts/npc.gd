extends Node3D

@export var npc_type := "civilian"
@export var display_name := "Londoner"
@export var humanity_delta := -10
@export var blood_gain := 15

@onready var mesh: MeshInstance3D = $MeshInstance3D

var is_fed_on := false

func interact(player: Node) -> void:
	if is_fed_on:
		return
	is_fed_on = true
	var world := get_tree().get_first_node_in_group("world")
	if world and world.has_method("register_feed"):
		world.register_feed(npc_type, humanity_delta, blood_gain, display_name)
	_apply_fed_visuals()

func _apply_fed_visuals() -> void:
	if mesh.material_override:
		var faded := mesh.material_override.duplicate()
		if faded is StandardMaterial3D:
			faded.albedo_color = faded.albedo_color.darkened(0.6)
		mesh.material_override = faded
