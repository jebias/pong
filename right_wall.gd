extends Area2D

@export var hud_path: NodePath  # Drag the HUD node here in the editor

var hud: Node

func _ready():
	hud = get_node(hud_path)

func _on_body_entered(body):
	if body.has_method("reset"):
		body.reset()
		if hud and hud.has_method("add_point"):
			hud.add_point(false)  # Ball hit right wall, left player scores
