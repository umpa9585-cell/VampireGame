extends Control

@onready var humanity_bar: ProgressBar = $HUDPanel/VBox/HumanityBar
@onready var blood_bar: ProgressBar = $HUDPanel/VBox/BloodBar
@onready var district_bar: ProgressBar = $HUDPanel/VBox/DistrictBar
@onready var action_label: Label = $HUDPanel/VBox/ActionLabel
@onready var hint_label: Label = $HUDPanel/VBox/HintLabel
@onready var objective_label: Label = $HUDPanel/VBox/ObjectiveLabel

func update_values(humanity: int, blood: int, district: int, action_text: String) -> void:
	humanity_bar.value = humanity
	blood_bar.value = blood
	district_bar.value = district
	action_label.text = action_text

func update_hint(hint_text: String) -> void:
	hint_label.text = hint_text

func update_objective(objective_text: String) -> void:
	objective_label.text = objective_text
