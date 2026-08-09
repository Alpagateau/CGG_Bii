@tool
extends Skeleton3D
class_name ScalableSkeleton3D

var default_rest := {}

func scale_from_data(data : MiiData, b : Dictionary):
	#legs
	print("Leg len : ", data.leg_lenght)
	scale_bone_length(b["LeftUpperLeg"], data.leg_lenght)
	scale_bone_length(b["LeftLowerLeg"], data.leg_lenght)
	
	scale_bone_length(b["RightUpperLeg"], data.leg_lenght)
	scale_bone_length(b["RightLowerLeg"], data.leg_lenght)
	pass

func scale_bone_length(bone: int, factor: float):
	var rest : Transform3D = get_bone_rest(bone)
	
	if not default_rest.has(bone):
		default_rest[bone] = rest
	
	rest.basis = rest.basis.scaled(Vector3(factor, factor, factor))
	set_bone_rest(bone, rest)
	
func reset_scales():
	for k in default_rest.keys():
		set_bone_rest(k, default_rest[k])
