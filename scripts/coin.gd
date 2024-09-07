extends Area2D

# GameManager must be unique across the scene. This kind of reference
# only works when the node is in the same scene as the script.
@onready var game_manager: GameManager = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Count the max score on start
func _ready() -> void:
	game_manager.add_coin()

# Triggered when the player enters the coin's area.
# The player has its own physics layer, which the coin filters to.
func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return

	game_manager.add_point()

	# Play the pickup animation, which handles sounds and destroys the coin.
	animation_player.play("pickup")
