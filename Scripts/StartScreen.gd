extends Control



func _ready() -> void:
	get_node("Test").hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("show_test"):
		get_node("Test").show()

func _on_pratice_pressed() -> void:
	
	get_node("Pratice").hide()
	get_node("Test").hide()
	get_node("Title").hide()
	get_node("TimerLabel").show()
	get_node("AnimationPlayer").play("countdown")
	
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "countdown":
		get_tree().change_scene_to_file("res://Scenes/ManExercise.tscn")
	if anim_name == "test_countdown":
		get_tree().change_scene_to_file("res://Scenes/CarExercise.tscn")



func _on_test_pressed() -> void:
	get_node("Pratice").hide()
	get_node("Test").hide()
	get_node("Title").hide()
	get_node("TimerLabel").show()
	get_node("AnimationPlayer").play("test_countdown")
