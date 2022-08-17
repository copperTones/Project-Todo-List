extends Control

onready var INST = preload("res://scenes/group.tscn")

func _ready():
	$title.text = Project.proj_name
	for gid in range(Project.groups.size()):
		var gnode = add_group(gid)
		for item in Project.groups[gid].items:
			gnode.new_item(item, true)

func add_group(id):
	var group = INST.instance()
	$VSplitContainer/ScrollContainer/container.add_child(group)
	group = group.get_node("Node2D/group")
	group.id = id
	group.get_node("title").text = Project.groups[id].name
	return group
