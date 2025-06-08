extends Node2D
class_name State

var change_state
var animated_sprite
var persistent_state
var velocity: float = 0.0


func setup(change_state, animated_sprite, persistent_state):
    self.change_state = change_state
    self.animated_sprite = animated_sprite
    self.persistent_state = persistent_state


func move_left():
    pass


func move_right():
    pass


func get_state_name():
    pass
