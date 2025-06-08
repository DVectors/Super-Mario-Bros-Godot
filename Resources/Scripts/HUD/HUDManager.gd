extends Control
class_name HUDManager

@onready var player_label: RichTextLabel = $PlayerLabel
@onready var player_score_label: RichTextLabel = $PlayerLabel/PlayerScoreLabel
@onready var coins_amount_label: RichTextLabel = $CoinAmountLabel
@onready var lives_amount_label: RichTextLabel = $LivesAmountLabel


func _ready() -> void:
    # Get relevant signals from the InstanceManager in order to update appropriate hud values
    GameInstanceManager.connect("points_amount_changed", _on_points_amount_changed)
    GameInstanceManager.connect("coins_amount_changed", _on_coins_amount_changed)
    GameInstanceManager.connect("lives_amount_changed", _on_lives_amount_changed)

    # Force initial values on start so that they are displayed properly
    _on_player_name_changed(GameInstanceManager.get_player_name())
    _on_points_amount_changed(GameInstanceManager.get_points())
    _on_coins_amount_changed(GameInstanceManager.get_coins())
    _on_lives_amount_changed(GameInstanceManager.get_lives())


func _on_player_name_changed(new_player_name: String) -> void:
    player_label.text = new_player_name


func _on_points_amount_changed(new_points_amount: int) -> void:
    player_score_label.text = str(new_points_amount).pad_zeros(7)


func _on_coins_amount_changed(new_coins_amount: int) -> void:
    coins_amount_label.text = "x%s" % str(new_coins_amount).pad_zeros(2)


func _on_lives_amount_changed(new_lives_amount: int) -> void:
    lives_amount_label.text = "x%s" % str(new_lives_amount).pad_zeros(2) 
	
