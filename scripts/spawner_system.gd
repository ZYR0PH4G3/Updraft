extends Node2D

@export var crusher_scene: PackedScene
@export var spaceship: CharacterBody2D

@export var spawn_distance: float = 800.0
@export var render_ahead: float = 800.0

var next_spawn_y: float = 0.0

@onready var score_label: RichTextLabel = $CanvasLayer/Score
var score: int = 0

func _ready() -> void:
	if spaceship:
		next_spawn_y = spaceship.global_position.y - spawn_distance

func _process(_delta: float) -> void:
	if not spaceship:
		return
	
	while spaceship.global_position.y - render_ahead < next_spawn_y:
		spawn_obstacle()

func spawn_obstacle() -> void:
	var new_obstacle = crusher_scene.instantiate()
	
	new_obstacle.global_position.y = next_spawn_y
	
	new_obstacle.global_position.x =100.0
	
	if "start_x" in new_obstacle:
		new_obstacle.global_position.x += randf_range(-50.0, 50.0)
	
	add_child(new_obstacle)
	
	next_spawn_y -= spawn_distance

func add_point() -> void:
	score += 1
	if score_label:
		score_label.text = str(score)
