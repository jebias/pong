extends CharacterBody2D

@export var speed: float = 300.0

func _physics_process(delta):
	var direction = 0

	if Input.is_action_pressed("ui_up"):
		direction -= 1
	if Input.is_action_pressed("ui_down"):
		direction += 1

	velocity = Vector2(0, direction * speed)
	move_and_slide()
