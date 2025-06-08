extends Enemy
class_name ShelledEnemy

@export_category("Shell Type")
@export var shell: PackedScene # Give the enemy a shell that will spawn after they've been stomped


func handle_stomp_death() -> void:
    print("Spawning shell")

    if shell != null:
        var shell_instance: Node2D = shell.instantiate()
        shell_instance.global_position = global_position # set the position of shell to where the enemy currently is
        get_parent().add_child(shell_instance) # Adding shell to the parent will prevent deletion when the enemy dies

    super()
