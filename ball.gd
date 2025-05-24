extends CharacterBody2D

@export var speed: float = 300.0
var direction: Vector2 = Vector2.ZERO
var start_position: Vector2

func _ready():
	start_position = global_position
	launch()

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
		direction = direction.bounce(normal).normalized()

func reset():
	global_position = start_position
	direction = Vector2.ZERO
	velocity = Vector2.ZERO

	await get_tree().create_timer(1.0).timeout  # short delay
	launch()


func _on_right_wall_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
