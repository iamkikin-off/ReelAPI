extends Node

enum window_path {IN_WORLD}

const PREFIX = "[ReelAPI] "

var windows = {}

func _ready():
	register_window({
		"window_id": "example_window",
		"window_scene": preload("res://mods/Kikin.ReelAPI/Scenes/ExampleWindow.tscn"),
		"keybind": KEY_END,
		"mod_id": "ReelAPI",
		"silent_print": false,
		"animation_start": "start"
	})

func _input(event):
	if event is InputEventKey and event.pressed:
		for id in windows:
			if event.scancode == windows[id]["keybind"]:
				if windows[id]["opened"]:
					close_window(id, window_path.IN_WORLD)
				else:
					open_window(id, window_path.IN_WORLD)

func register_window(window_settings):
	var id = window_settings["window_id"]
	if not windows.has(id):
		windows[id] = {}
		windows[id]["window_scene"] = window_settings["window_scene"]
		windows[id]["keybind"] = window_settings["keybind"]
		windows[id]["mod_id"] = window_settings["mod_id"]
		windows[id]["animation_start"] = window_settings["animation_start"]
		windows[id]["opened"] = false
		windows[id]["opened_window"] = null
		if not window_settings["silent_print"]:
			print(PREFIX + str(window_settings["mod_id"]) + " has registered a window with the id of " + str(id))

func open_window(window_id, path):
	if not windows[window_id]["opened"]:
		if path == window_path.IN_WORLD and get_tree().current_scene.name == "world":
			var player_hud = get_node_or_null("/root/playerhud")
			var instance = windows[window_id]["window_scene"].instance()
			player_hud.add_child(instance)
			instance.get_node("AnimationPlayer").play(windows[window_id]["animation_start"])
			windows[window_id]["opened"] = true
			windows[window_id]["opened_window"] = instance

func close_window(window_id, path):
	if windows[window_id]["opened"]:
		if path == window_path.IN_WORLD and get_tree().current_scene.name == "world":
			var window = windows[window_id]["opened_window"]
			window.queue_free()
			windows[window_id]["opened"] = false
			windows[window_id]["opened_window"] = null
