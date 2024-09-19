## Component for an object that can be collected by the player,
## usually doing something beneficial like increasing the player's score.
class_name CollectableComponent extends Area2D

signal collected(collector: Node)


func on_collected(collector: Node) -> void:
	collected.emit(collector)
