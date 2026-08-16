extends Node3D

var data :  MiiData

@export var height_slider : Slider
@export var top_slider : Slider
@export var bot_slider : Slider
@export var leg_slider : Slider
@export var hand_slider : Slider
@export var name_input : LineEdit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init()

func init():
	data = $BiiCharacter.DNA
	
	height_slider.value = data.height
	top_slider.value = data.top_radius
	bot_slider.value = data.bottom_radius
	leg_slider.value = data.leg_length
	hand_slider.value = data.hand_radius
	name_input.text = data.username

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
	var path = get_path_str(data.username)
	var err = ResourceSaver.save(data, path)
	if err != OK:
		printerr("Save failed: %s" % error_string(err))
	else:
		print("saved successfully at " + path)

# Need to create a dedicated panel to find which mii to load.
func load() -> bool:
	var name = data.username
	var path = get_path_str(name)
	if not ResourceLoader.exists(path):
		printerr("mii '" + name + "' could not be found at " + path + ".")
		return false
	var res := ResourceLoader.load(path, "", ResourceLoader.CACHE_MODE_IGNORE)
	
	if res is MiiData:
		$BiiCharacter.DNA = res
		init()
		return true
	return false
