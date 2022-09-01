extends Control

var id
var node

func change_desc(new_id=null, new_node=null):
	if new_id in Project.items:
		id = new_id
		node = new_node
		$name.text = id
		$desc.text = Project.items[id].desc
	else:
		id = null
		$name.text = ""
		$desc.text = ""

func _on_name_text_entered(new_text):
	if id != null:
		node.get_node("Label").finish(new_text)

func _on_desc_text_changed():
	if id != null:
		Project.items[id].desc = $desc.text
	else:
		$desc.text = ""

func _on_delete_button_down():
	node._on_delete_button_down()
	change_desc()
