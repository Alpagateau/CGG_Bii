@tool
extends SkeletonModifier3D
class_name SkeletonScaler3D

@export var data : MiiData

var b := {}

func _validate_bone_names() -> void:
	var skeleton = get_skeleton()
	if not skeleton:
		return
	b = {}
	
	#Root and hips :
	b["Root"] = skeleton.find_bone("Root")
	b["Hips"] = skeleton.find_bone("Hips")
	b["Spine"] = skeleton.find_bone("Spine")
	b["Gut"] = skeleton.find_bone("Chest")
	b["Chest"] = skeleton.find_bone("UpperChest")
	b["Neck"]  = skeleton.find_bone("Neck")
	b["Head"]  = skeleton.find_bone("Head")
	
	#Left Leg
	b["LeftUpperLeg"] = skeleton.find_bone("LeftUpperLeg")
	b["LeftLowerLeg"] = skeleton.find_bone("LeftLowerLeg")
	b["LeftFoot"] = skeleton.find_bone("LeftFoot")
	
	#Right Leg
	b["RightUpperLeg"] = skeleton.find_bone("RightUpperLeg")
	b["RightLowerLeg"] = skeleton.find_bone("RightLowerLeg")
	b["RightFoot"] = skeleton.find_bone("RightFoot")
	
	b["LeftShoulder"] = skeleton.find_bone("LeftShoulder")
	b["LeftUpperArm"] = skeleton.find_bone("LeftUpperArm")
	b["LeftLowerArm"] = skeleton.find_bone("LeftLowerArm")
	b["LeftHand"]     = skeleton.find_bone("LeftHand")

	b["RightShoulder"] = skeleton.find_bone("RightShoulder")
	b["RightUpperArm"] = skeleton.find_bone("RightUpperArm")
	b["RightLowerArm"] = skeleton.find_bone("RightLowerArm")
	b["RightHand"]     = skeleton.find_bone("RightHand")
	pass

func _process_modification_with_delta(_delta: float) -> void:
	var skeleton = get_skeleton()
	if skeleton == null or data == null:
		return
	
	set_leg_len(skeleton)
	pass

func set_leg_len(skeleton : Skeleton3D):
	if b == {}:
		_validate_bone_names()

	var hips   : int = b["Hips"]
	var spine   : int = b["Spine"]
	var l_up   : int = b["LeftUpperLeg"]
	var r_up   : int = b["RightUpperLeg"]
	var l_foot : int= b["LeftFoot"]
	
	if hips == -1 or l_up == -1 or l_foot == -1 or r_up == -1:
		return

	# Move the hips
	var current_hips_height = skeleton.get_bone_pose_position(hips).y
	var hips_up = Transform3D().translated(
		Vector3.UP * (data.leg_length - 1) * current_hips_height
	)
	transform_bone(skeleton, hips, hips_up)
	
	var leg_len_mult := Transform3D().scaled(
		Vector3(1, data.leg_length, 1)
	)

	transform_bone(skeleton, r_up, leg_len_mult)
	transform_bone(skeleton, l_up, leg_len_mult)
	
	var top := Transform3D().scaled(
		Vector3(data.top_radius, data.height, data.top_radius)
	)
	
	var mean =(data.top_radius + data.bottom_radius)/2
	var middle := Transform3D().scaled(
		Vector3(mean, data.height, mean)
	)
	
	var bttm := Transform3D().scaled(
		Vector3(data.bottom_radius, data.height, data.bottom_radius)
	)
	
	var arms_mul = (data.height + data.leg_length + data.bottom_radius) * 0.33
	var arms := Transform3D().scaled(
		 Vector3(1, arms_mul, 1)
	)
	
	transform_bone(skeleton, hips, bttm)
	transform_bone(skeleton, spine, bttm.affine_inverse())
	transform_bone(skeleton, r_up, bttm.affine_inverse())
	transform_bone(skeleton, l_up, bttm.affine_inverse())
	
	transform_bone(skeleton, b["Gut"], middle)
	transform_bone(skeleton, b["Chest"], middle.affine_inverse())
	
	transform_bone(skeleton, b["Chest"], top)
	transform_bone(skeleton, b["Neck"], top.affine_inverse())
	transform_bone(skeleton, b["LeftUpperArm"], top.affine_inverse())
	transform_bone(skeleton, b["RightUpperArm"], top.affine_inverse())
	
	transform_bone(skeleton, b["LeftUpperArm"], arms)
	transform_bone(skeleton, b["RightUpperArm"], arms)
	
	transform_bone(skeleton, b["LeftHand"], arms.affine_inverse())
	transform_bone(skeleton, b["RightHand"], arms.affine_inverse())
	

func transform_bone(skeleton : Skeleton3D, bone : int, m : Transform3D):
	if bone == -1:
		print("Bone error")
		return
	
	var og = skeleton.get_bone_pose(bone)
	og *= m
	skeleton.set_bone_pose(bone, og)
