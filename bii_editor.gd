extends Node3D

var data :  MiiData
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	data = $BiiCharacter.DNA


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_height(value : float):
	data.height = value

func change_top_radius(value : float):
	data.top_radius = value

func change_bot_radius(value : float):
	data.bottom_radius = value
	
func change_leg_length(value : float):
	data.leg_length = value
	
func change_hand_radius(value : float):
	data.hand_radius = value
	
func change_username(value : String):
	data.username = value
	
func get_path_str(name : String) -> String:
	return "user://mii." + name + ".tres"

func save():
	var err = ResourceSaver.save(data, get_path_str(data.username))
	if err != OK:
		printerr("Save failed: %s" % error_string(err))
	else:
		print("saved successfully")

# Need to create a dedicated panel to find which mii to load.
func load(name : String) -> bool:
	var path = get_path_str(name)
	if not ResourceLoader.exists(path):
		printerr("mii '" + name + "' could not be found at " + path + ".")
		return false
	var res := ResourceLoader.load(path, "", ResourceLoader.CACHE_MODE_IGNORE)
	
	if res is MiiData:
		$BiiCharacter.DNA = res # hope data is a pointer lol
		return true
	return false
