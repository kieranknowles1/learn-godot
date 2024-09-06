extends Area2D



# Triggered when the player enters the coin's area.
# The player has its own physics layer, which the coin filters to.
func _on_body_entered(body: Node2D) -> void:
	print("collected")
	queue_free()
