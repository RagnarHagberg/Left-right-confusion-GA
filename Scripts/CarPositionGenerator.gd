extends Node

class_name CarPositionGenerator


var rng = RandomNumberGenerator.new()


var left_up_car = preload("res://Assets/CarExercise/LeftUpCar.png")
var right_down_car = preload("res://Assets/CarExercise/RightDownCar.png")
var goal : int
var relative_goal : int

var prev_start_direction = -1
var start_direction : int

# Called when the node enters the scene tree for the first time.

func get_goal() -> int:
	return goal

func get_relative_goal() -> int:
	return relative_goal

func get_start_direction() -> int:
	return start_direction

func organize_car() -> void:
	# Origin
	var car = get_tree().get_nodes_in_group("Car")[0]
	start_direction = randi() % 4
	while start_direction == prev_start_direction:
		start_direction = randi() % 4
	prev_start_direction = start_direction
	
	match start_direction:
		1:
			car.texture = left_up_car
			car.rotation_degrees = 276.5
			car.global_position = get_node("1Position").global_position
		2:
			car.texture = left_up_car
			car.rotation_degrees = 0.0
			car.global_position = get_node("2Position").global_position
		3:
			car.texture = right_down_car
			car.rotation_degrees = 0
			car.global_position = get_node("3Position").global_position
		0:
			car.texture = right_down_car
			car.rotation_degrees = 86.0
			car.global_position = get_node("4Position").global_position
			
	
	
	var goal_directions = [1, 2, 3]
	relative_goal = goal_directions[randi() % goal_directions.size()]
	goal = (relative_goal + start_direction) % 4;
