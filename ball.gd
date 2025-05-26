extends CharacterBody2D

@export var speed: float = 300.0
var direction: Vector2 = Vector2.ZERO
var start_position: Vector2

func _ready():
	start_position = global_position
	#launch()

func launch():
	randomize()
	var angle = randf_range(-PI / 4, PI / 4)
	direction = Vector2(1, tan(angle)).normalized()
	if randf() > 0.5:
		direction.x *= -1

func _physics_process(delta):
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta)

	if collision:
		var normal = collision.get_normal()
		var collider = collision.get_collider()

		# Check if we hit a paddle
		if collider.is_in_group("paddle"):
			var paddle_pos = collider.global_position
			var difference = global_position.y - paddle_pos.y
			var paddle_shape = collider.get_node("CollisionShape2D").shape

			if paddle_shape is RectangleShape2D:
				var paddle_height = paddle_shape.extents.y
				var offset = clamp(difference / paddle_height, -1.0, 1.0)

				# Apply exaggerated bounce based on offset
				var angle_strength = 0.5  # Tweak this for stronger angle
				var bounce_angle = offset * angle_strength

				# Reverse horizontal direction and apply vertical influence
				direction.x = -direction.x
				direction.y = bounce_angle
				direction = direction.normalized()
			else:
				# Just bounce if shape not Rectangle
				direction = direction.bounce(normal).normalized()
		else:
			# Default bounce
			direction = direction.bounce(normal).normalized()


func reset():
	global_position = start_position
	direction = Vector2.ZERO
	velocity = Vector2.ZERO

	await get_tree().create_timer(1.0).timeout  # short delay
	launch()


func _on_right_wall_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
	
func start_movement():
	#velocity = Vector2(200, randf_range(-100, 100)).normalized() * speed
	launch()
