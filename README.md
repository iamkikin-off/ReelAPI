A Misc API for WEBFISHING.

Right now, ReelAPI only allows for registering UIs, so making custom UIs is easier.
This API will have more stuff later on.

How to install
----------------------
1. Install the repository, and put Kikin.ReelAPI into your mods folder in Godot.
2. Autoload it - Select Kikin.ReelAPI/main.gd and set the name as "KikinReelAPI"
3. done :3

UI
----------------------
For registering custom UIs, you need to firstly get ReelAPI in your script.

```gdscript
var ReelAPI

func _ready():
  ReelAPI = get_node_or_null("/root/KikinReelAPI")
```

Now lets actually register the UI.

```gdscript
var ReelAPI

func _ready():
	ReelAPI = get_node_or_null("/root/KikinReelAPI")
	
	ReelAPI.register_window({
		"window_id": "example_window", # Every UI needs to have an ID to represent itself.
		"window_scene": preload("res://mods/Kikin.ReelAPI/Scenes/ExampleWindow.tscn"), # The scene of the UI.
		"keybind": KEY_END, # The keybind that will be used to open the UI.
		"mod_id": "ReelAPI", # This is just for debugging purposes, but i recommend settings this to your Mod ID
		"silent_print": false, # If you don't want ReelAPI to yap about some debug stuff, set this to True.
		"animation_start": "start" # In your UI you --> need <-- to have an AnimationPlayer. Set this to the animation name you want to play at start, if you don't want to play anything then create an empty animation.
	})

```
