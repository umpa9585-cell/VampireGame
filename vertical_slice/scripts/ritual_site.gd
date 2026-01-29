extends Node3D

@export var humanity_boost := 12
@export var blood_cost := 8
@export var district_boost := 6
@export var display_name := "Masquerade Shrine"

var used := false

func interact(player: Node) -> void:
	if used:
		return
	used = true
	var world := get_tree().get_first_node_in_group("world")
	if world and world.has_method("register_ritual"):
		world.register_ritual(humanity_boost, blood_cost, district_boost, display_name)

func get_interaction_hint() -> String:
	return "Perform ritual at %s" % display_name
