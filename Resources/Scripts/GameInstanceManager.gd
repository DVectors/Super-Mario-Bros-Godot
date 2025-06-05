extends Node

class_name GameInstanceManager

static var player_name: String = "Daniel"
static var points : int = 0
static var coins : int = 0
static var lives : int = 3

static func get_player_name() -> String:
	return player_name

static func add_points(points_gained: int) -> void:
	points += points_gained

static func get_points() -> int:
	return points
	
static func add_coins(coins_gained: int) -> void:
	coins += coins_gained
	
	if coins >= 100:
		lives += 1
		coins = 0

static func get_coins() -> int:
	return coins
	
static func get_lives() -> int:
	return lives
