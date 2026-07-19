extends Area2D

@export var movement_distance: float = 150.0  
@export var speed: float = 1.0               
@export var despawn_distance: float = 900.0   

var start_x: float
var time_passed: float = 0.0

func _ready() -> void:
	start_x = global_position.x

func _process(delta: float) -> void:
	time_passed += delta * speed
	
	var offset = sin(time_passed) * movement_distance
	global_position.x = start_x + offset

	var player = get_tree().get_first_node_in_group("Player")
	if not player:
		player = get_node_or_null("/root/Game scene/Ship") 
		
	if player:
		if global_position.y > player.global_position.y + despawn_distance:
			call_deferred("queue_free")



func _on_score_area_body_entered(body: Node2D) -> void:
	if body.name == "Spaceship" or body.is_in_group("Player"):
		var main_game = get_tree().current_scene
		if main_game and main_game.has_method("add_point"):
			main_game.add_point()
		
		if has_node("ScoreArea/CollisionShape2D"):
			$ScoreArea/CollisionShape2D.call_deferred("set_disabled", true)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Spaceship" or body.is_in_group("Player"):
		get_tree().call_deferred("reload_current_scene")
