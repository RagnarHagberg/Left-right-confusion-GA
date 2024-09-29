extends Node2D

var goal : int 
var score = 0 : set = _set_score
var questions_answered = 0
var time_since_last_input = 0
var times_per_answer = []


func _process(delta: float) -> void:
	time_since_last_input += delta


func _set_score(new_score) -> void:
	score = new_score
	get_node("ScoreLabel").text = "Score: " + str(score)
	
@onready
var randomizer : CarPositionGenerator = get_node("RandomGenerator") 

func _ready() -> void:
	continue_car_exercise()

func continue_car_exercise():
	randomizer.organize_car()
	goal = randomizer.get_goal()
	
	var message_text = [
		"Bilen i korsningen vill göra en U-sväng?!?!?",
		"Bilen i korsningen vill svänga till vänster.",
		"Bilen i korsningen vill köra rakt fram.",
		"Bilen i korsningen vill köra till höger."
	][randomizer.get_relative_goal()]
	
	get_node("InstructionLabel").text = message_text
	
	#statistics
	times_per_answer.append(time_since_last_input)
	time_since_last_input = 0
	questions_answered += 1
	if questions_answered == 10:
		print(times_per_answer, score)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("1"):
		if goal == 1:
			score += 1
		continue_car_exercise()
	elif event.is_action_pressed("2"):
		if goal == 2:
			score += 1
		continue_car_exercise()
	elif event.is_action_pressed("3"):
		if goal == 3:
			score += 1
		continue_car_exercise()
	elif event.is_action_pressed("4"):
		if goal == 0:
			score += 1
		continue_car_exercise()

func _on_1_pressed() -> void:
	if goal == 1:
		score += 1
	continue_car_exercise()

func _on_2_pressed() -> void:
	if goal == 2:
		score += 1
	continue_car_exercise()

func _on_3_pressed() -> void:
	if goal == 3:
		score += 1
	continue_car_exercise()

func _on_4_pressed() -> void:
	if goal == 0:
		score += 1
	continue_car_exercise()
