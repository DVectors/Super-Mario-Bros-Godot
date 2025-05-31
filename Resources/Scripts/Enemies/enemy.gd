extends CharacterBody2D

class_name Enemy

@export_category("General")
@export var speed: float = 20
@export var points: int = 100

@export_category("Behaviour Variables")
@export var is_spiky: bool = false
@export var can_fly: bool = false
@export var can_pass_walls: bool = false
@export var is_platform: bool = false
@export var can_turn_from_edge: bool = false
@export var can_move: bool = true
@export var is_friendly: bool = false
@export_enum("Left", "Right") var start_direction: String = "Left"

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var direction: int
const Directions: Dictionary = {
	LEFT = -1,
	RIGHT = 1
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = set_start_direction()
	__set_enemy_to_friendly()
		
	
func set_start_direction() -> int:
	if start_direction == "Left":
		return Directions.LEFT
	else:
		return Directions.RIGHT
		
func __set_enemy_to_friendly() -> void:
	if  is_friendly:
		set_collision_layer_value(2, false) # Disable object on the enemy layer
		set_collision_layer_value(4, true) # Set layer to friendly, so player can pass through them
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	__handle_gravity(delta)

	__detect_wall()
	
	if can_move:
		velocity.x = direction * speed
	
	move_and_slide()
	
func __handle_gravity(delta: float) -> void:
	if not can_fly:
		if not is_on_floor():
			velocity += get_gravity() * delta # Apply gravity
			
func __detect_wall() -> void:
	if is_on_wall():
		if direction == Directions.LEFT: #Left
			_flip_direction()
			direction = Directions.RIGHT
		elif direction == Directions.RIGHT: #Right
			_flip_direction()
			direction = Directions.LEFT

func _flip_direction():
	animated_sprite_2d.flip_h = not animated_sprite_2d.flip_h
	
func die(death_type: int) -> void:
	collision_shape_2d.set_deferred("disabled", true)

	match death_type:
		DeathTypes.STOMPED:
			__handle_stomp_death()
		DeathTypes.FIREBALL:
			pass
		DeathTypes.HIT:
			pass

func __handle_stomp_death() -> void:
	SoundManager.play("stomp")
	queue_free()
