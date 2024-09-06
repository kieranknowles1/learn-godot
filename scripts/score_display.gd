extends Label

@onready var game_manager: Node = %GameManager

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "Score: " + str(game_manager.score) + " / " + str(game_manager.max_score)
