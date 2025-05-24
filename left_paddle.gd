extends CharacterBody2D

@export var speed: float = 250.0
@export var ball_path: NodePath  # Drag Ball node here
@export var separator_path: NodePath  # Drag Separator Sprite2D here

var ball: Node2D
var separator: Node2D

func _ready():
	ball = get_node(ball_path)
	separator = get_node(separator_path)

func _physics_process(delta):
	if not ball or not separator:
		return

	# Only move if ball is left of the separator
	if ball.global_position.x < separator.global_position.x:
		var direction = 0

		if ball.global_position.y > global_position.y + 5:
			direction = 1
		elif ball.global_position.y < global_position.y - 5:
			direction = -1

		velocity = Vector2(0, direction * speed)
		move_and_slide()
	else:
		# Stay still when ball is on the right
		velocity = Vector2.ZERO
		move_and_slide()
