class_name HitboxComponent extends Area2D

signal hit(by: Node2D)

func on_hit(by: Node2D) -> void:
	hit.emit(by)
