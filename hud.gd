extends CanvasLayer

var left_score: int = 0
var right_score: int = 0
const SCORE_LIMIT = 3

@onready var score_label: Label = $score
@onready var win_popup = $game_over
@onready var win_label: Label = $game_over/winner_label
@onready var reset_button: Button = $game_over/reset_button

func _ready():
	win_popup.visible = false
	#reset_button.pressed.connect(_on_reset_button_pressed)
	update_score()
	
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
	var ball = get_tree().get_root().find_child("Ball", true, false)
	if ball and ball.has_method("reset"):
		ball.reset()
