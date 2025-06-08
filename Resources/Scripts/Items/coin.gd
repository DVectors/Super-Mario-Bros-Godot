extends Area2D
class_name Coin

@export var coin_value: int = 1


func _on_body_entered(body: Node2D) -> void:
    if body is PersistentState: # Player
        SoundManager.play("coin")
        GameInstanceManager.add_coins(coin_value)

        queue_free()
