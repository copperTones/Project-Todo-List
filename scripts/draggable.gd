extends Control

var dragging = false
signal dropped(node, at)

func _ready():
	connect("gui_input", self, "gui_input")

func gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and not dragging:
			dragging = true
			get_parent().z_index = 1
		elif not event.pressed and dragging:
			dragging = false
			get_parent().z_index = 0
			get_parent().position = Vector2()
			emit_signal("dropped", self, event.global_position)
	elif event is InputEventMouseMotion and dragging:
		get_parent().position += event.relative
