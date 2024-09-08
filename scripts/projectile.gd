extends Node2D

const SPEED = 90

var direction: Vector2

var hit = false

@onready var animatiom: AnimationPlayer = $Animation

func _on_impact() -> void:
	# This deletes the projectile automatically
	animatiom.play("explode")
	hit = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hit:
		return
	position += SPEED * direction * delta

# We touch something, not necessarily a character
func _on_damage_area_entered(_body: Node2D) -> void:
	_on_impact()

# We touch a character, kill it if it has a die method
func _on_damage_area_body_entered(body: Node2D) -> void:
	# Destroy the hit object if we can
	if body.has_method("die"):
		body.die()

	_on_impact()
