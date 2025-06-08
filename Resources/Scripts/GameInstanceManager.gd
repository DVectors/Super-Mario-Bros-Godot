extends Node

signal points_amount_changed(new_points_amount: int)
signal coins_amount_changed(new_coins_amount: int)
signal lives_amount_changed(new_lives_amount: int)
var player_name: String = "Daniel"
var points: int         = 0
var coins: int          = 0
var lives: int          = 3


func get_player_name() -> String:
    return player_name


func add_points(points_gained: int) -> void:
    points += points_gained
    points_amount_changed.emit(points)


func get_points() -> int:
    return points


func add_coins(coins_gained: int) -> void:
    coins += coins_gained

    if coins >= 100:
        var extra_lives: int = coins / 100 # Get amount of lives gained
        coins = coins % 100 # Get remaining coins after going over

        add_lives(extra_lives)

    coins_amount_changed.emit(coins)


func get_coins() -> int:
    return coins


func add_lives(lives_gained: int) -> void:
    SoundManager.play("1up")
    lives += lives_gained

    lives_amount_changed.emit(lives)


func get_lives() -> int:
    return lives
