extends CharacterBody2D

class_name Enemy

@export var speed: float = 20
@export var points: int = 100

@export var is_spiky: bool = false
@export var can_fly: bool = false
@export_enum("Left", "Right") var start_direction: String = "Left"

var direction: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = set_start_direction()
	
func set_start_direction() -> int:
	if start_direction == "Left":
		return -1
	else:
		return 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	
	position.x += direction * speed * delta
	
	move_and_slide()
	
func handle_gravity(delta: float) -> void:
	if not can_fly:
		if not is_on_floor():
			velocity += get_gravity() * delta # Apply gravity
			
func detect_wall() -> void:
	pass
