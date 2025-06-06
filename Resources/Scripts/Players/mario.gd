extends CharacterBody2D

class_name PersistentState

#const SPEED: float = 100
#const JUMP_VELOCITY: float = -400.0

const BOUNCE_VELOCITY: float = -500.0

var state
var state_factory

@onready var downwards_raycasts: Array[RayCast2D] = [$RayCastDownLeft, $RayCastDownRight, $RayCastDownMiddle]
@onready var stomp_area: Area2D = $StompArea
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	state_factory = StateFactory.new()
	change_state("idle")

# Input code was placed here for tutorial purposes.
func _process(_delta):
	print("Current state: " + state.get_state_name())
	if Input.is_action_pressed("ui_left"):
		move_left()
	elif Input.is_action_pressed("ui_right"):
		move_right()

func move_left():
	state.move_left()

func move_right():
	state.move_right()
	
func change_state(new_state):
	if state != null:
		state.queue_free() # Delete previous state
		
	var callable: Callable = Callable(self, "change_state")
	state = state_factory.get_state(new_state).new()
	state.setup(callable, animated_sprite_2d, self)
	state.name = "current_state"
	add_child(state)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta # Apply gravity - Persistent across all states
		__handle_downward_collisions()
		
	if is_on_floor():
		__enable_raycasts(false)
		
	__check_if_object_in_stomp_area()
	
func __handle_downward_collisions() -> void:
	__enable_raycasts(true)
	
	for raycast_2d in downwards_raycasts:
		if raycast_2d.is_colliding():
			var collision: Object = raycast_2d.get_collider()
			
			if collision is Enemy:
				var enemy: Enemy = collision as Enemy # Cast collision as enemy to access its methods
				__stomp(enemy)
				
func __check_if_object_in_stomp_area() -> void:
	for body in stomp_area.get_overlapping_bodies():
		if body is Enemy:
			print("Enemy in stomp_area")
			var enemy: Enemy = body as Enemy
			print("Kill enemy in stomp_area")
			__stomp(enemy)

func __enable_raycasts(enable: bool) -> void:
	for raycast_2d in downwards_raycasts:
		raycast_2d.enabled = enable
			
func __stomp(enemy: Enemy) -> void:
	if not enemy.is_spiky and not enemy.is_platform:
		change_state("fall")
		velocity.y = BOUNCE_VELOCITY
		
		enemy.die(DeathTypes.STOMPED)
