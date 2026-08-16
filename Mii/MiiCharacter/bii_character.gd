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
@export var lhand : MeshInstance3D
@export var rhand : MeshInstance3D

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
@export var anim_tree : AnimationTree
var model : Node3D
@export var rotation_speed : float = 2

func _ready():
	if not DNA.changed.is_connected(change_bii):
		DNA.changed.connect(change_bii)
	scaler.data = DNA
	var failed_nav = false
	if use_navigation: 
		nav_region = $"../NavigationRegion3D"
		if nav_region == null:
			failed_nav = true
	current_dest = Vector3.ZERO
	model = $Guy
	anim_tree = $AnimationTree
	
	if failed_nav:
		print("navigation was disabled due to missing NavigationRegion3D at \
		BiiCharacter level.")
		use_navigation = false
	
	body.material_override = body_mat
	rarm.material_override = body_mat
	larm.material_override = body_mat
	rhand.material_override = hand_mat
	lhand.material_override = hand_mat
	
	head.material_override = head_mat

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
	
	
# Needs the movement vector as step
func move_to(step: Vector3):
	anim_tree.set("parameters/blend_position", Vector2(0, step.length()*50))
	translate_object_local(step)

func smooth_look_at(direction : Vector3, _delta: float):
	# Si tu comprends pas revoie tes cours de trigo lol
	model.rotation.y = lerp_angle(model.rotation.y, 
	atan2(-direction.x, -direction.z) + PI, _delta * rotation_speed) 

	
func find_new_dest() -> Vector3:
	"""
	Used for wandering.
	Returns a random Vector3 in the known plane
	called nav_region
	Returns null if no region is found
	"""
	
	if (nav_region != null) : 
		return NavigationServer3D.region_get_random_point(nav_region.get_rid(), 
		1, true)
	return Vector3.ZERO

func wander(_delta : float):
	if (current_dest == Vector3.ZERO or 
	$NavigationAgent3D.is_target_reached() or 
	current_dest == global_position):
		
		current_dest = find_new_dest()
		# Failure case
		if current_dest == Vector3.ZERO :
			move_to(Vector3.ZERO)
			return
		$NavigationAgent3D.set_target_position(current_dest)
		if nav_debug : print("Updated Destination to", current_dest)
		
	var next_step = $NavigationAgent3D.get_next_path_position()
	var movement_vector = (next_step - global_position).normalized() * speed * _delta
	
	move_to(movement_vector)
	smooth_look_at(movement_vector, _delta)

func _process(_delta : float):
	$NavigationAgent3D.debug_enabled = nav_debug

func _physics_process(_delta: float) -> void:
	# Add a switch case if multiple behaviours
	if (use_navigation and wander_around):
		wander(_delta)
	else:
		move_to(Vector3.ZERO)
