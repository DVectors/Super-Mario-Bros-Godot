extends Control

class_name HUDManager

@onready var player_label: RichTextLabel = $PlayerLabel
@onready var player_score_label: RichTextLabel = $PlayerLabel/PlayerScoreLabel
@onready var coins_amount_label: RichTextLabel = $CoinsLabel/CoinAmountLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_label.text = GameInstanceManager.get_player_name()
	
	# Mario score tally has a digit count of 7, so this will pad the score value with 7 digits
	player_score_label.text = str(GameInstanceManager.get_points()).pad_zeros(7) 
	coins_amount_label.text = "x%s" % str(GameInstanceManager.get_coins()).pad_zeros(2)
	
