extends Area2D

@export var movement_distance: float = 150.0
@export var speed: float = 1.0

var start_x: float
var time_passed: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_x = global_position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta * speed
	
	var offset = sin(time_passed) * movement_distance
	
	global_position.x = start_x + offset


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Spaceship":
		print("GameOver!")
		get_tree().reload_current_scene()
