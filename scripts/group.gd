extends "res://scripts/draggable.gd"

onready var INST = preload("res://scenes/item.tscn")
var NEWGROUP_MARGIN = 24

var id

func _on_Control_resized():
	rect_size.y = $"../..".rect_size.y

# search stuff
func _on_LineEdit_text_entered(new_text):
	if new_item(new_text):
		clear()

func _on_LineEdit_text_changed(new_text):
	for child in $items.get_children():
		child.visible = new_text == "" or new_text in child.name

func _on_clear_button_down():
	clear()

func _on_add_button_down():
	if new_item($LineEdit.text):
		clear()

func new_item(name, exists=false):
	if Project.items.has(name) != exists:
		return
	var entry = {"mode": 3}
	if exists:
		entry = Project.items[name]
	else:
		Project.items[name] = entry
		Project.groups[id].items.append(name)
	
	var item = INST.instance()
	$items.add_child(item)
	item.name = name
	item = item.get_node("Node2D/item")
	item.get_node("Label").text = name
	item.id = name
	item.entry = Project.groups[id].items
	
	var status_btn = item.get_node("status")
	var tex = status_btn.get_node("Node2D/HBoxContainer").get_child(entry.mode).texture
	status_btn.texture_normal = tex
	
	item.connect("dropped", self, "item_dropped")
	return item

func clear():
	$search/LineEdit.text = ""
	for child in $items.get_children():
		child.visible = true

# node dragging
func item_dropped(node, at):
	node = node.get_node("../..")
	var rect = $items.get_global_rect()
	if rect.position.x + NEWGROUP_MARGIN < at.x and at.x < rect.end.x - NEWGROUP_MARGIN:
		var index = floor(clamp((at - rect.position).y/24, 0, $items.get_child_count()-1))
		var list = Project.groups[id].items
		list.insert(index, list.pop_at(node.get_index()))
		$items.move_child(node, index)
	else:
		print("pass to higher level")
