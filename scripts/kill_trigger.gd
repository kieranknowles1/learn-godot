extends Area2D

const SLOW_MOTION = 0.5

@onready var restart_delay: Timer = $RestartDelay

# Kill the player on contact
func _on_body_entered(body: Node2D) -> void:
	# Apply a slow motion effect. Note that this affects the timer to restart the scene.
	Engine.time_scale = SLOW_MOTION
	restart_delay.start()

	# Play the death animation
	if body.has_method("die"):
		body.die()

func _on_restart_delay_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
