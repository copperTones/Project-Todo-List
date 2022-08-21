extends Control

var id

func change_desc(new_id):
	if new_id in Project.items:
		id = new_id
		$name.text = id
		$desc.text = Project.items[id].desc
	else:
		id = null
		$name.text = ""
		$desc.text = ""

func _on_name_text_entered(new_text):
	pass # name change function

func _on_desc_text_changed():
	if id != null:
		Project.items[id].desc = $desc.text
	else:
		$desc.text = ""
