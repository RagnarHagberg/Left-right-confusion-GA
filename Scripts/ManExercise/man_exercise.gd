extends Node2D
@onready var box: Area2D = $Man/Box
@onready var man: Sprite2D = $Man


func _process(delta: float) -> void:
	# Calculates if the box is on the left or right side 
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		man.rotation = randf_range(0,2*PI)
		var box_angle = randf_range(0,2*PI)
		var box_distance = randf_range(300,500)
		box.rotation = -man.rotation
		
		
		box.position = Vector2(cos(box_angle), sin(box_angle)) * box_distance
		if box_angle > PI/2 and box_angle < 3*PI/2:
			pass
			print('Vänster')
		else:
			pass
			print('Höger')
	
	
