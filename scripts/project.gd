extends Node

var proj_name = "test"
var project
var groups
var items

func _ready():
	load_proj()
	groups = project.groups
	items = project.items
	print(project)

func _exit_tree():
	save_proj()

func load_proj():
	var proj_file = File.new()
	proj_file.open("user://"+proj_name+".proj", File.READ)
	project = parse_json(proj_file.get_as_text())

func save_proj():
	var proj_file = File.new()
	proj_file.open("user://"+proj_name+".proj", File.WRITE)
	proj_file.store_string(JSON.print(project, "\t"))

func _input(event):
	if event is InputEventKey and event.scancode == KEY_K:
		print(project)
