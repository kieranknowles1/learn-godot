extends Area2D


# Kill the player on contact
func _on_body_entered(body: Node2D) -> void:
	# Play the death animation
	if body.has_method("die"):
		body.die()
