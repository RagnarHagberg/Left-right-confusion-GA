extends Control





func _on_pratice_pressed() -> void:
	
	get_node("Pratice").hide()
	get_node("Test").hide()
	get_node("Title").hide()
	get_node("TimerLabel").show()
	get_node("AnimationPlayer").play("countdown")
	
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/ManExercise.tscn")
