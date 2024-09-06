extends Area2D

@onready var restart_delay: Timer = $RestartDelay

# Kill the player on contact
func _on_body_entered(body: Node2D) -> void:
	restart_delay.start()

	# Play the death animation
	if body.has_method("die"):
		body.die()

func _on_restart_delay_timeout() -> void:
	get_tree().reload_current_scene()
