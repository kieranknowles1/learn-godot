extends Node2D

## The slime's speed in units per second
@export var speed: int = 45

@onready var sprite: AnimatedSprite2D = $Sprite

@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight

var direction = Vector2.RIGHT

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# If we hit a wall, change direction. This is reflected in the sprite flip.
	# NOTE: Ledges are not handled, and there is no gravity.
	if ray_cast_left.is_colliding():
		direction = Vector2.RIGHT
		sprite.flip_h = false
	elif ray_cast_right.is_colliding():
		direction = Vector2.LEFT
		sprite.flip_h = true

	position += direction * speed * delta

func die() -> void:
	queue_free()
