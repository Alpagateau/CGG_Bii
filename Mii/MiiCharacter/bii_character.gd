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

@export_category("Navigation")
@export var use_navigation : bool = true
@export var wander_around  : bool = true
@export var speed : float = 1
@export var current_dest : Vector3 = Vector3.ZERO
var nav_region : NavigationRegion3D

var body_mat     : StandardMaterial3D
var hand_mat     : StandardMaterial3D
var head_mat     : StandardMaterial3D

func _ready():
	if not DNA.changed.is_connected(change_bii):
		DNA.changed.connect(change_bii)
	scaler.data = DNA
	nav_region = $"../NavigationRegion3D"

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
func move(step: Vector3):
	translate_object_local(step)
	
func find_new_dest() -> Vector3:
	return NavigationServer3D.region_get_random_point(nav_region.get_rid(), 1, false)

func wander(_delta : float):
	if (current_dest == Vector3.ZERO or $NavigationAgent3D.is_target_reached()):
		current_dest = find_new_dest()
		$NavigationAgent3D.target_position = current_dest
		print("Updated Destination to", current_dest)
		
	var next_step = $NavigationAgent3D.get_next_path_position()
	var movement_vector = (position - next_step).normalized() * speed * _delta
	move(movement_vector)
	
func _physics_process(_delta: float) -> void:
	if (use_navigation and wander_around):
		wander(_delta)
