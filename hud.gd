extends CanvasLayer

var left_score: int = 0
var right_score: int = 0
const SCORE_LIMIT = 3
var game_started = false

@onready var score_label: Label = $score
@onready var win_popup = $game_over
@onready var win_label: Label = $game_over/winner_label
@onready var reset_button: Button = $game_over/reset_button
@onready var start_menu = $start_menu
@onready var start_button = $start_menu/start_button
@onready var ball = get_node("/root/Node2D/ball")
@onready var hud = get_node("/root/Node2D/hud")
@onready var paddles = [get_node("/root/Node2D/left_paddle"), get_node("/root/Node2D/right_paddle")]

func _ready():
	win_popup.visible = false
	start_button.pressed.connect(_on_start_button_pressed)
	_show_start_menu()
	update_score()
	
func _show_start_menu():
	print("Showing start menu")
	start_menu.visible = true
	#hud.visible = false
	ball.visible = false
	for paddle in paddles:
		paddle.visible = false

func _on_start_button_pressed():
	start_menu.visible = false
	hud.visible = true
	ball.visible = true
	for paddle in paddles:
		paddle.visible = true
	game_started = true
	ball.start_movement()
	
func add_point(to_right: bool):
	if to_right:
		right_score += 1
	else:
		left_score += 1
	update_score()
	if left_score >= SCORE_LIMIT or right_score >= SCORE_LIMIT:
		show_win_popup()
		
func update_score():
	score_label.text = "%d  %d" % [left_score, right_score]

func show_win_popup():
	if left_score > right_score:
		win_label.text = "Left Player Wins!"
	else:
		win_label.text = "Right Player Wins!"
		
	win_popup.visible = true
	get_tree().paused = true  # Pause the game

func _on_reset_button_pressed() -> void:
	left_score = 0
	right_score = 0
	update_score()
	win_popup.visible = false
	get_tree().paused = false
	
	# Reset the ball after unpausing
	var ball = get_tree().get_root().find_child("ball", true, false)
	if ball and ball.has_method("reset"):
		ball.reset()
