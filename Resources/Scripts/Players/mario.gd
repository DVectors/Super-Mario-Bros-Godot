extends CharacterBody2D

class_name PersistentState

#const SPEED: float = 100
#const JUMP_VELOCITY: float = -400.0

var state
var state_factory

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
		velocity += get_gravity() * delta # Apply gravity
		
	
#	# Add the gravity.
#	if not is_on_floor():
#		velocity += get_gravity() * delta
#
#	# Handle jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction := Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#
#	move_and_slide()
