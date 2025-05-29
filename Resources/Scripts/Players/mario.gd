extends CharacterBody2D

class_name PersistentState

#const SPEED: float = 100
#const JUMP_VELOCITY: float = -400.0

const BOUNCE_VELOCITY: float = -500.0

var state
var state_factory

@onready var raycast_2d: RayCast2D = $RayCast2D

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
	state.setup(callable, $AnimatedSprite2D, self)
	state.name = "current_state"
	add_child(state)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta # Apply gravity - Persistent across all states
	
	__handle_collisions()
	
func __handle_collisions() -> void:
	if raycast_2d.is_colliding():
		var collision: Object = raycast_2d.get_collider()
		
		if collision is Enemy:				
			var enemy: Enemy = collision as Enemy # Cast collision as enemy to access its methods
			
			velocity.y = BOUNCE_VELOCITY
			enemy.die(DeathTypes.STOMPED)
			
func __stomp() -> void:
	pass
