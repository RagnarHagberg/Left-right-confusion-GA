extends Node2D

# Generates a random position for the player and the box
func randomize_positions():
	var rng = RandomNumberGenerator.new()
	get_node("1000F440641503BjtGPiLrCsWlu7eYegEh5PaMxqawt6An").position = Vector2(rng.randi_range(0,648), rng.randi_range(0,1148))
	get_node("Image(2)").position = Vector2(rng.randi_range(0,648), rng.randi_range(0,1148))
	get_node("Image(2)").rotation = rng.randi_range(0,360)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		randomize_positions()
