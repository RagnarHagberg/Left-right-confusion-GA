extends Node2D

@onready var man_node = get_node("Man")
@onready var box_node = get_node("Box")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		man_node.rotation = randf_range(0,2*PI)
	
	
	
