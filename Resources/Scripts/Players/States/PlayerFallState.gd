extends State

class_name PlayerFallState

var move_speed: Vector2 = Vector2(180, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("mario_jump")

func _physics_process(delta: float) -> void:
	if persistent_state.is_on_floor():
		change_state.call("idle")
		
	persistent_state.move_and_slide()

func get_state_name() -> String:
	return "PlayerFallState"

func move_left():
	persistent_state.velocity.x = -1 * move_speed.x

func move_right():
	persistent_state.velocity.x = 1 * move_speed.x
