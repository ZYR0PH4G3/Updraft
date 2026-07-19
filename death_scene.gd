extends Node2D

@onready var score_display: RichTextLabel = $"Your Score"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if score_display:
		score_display.text = "Your Score: " + str(Global.final_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_scree.tscn") # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
