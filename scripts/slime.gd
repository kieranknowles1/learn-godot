extends Node2D

## The slime's speed in units per second
@export var speed: int = 45

## Scene to spawn when the slime dies
@export var death_item: PackedScene

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
	if death_item:
		var item: Node2D = death_item.instantiate()
		item.global_position = global_position
		# FIXME: Need a better way to reference the GameManager, a scene-unique node is a bit of a hack
		# as it makes assumptions about the scene structure (that it has a GameManager node).
		item.game_manager = %GameManager
		get_parent().add_child(item)

	queue_free()


func _on_hitbox_component_hit(_by: Node2D) -> void:
	die()
