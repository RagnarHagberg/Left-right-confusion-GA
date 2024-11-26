extends Node2D

var goal : int 
var score = 0 : set = _set_score
var questions_answered = 0
var time_since_last_input = 0
var answers = {} #  {"time" : time_since_last_input, "start_direction" : randomizer.get_start_direction(), "correct" : correct , "goal_direction" : direction_text}
var question_amount = 50

func _process(delta: float) -> void:
	time_since_last_input += delta


func _set_score(new_score) -> void:
	score = new_score
	get_node("ScoreLabel").text = "Score: " + str(score)

@onready
var randomizer : CarPositionGenerator = get_node("RandomGenerator") 


func _ready() -> void:
	continue_car_exercise(false)
	answers.erase(0)
	get_node("CanvasLayer/Panel").hide()

func analyze_data(answer_data: Dictionary):
	var total_time = 0
	
	var wrong_left_starts_count = 0
	var wrong_right_starts_count = 0
	var wrong_top_starts_count = 0
	var wrong_bottom_starts_count = 0
	
	var correct_answers = 0
	
	for answer in answer_data.keys():
		total_time += answer_data[answer]["time"]
		
		if answer_data[answer]["correct"]:
			correct_answers += 1
			match answer_data[answer]["start_direction"]:
				"vänster":
					wrong_left_starts_count += 1
				"höger":
					wrong_right_starts_count += 1
				"ovan":
					wrong_top_starts_count += 1
				"nederst":
					wrong_bottom_starts_count += 1

	var max_faults_dir = "nederst"
	var max_faults = wrong_bottom_starts_count
	
	if wrong_left_starts_count > max_faults:
		max_faults = wrong_left_starts_count
		max_faults_dir = "vänster"
	if wrong_right_starts_count > max_faults:
		max_faults = wrong_right_starts_count
		max_faults_dir = "höger"
	if wrong_top_starts_count > max_faults:
		max_faults = wrong_top_starts_count
		max_faults_dir = "ovan"
	if wrong_bottom_starts_count > max_faults:
		max_faults = wrong_bottom_starts_count
		max_faults_dir = "nederst"
	
	var time_per_question = total_time/question_amount

	
	return {"time_per_question": time_per_question, "most_often_wrong" : max_faults_dir, "total_correct": correct_answers}

func finish():
	get_node("CanvasLayer/Panel").show()
	
	save_data()
	var answers_data = analyze_data(answers)
	print(answers_data)
	get_node("CanvasLayer/Panel/VBoxContainer/Panel/CorrectAnswers").text = "Antal rätt: " + str(answers_data["total_correct"]) # + correct_answers
	get_node("CanvasLayer/Panel/VBoxContainer/Panel2/TimePerQuestion").text = "Tid per fråga: " + str(answers_data["time_per_question"]) # tid per fråag
	get_node("CanvasLayer/Panel/VBoxContainer/Panel3/MostOftenWrong").text = "Oftast fel från: " + str(answers_data["most_often_wrong"])


func save_data():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(answers)
	# Store the save dictionary as a new line in the save file.
	save_file.store_line(json_string)

func convert_start_direction_to_direction(start_direction):
	match start_direction:
		0:
			return "nederst"
		1:
			return "vänster"
		2:
			return "ovan"
		3:
			return "höger"


func continue_car_exercise(correct: bool):
	randomizer.organize_car()
	goal = randomizer.get_goal()
	
	if correct:
		score += 1
	
	var message_text = [
		"Bilen i korsningen vill göra en U-sväng?!?!?",
		"Bilen i korsningen vill köra till vänster.",
		"Bilen i korsningen vill köra rakt fram.",
		"Bilen i korsningen vill köra till höger."
	][randomizer.get_relative_goal()]
	
	get_node("InstructionLabel").text = message_text
	
	var direction_text = ["U-sväng", "vänster", "fram", "höger"][randomizer.get_relative_goal()]
	
	#store statistics
	answers[questions_answered] = {"time" : time_since_last_input, "start_direction" : convert_start_direction_to_direction(randomizer.get_start_direction()), "correct" : correct , "goal_direction" : direction_text}
	
	time_since_last_input = 0
	questions_answered += 1
	
	if questions_answered == question_amount:
		print(answers)
		
		finish()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("1"):
		if goal == 1:
			continue_car_exercise(true)
		else:
			continue_car_exercise(false)
	elif event.is_action_pressed("2"):
		if goal == 2:
			continue_car_exercise(true)
		else:
			continue_car_exercise(false)
	elif event.is_action_pressed("3"):
		if goal == 3:
			continue_car_exercise(true)
		else:
			continue_car_exercise(false)
	elif event.is_action_pressed("4"):
		if goal == 0:
			continue_car_exercise(true)
		else:
			continue_car_exercise(false)

func _on_1_pressed() -> void:
	if goal == 1:
		continue_car_exercise(true)
	else:
		continue_car_exercise(false)

func _on_2_pressed() -> void:
	if goal == 2:
		continue_car_exercise(true)
	else:
		continue_car_exercise(false)

func _on_3_pressed() -> void:
	if goal == 3:
		continue_car_exercise(true)
	else:
		continue_car_exercise(false)

func _on_4_pressed() -> void:
	if goal == 0:
		continue_car_exercise(true)
	else:
		continue_car_exercise(false)


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/ManExercise.tscn")
