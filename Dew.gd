extends Node2D

var age = 0

func _ready():
	
	pass # Replace with function body.



func _on_tick_timeout():
	age = age + 1
	if age == 2:
		$img.texture = load("res://assets/Plant 32w x  64h/sundew_2.png")
	elif age == 3:
		$img.texture = load("res://assets/Plant 32w x  64h/sundew_3.png")
		add_to_group("stable")
	pass # Replace with function body.

