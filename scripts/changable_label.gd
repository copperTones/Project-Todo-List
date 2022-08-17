extends Label

signal finish(new_text)

onready var line = $"../LineEdit"

func _gui_input(event):
	if event is InputEventMouseButton and event.doubleclick:
		line.visible = true
		line.text = text
		line.grab_focus()
		line.caret_position = text.length()

func finish(new_text):
	line.visible = false
	text = new_text
	emit_signal("finish", new_text)

func _on_LineEdit_text_entered(new_text):
	finish(new_text)

func _on_LineEdit_focus_exited():
	finish(line.text)
