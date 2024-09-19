extends Label

@export var player: Player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = (
		tr("SCORE_DISPLAY")
		. format(
			{
				"score": str(player.score),
			}
		)
	)
