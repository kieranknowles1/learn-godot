extends Area2D

@onready var restart_delay: Timer = $RestartDelay

# Kill the player on contact
func _on_body_entered(body: Node2D) -> void:
	if not restart_delay.is_stopped():
		return

	# FIXME: If the trigger is destroyed after death, the game softlocks,
	# as restart_delay no longer exists
	# Should instead attach the timer to GameManager, and make it responsible for restarting the game
	restart_delay.start()

	# Play the death animation
	if body.has_method("die"):
		body.die()

func _on_restart_delay_timeout() -> void:
	get_tree().reload_current_scene()
