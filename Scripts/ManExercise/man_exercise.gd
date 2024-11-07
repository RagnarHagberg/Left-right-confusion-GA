extends Node2D
@onready var box: Area2D = $Man/Box
@onready var man: Sprite2D = $Man

func _input(event: InputEvent) -> void:
	
	pass

func _process(delta: float) -> void:
	# Calculates if the box is on the left or right side 
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		man.rotation = randf_range(0,2*PI)
		var box_angle = randf_range(0,2*PI)
		var box_distance = randf_range(300,500)
		box.rotation = -man.rotation
		

		# Corrects box position if its indecipherable whether the box is to the left or right. 
		var adjusting_angle = 30*2*PI/360
		# Behind to the right correction
		if box_angle < PI/2 and box_angle > PI/2-adjusting_angle:
			box_angle = PI/2-adjusting_angle
		# Behind to the left correction
		elif box_angle > PI/2 and box_angle < PI/2 + adjusting_angle:
			box_angle = PI/2 + adjusting_angle
		# In front to the left correction
		elif box_angle < 3*PI/2 and box_angle > 3*PI/2-adjusting_angle:
			box_angle = 3*PI/2-adjusting_angle
		# In front to the right correction
		elif box_angle > 3*PI/2 and box_angle < 3*PI/2 + adjusting_angle:
			box_angle = 3*PI/2 + adjusting_angle
		
		box.position = Vector2(cos(box_angle), sin(box_angle)) * box_distance
		if box_angle > PI/2 and box_angle < 3*PI/2:
			print('Vänster')
		else:
			pass
			print('Höger')
	
