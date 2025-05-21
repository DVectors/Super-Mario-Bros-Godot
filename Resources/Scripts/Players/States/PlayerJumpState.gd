extends State

class_name PlayerJumpState

const JUMP_VELOCITY: float = -400.0

var move_speed: Vector2 = Vector2(180, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play("jump")
	animated_sprite.play("mario_jump")


func _physics_process(delta: float) -> void:
	persistent_state.velocity.y = JUMP_VELOCITY
	
	if persistent_state.velocity.y >= JUMP_VELOCITY:
		change_state.call("fall")	
	
	persistent_state.move_and_slide()

func get_state_name():
	return "PlayerJumpState"

func move_left():
	persistent_state.velocity.x = -1 * move_speed.x

func move_right():
	persistent_state.velocity.x = 1 * move_speed.x
