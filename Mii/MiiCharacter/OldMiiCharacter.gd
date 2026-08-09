@tool
extends Node3D
class_name MiiCharacter


@export var data : MiiData

@export_tool_button("mesh regen") var gen = generate_mii
@export var rings_per_hemisphere : int = 8
@export var radial_segments : int = 16

@export var skeleton : Skeleton3D
@export var mesh_instance : MeshInstance3D

@export var idle : Animation

func _ready() -> void:
	generate_mii()

func _process(_delta: float) -> void:
	pass

func generate_mii() -> void:
	var bones = collect_skeleton()
	skeleton.reset_scales()
	#skeleton.scale_from_data(data, bones)
	generate_body(bones)
	
	var skin : Skin = Skin.new()
	for i in skeleton.get_bone_count():
		var rest := skeleton.get_bone_global_rest(i)
		skin.add_bind(
			i,
			rest.affine_inverse()
		)
	mesh_instance.skin = skin

func collect_skeleton() -> Dictionary:
	var b = {}
	
	#Root and hips :
	b["Root"] = skeleton.find_bone("Root")
	b["Hips"] = skeleton.find_bone("Hips")
	b["Spine"] = skeleton.find_bone("Spine")
	b["Chest"] = skeleton.find_bone("UpperChest")
	b["Neck"]  = skeleton.find_bone("Neck")
	b["Head"]  = skeleton.find_bone("Head")
	
	#Left Leg
	b["LeftUpperLeg"] = skeleton.find_bone("LeftUpperLeg")
	b["LeftLowerLeg"] = skeleton.find_bone("LeftLowerLeg")
	
	#Right Leg
	b["RightUpperLeg"] = skeleton.find_bone("RightUpperLeg")
	b["RightLowerLeg"] = skeleton.find_bone("RightLowerLeg")
	
	b["LeftShoulder"] = skeleton.find_bone("LeftShoulder")
	b["LeftUpperArm"] = skeleton.find_bone("LeftUpperArm")
	b["LeftLowerArm"] = skeleton.find_bone("LeftLowerArm")
	b["LeftHand"]     = skeleton.find_bone("LeftHand")

	b["RightShoulder"] = skeleton.find_bone("RightShoulder")
	b["RightUpperArm"] = skeleton.find_bone("RightUpperArm")
	b["RightLowerArm"] = skeleton.find_bone("RightLowerArm")
	b["RightHand"]     = skeleton.find_bone("RightHand")
	return b

func add_bone(bname : String, parent : int, local_pos : Transform3D) -> int:
	var idx = skeleton.get_bone_count()
	skeleton.add_bone(bname)
	
	if parent >= 0:
		skeleton.set_bone_parent(idx, parent)
	
	skeleton.set_bone_rest(idx, local_pos)
	skeleton.set_bone_pose_position(idx, local_pos.origin)
	
	return idx

func generate_body(b : Dictionary) -> void:
	mesh_instance.mesh = ArrayMesh.new()
	
	#Torso
	generate_capsule(
		data.top_radius, data.bottom_radius, data.height,
		 3, 0, data.leg_lenght + data.bottom_radius + data.height/2, 
		[b["Neck"], b["Hips"]])
	
	#Legs
	generate_capsule(
		data.leg_distance/5, data.leg_distance/6, data.leg_lenght, 
		2, -data.leg_distance/2, data.leg_lenght/2, 
		[b["RightUpperLeg"], b["RightLowerLeg"]])
	generate_capsule(
		data.leg_distance/5, data.leg_distance/6, data.leg_lenght,
		 2, data.leg_distance/2, data.leg_lenght/2,
		[b["LeftUpperLeg"], b["LeftLowerLeg"]])
	
	#Debug Head
	var mean_radius = (data.bottom_radius + data.top_radius) / 2
	generate_capsule(
		mean_radius, mean_radius, 0,
		0, 0, data.leg_lenght + data.bottom_radius + data.height + data.top_radius + mean_radius * 1.4,
		[b["Head"], b["Head"]])
	
	#Hands
	generate_capsule(
		data.hand_radius, data.hand_radius, 0, 0, 
		(data.height + data.bottom_radius) * 1.5, data.leg_lenght + (data.height + data.bottom_radius),
		[b["LeftHand"], b["LeftHand"]])
		
	generate_capsule(
		data.hand_radius, data.hand_radius, 0, 0, 
		-(data.height + data.bottom_radius) * 1.5, data.leg_lenght + (data.height + data.bottom_radius),
		[b["RightHand"], b["RightHand"]])

func generate_capsule(
	top_radius : float, 
	bottom_radius : float,
	mid_height : float,
	mid_loops:  int,
	x_off : float,
	y_off : float,
	bones : Array[int]
	):
		
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	var half_len = mid_height / 2
	
	# Top hemisphere
	for ring  in range(rings_per_hemisphere + 1):
		var angle       = (float(ring) / rings_per_hemisphere) * PI * 0.5
		var y           = cos(angle) * top_radius + half_len
		var ring_radius = sin(angle) * top_radius
		
		generate_ring(
			st, x_off, y + y_off, ring_radius, 
			(float(ring) / rings_per_hemisphere) / 2, 
			[bones[0], 0, 0, 0], [1, 0, 0, 0]
			)
	
	# Middle cylinder
	for i in range(1, mid_loops + 1):
		var t = float(i) / (mid_loops + 1)
		var y = lerp(half_len, -half_len, t)
		
		var radius = lerp(top_radius, bottom_radius, t)
		var bottom = float(i - 1) / float(mid_loops - 1)
		
		generate_ring(
			st,
			x_off,
			y + y_off,
			radius,
			lerp(0.5, 0.5, t), 
			[bones[0], bones[1], 0, 0], [1 - bottom, bottom, 0, 0],
		)
	
	for ring in range(rings_per_hemisphere + 1):
		var angle = (PI / 2.0) + (float(ring) / rings_per_hemisphere) * (PI / 2.0)
		var y = cos(angle) * bottom_radius - half_len
		var ring_radius = sin(angle) * bottom_radius
		generate_ring(st, x_off, y + y_off, ring_radius, 0.5 + float(ring) / (rings_per_hemisphere * 2),
		[bones[1], 0, 0, 0], [1, 0, 0, 0]
		)
		
	var total_rings = (rings_per_hemisphere + 1) * 2 + mid_loops
	
	for ring in range(total_rings - 1):
		for seg in range(radial_segments):
			var current = ring * (radial_segments + 1) + seg
			var next = current + (radial_segments + 1)
			
			# Quad split into 2 Triangles
			st.add_index(current)
			st.add_index(next)
			st.add_index(current + 1)
			
			st.add_index(current + 1)
			st.add_index(next)
			st.add_index(next + 1)
	
	# Automatically smooth vertex normals & build smooth tangents
	st.generate_normals()
	st.generate_tangents()
	
	#mesh_instance.mesh = st.commit()
	st.commit(mesh_instance.mesh)

func generate_ring(st : SurfaceTool,x : float, y : float, ring_radius : float, v_uv : float, bones : PackedInt32Array, weights : PackedFloat32Array):
	for seg in range(radial_segments + 1):
		var theta = (float(seg) / radial_segments) * TAU
		var _x = cos(theta) * ring_radius + x
		var z = sin(theta) * ring_radius
		
		var u_uv = float(seg) / radial_segments
		st.set_bones(bones)
		st.set_weights(weights)
		st.set_uv(Vector2(u_uv, v_uv))
		st.add_vertex(Vector3(_x, y, z))
