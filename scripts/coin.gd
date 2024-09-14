extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_collectable_component_collected(collector: Node) -> void:
	if collector is not Player:
		return

	collector.add_points(1)

	# Play the pickup animation, which handles sounds and destroys the coin.
	animation_player.play("pickup")
