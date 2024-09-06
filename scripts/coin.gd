extends Area2D

# GameManager must be unique across the scene. This kind of reference
# only works when the node is in the same scene as the script.
@onready var game_manager: Node = %GameManager

# Count the max score on start
func _ready() -> void:
	game_manager.add_coin()

# Triggered when the player enters the coin's area.
# The player has its own physics layer, which the coin filters to.
func _on_body_entered(body: Node2D) -> void:
	queue_free()

	game_manager.add_point()
