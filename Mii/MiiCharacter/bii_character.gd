@tool
extends Node3D
class_name BiiCharacter

@export_category("Customization")
@export var DNA : MiiData :
	set(new_dna):
		print("New DNA")
		DNA = new_dna
		if DNA != null:
			if DNA.changed.is_connected(change_bii):
				DNA.changed.disconnect(change_bii)
			DNA.changed.connect(change_bii)
			change_bii()
			
@export var scaler : SkeletonScaler3D
@export var body   : MeshInstance3D
@export var head   : MeshInstance3D
@export var larm   : MeshInstance3D
@export var rarm   : MeshInstance3D

var body_mat     : StandardMaterial3D
var hand_mat     : StandardMaterial3D
var head_mat     : StandardMaterial3D

@export_category("Navigation")
@export var nav_debug : bool = false
@export var use_navigation : bool = true
@export var wander_around  : bool = true
@export var speed : float = 1
@export var current_dest : Vector3
var nav_region : NavigationRegion3D

@export_category("Standard Variables")
var model : Node3D

func _ready():
	if not DNA.changed.is_connected(change_bii):
		DNA.changed.connect(change_bii)
	scaler.data = DNA
	nav_region = $"../NavigationRegion3D"
	current_dest = Vector3.ZERO
	model = $Guy

func change_bii():
	print("Change bii")
	if scaler != null:
		scaler.data = DNA
	if body_mat == null:
		body_mat = StandardMaterial3D.new()
		hand_mat = StandardMaterial3D.new()
		head_mat = StandardMaterial3D.new()
	body_mat.albedo_color = DNA.favourite_color
	hand_mat.albedo_color = DNA.skin_color
	head_mat.albedo_texture = DNA.head_texture
	
	#body.material_override = body_mat
	#rarm.material_override = body_mat
	#larm.material_override = body_mat
	
# Needs the movement vector as step
func move_to(step: Vector3):
	model.look_at(global_position - step * 100) # *100 is because else lookat
												# points on top of player
	translate_object_local(step)
	
func find_new_dest() -> Vector3:
	"""
	Used for wandering, returns a random Vector3 in the known plane
	called nav_region
	"""
	return NavigationServer3D.region_get_random_point(nav_region.get_rid(), 1, true)

func wander(_delta : float):
	if (current_dest == Vector3.ZERO or 
	$NavigationAgent3D.is_target_reached() or 
	current_dest == global_position):
		
		current_dest = find_new_dest()
		$NavigationAgent3D.set_target_position(current_dest)
		if nav_debug : print("Updated Destination to", current_dest)
		
	var next_step = $NavigationAgent3D.get_next_path_position()
	var movement_vector = (next_step - global_position).normalized() * speed * _delta
	move_to(movement_vector)

func _process(_delta : float):
	$NavigationAgent3D.debug_enabled = nav_debug

func _physics_process(_delta: float) -> void:
	# Add a switch case if multiple behaviours
	if (use_navigation and wander_around):
		wander(_delta)
