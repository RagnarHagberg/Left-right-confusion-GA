extends Node2D
@onready var box: Area2D = $Man/Box
@onready var man: Sprite2D = $Man

var new_side : String
var correct: int = 0
var incorrect: int = 0

func _ready() -> void:
	move()

func _process(delta: float) -> void:
	# Calculates if the box is on the left or right side 
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		if Input.is_action_just_pressed("ui_left"):
			update_label("left")
		if Input.is_action_just_pressed("ui_right"):
			update_label("right")
		move()


func move():
	man.rotation = randf_range(0,2*PI)
	box.rotation = -man.rotation
	
	var box_angle = randf_range(0,2*PI)
	var box_distance = randf_range(300,500)
	
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
	
	if box_angle > PI/2 and box_angle < 3*PI/2 :
		new_side = "left"
	else:
		new_side = "right"
		
func update_label(direction_pressed):
	if direction_pressed == "left":
		if new_side == "left":
			get_node("FeedbackLabel").text = "Rätt"
			get_node("FeedbackLabel").set('theme_override_colors/font_color',  Color.WEB_GREEN)
			
			correct += 1
		else:
			get_node("FeedbackLabel").text = "Fel"
			get_node("FeedbackLabel").set('theme_override_colors/font_color',  Color.RED)
			
			incorrect+=1
	
	if direction_pressed == "right":
		if new_side == "right":
			get_node("FeedbackLabel").text = "Rätt"
			get_node("FeedbackLabel").set('theme_override_colors/font_color',  Color.WEB_GREEN)
			
			correct += 1
		else:
			get_node("FeedbackLabel").text = "Fel"
			get_node("FeedbackLabel").set('theme_override_colors/font_color',  Color.RED)
			
			incorrect +=1


func _on_left_button_pressed() -> void:
	update_label("left")
	move()

func _on_rightbutton_pressed() -> void:
	update_label("right")
	move()
