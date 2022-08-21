extends "res://scripts/draggable.gd"

export var atlas_start = Vector2()
export var atlas_offset = Vector2(12, 0)
export var mode_count = 5

signal change_desc(id)

onready var hbox = $status/Node2D/HBoxContainer
var click_time
var id
var entry

func _ready():
	hbox.visible = false
	for i in range(mode_count):
		var trect = TextureRect.new()
		hbox.add_child(trect)
		trect.texture = $status.texture_normal.duplicate()
		trect.texture.region.position = atlas_start + atlas_offset*i

func _on_status_button_down():
	hbox.visible = true
	hbox.rect_position.x = -16*Project.items[id].mode
	hbox.rect_position.x -= max(hbox.get_global_rect().end.x - OS.window_size.x + 6, 0)
	click_time = OS.get_unix_time()

func _on_status_button_up():
	var entry = Project.items[id]
	hbox.visible = false
	var off = entry.mode - 1
	if OS.get_unix_time() - click_time > .2:
		off = (hbox.get_local_mouse_position().x + 2)/16
	entry.mode = clamp(floor(off), 0, mode_count-1)
	$status.texture_normal = hbox.get_child(entry.mode).texture

func _on_Label_finish(new_text):
	if not Project.items.has(new_text):
		var index = entry.find(id)
		if index == -1:
			print("Could not find ",id)
		entry[index] = new_text
		
		var ientry = Project.items[id]
		Project.items.erase(id)
		id = new_text
		Project.items[new_text] = ientry
	else:
		get_node("Label").text = id

func _on_item_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("change_desc", id, self)
