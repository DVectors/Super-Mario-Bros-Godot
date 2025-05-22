extends State

class_name PlayerMoveState

var move_speed = Vector2(180, 0)
var min_move_speed = 0.005
var friction = 0.32

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("mario_walk")

	if animated_sprite.flip_h:
		move_speed.x *= -1
	persistent_state.velocity += move_speed
	
func _physics_process(delta: float) -> void:
	if abs(persistent_state.velocity.x) < min_move_speed:
		change_state.call("idle")
	persistent_state.velocity.x *= friction
	
	if Input.is_action_just_pressed("ui_accept") and persistent_state.is_on_floor():
		change_state.call("jump")

	persistent_state.move_and_slide()
		
func move_left():
	if animated_sprite.flip_h:
		persistent_state.velocity += move_speed
	else:
		change_state.call("idle")

func move_right():
	if not animated_sprite.flip_h:
		persistent_state.velocity += move_speed
	else:
		change_state.call("idle")

func get_state_name() -> String:
	return "PlayerMoveState"
