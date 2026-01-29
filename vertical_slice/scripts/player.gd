extends CharacterBody3D

@export var walk_speed := 4.5
@export var run_speed := 7.5
@export var jump_velocity := 6.0
@export var mouse_sensitivity := 0.0025

@onready var camera_pivot: Node3D = $CameraPivot
@onready var camera: Camera3D = $CameraPivot/Camera3D
@onready var interact_area: Area3D = $InteractArea

var gravity := ProjectSettings.get_setting("physics/3d/default_gravity")
var interactable: Node = null

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	interact_area.area_entered.connect(_on_area_entered)
	interact_area.area_exited.connect(_on_area_exited)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		camera_pivot.rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50.0), deg_to_rad(60.0))
	if event.is_action_pressed("ui_cancel"):
		var next_mode := Input.MOUSE_MODE_VISIBLE if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED
		Input.set_mouse_mode(next_mode)

func _physics_process(delta: float) -> void:
	var direction := Vector3.ZERO
	var forward := -camera_pivot.transform.basis.z
	var right := camera_pivot.transform.basis.x

	direction += forward * Input.get_action_strength("move_forward")
	direction -= forward * Input.get_action_strength("move_back")
	direction -= right * Input.get_action_strength("move_left")
	direction += right * Input.get_action_strength("move_right")
	direction = direction.normalized()

	var target_speed := run_speed if Input.is_action_pressed("sprint") else walk_speed
	velocity.x = direction.x * target_speed
	velocity.z = direction.z * target_speed

	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity

	move_and_slide()

	if Input.is_action_just_pressed("interact") and interactable:
		if interactable.has_method("interact"):
			interactable.interact(self)

func _on_area_entered(area: Area3D) -> void:
	var owner := area.get_parent()
	if owner != self and owner.has_method("interact"):
		interactable = owner

func _on_area_exited(area: Area3D) -> void:
	var owner := area.get_parent()
	if owner == interactable:
		interactable = null
