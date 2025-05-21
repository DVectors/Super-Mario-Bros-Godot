class_name StateFactory

var states

func _init():
	states = {
		"idle": PlayerIdleState,
		"move": PlayerMoveState,
		"jump": PlayerJumpState,
		"fall": PlayerFallState
	}

func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	printerr("Invalid state: " + state_name)
		
