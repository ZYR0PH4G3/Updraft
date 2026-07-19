extends Area2D

@export var drift_speed: float = 120.0
@export var despawn_distance: float = 700.0

var direction: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction =1.0 if randf() > 0.5 else -1.0
	
	if direction == 1.0:
		global_position.x = 20.0
	
	else:
		global_position.x = 380.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x += drift_speed * direction * delta
	
	if global_position.x > 420:
		global_position.x = -20
	elif global_position.x < -20:
		global_position.x = 420
	
	var player = get_tree().get_first_node_in_group("Player")
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
