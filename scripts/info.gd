extends Control

var id

func change_desc(new_id):
	id = new_id
	$name.text = id
	$desc.text = Project.items[id].desc
