extends Label

@export var game_manager: GameManager

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = tr("SCORE_DISPLAY").format({
		"score": str(game_manager.score),
		"max_score": str(game_manager.max_score),
	})
