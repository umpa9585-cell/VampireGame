extends Node3D

@onready var ui: Control = $CanvasLayer/UI

var humanity := 62
var blood := 40
var district_health := 78
var drift_timer := 0.0

func _ready() -> void:
	add_to_group("world")
	_update_ui("Awakened in Whitechapel")
	_set_objective("Hunt for blood, then cleanse the shrine.")

func _process(delta: float) -> void:
	drift_timer += delta
	if drift_timer > 6.0:
		drift_timer = 0.0
		var target := 55
		humanity = clamp(humanity + sign(target - humanity), 0, 100)
		_update_ui("Humanity drift")

func register_feed(npc_type: String, humanity_delta: int, blood_gain: int, display_name: String) -> void:
	humanity = clamp(humanity + humanity_delta, 0, 100)
	blood = clamp(blood + blood_gain, 0, 100)
	var impact := int(abs(humanity_delta) * 0.6)
	district_health = clamp(district_health - impact, 0, 100)
	var action_text := "Fed on %s (%s)" % [display_name, npc_type]
	_update_ui(action_text)

func register_ritual(humanity_boost: int, blood_cost: int, district_boost: int, display_name: String) -> void:
	humanity = clamp(humanity + humanity_boost, 0, 100)
	blood = clamp(blood - blood_cost, 0, 100)
	district_health = clamp(district_health + district_boost, 0, 100)
	_update_ui("Ritual cleansed at %s" % display_name)

func set_interaction_hint(hint_text: String) -> void:
	if ui and ui.has_method("update_hint"):
		ui.update_hint(hint_text)

func _set_objective(objective_text: String) -> void:
	if ui and ui.has_method("update_objective"):
		ui.update_objective(objective_text)

func _update_ui(action_text: String) -> void:
	if ui and ui.has_method("update_values"):
		ui.update_values(humanity, blood, district_health, action_text)
