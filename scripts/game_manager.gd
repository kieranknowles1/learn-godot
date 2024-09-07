class_name GameManager extends Node


var score: int = 0
var max_score: int = 0

func add_point():
	score += 1

func add_coin():
	max_score += 1
