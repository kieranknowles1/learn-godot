extends Node2D

const SPEED = 90

var direction: Vector2
var shot_by: Player

# The projectile has stopped moving, either by hitting something or by timing out.
var stopped = false

# Player for explosion and timeout sequences
# Responsible for deleting the projectile
@onready var animatiom: AnimationPlayer = $Animation

func init(player: Player):
	shot_by = player
	global_position = player.attack_origin.global_position

	direction = player.facing

func _on_impact() -> void:
	animatiom.play("explode")
	stopped = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if stopped:
		return
	position += SPEED * direction * delta

# We touch something, not necessarily a character
func _on_damage_area_entered(_body: Node2D) -> void:
	_on_impact()

# We touch a character, kill it if it has a die method
func _on_damage_area_body_entered(body: Node2D) -> void:
	# Destroy the stopped object if we can
	if body.has_method("die"):
		body.die()

	_on_impact()

func _on_timeout_timeout() -> void:
	if stopped:
		return
	animatiom.play("timeout")
	stopped = true
