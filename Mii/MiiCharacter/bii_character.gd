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

var body_mat     : StandardMaterial3D
var hand_mat     : StandardMaterial3D
var head_mat     : StandardMaterial3D

func _ready():
	if not DNA.changed.is_connected(change_bii):
		DNA.changed.connect(change_bii)
	scaler.data = DNA

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
