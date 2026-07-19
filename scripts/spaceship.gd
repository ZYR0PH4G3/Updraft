extends CharacterBody2D

const GRAVITY = 400.0
const BOOST_VELOCITY = -450.0

func _physics_process(delta: float) -> void:
	
	velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = BOOST_VELOCITY
	
	move_and_slide()
