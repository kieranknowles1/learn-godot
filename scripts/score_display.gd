extends Label

@onready var game_manager: Node = %GameManager

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = tr("END_MESSAGE").format({
		"score": str(game_manager.score),
		"max_score": str(game_manager.max_score),
	})
