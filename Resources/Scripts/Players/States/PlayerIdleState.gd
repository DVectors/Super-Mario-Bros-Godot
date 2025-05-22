extends State

class_name PlayerIdleState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("mario_idle")
	
	persistent_state.velocity = Vector2(0, 0)
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and persistent_state.is_on_floor():
		change_state.call("jump")
	
	persistent_state.move_and_slide()
	
func _flip_direction():
	animated_sprite.flip_h = not animated_sprite.flip_h
	
func move_left():
	if animated_sprite.flip_h:
		change_state.call("move")
	else:
		_flip_direction()

func move_right():
	if not animated_sprite.flip_h:
		change_state.call("move")
	else:
		_flip_direction()

func get_state_name() -> String:
	return "PlayerIdleState"
