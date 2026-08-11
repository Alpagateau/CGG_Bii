[1mdiff --git a/BiiEditor.tscn b/BiiEditor.tscn[m
[1mindex ed8d6f7..5808331 100644[m
[1m--- a/BiiEditor.tscn[m
[1m+++ b/BiiEditor.tscn[m
[36m@@ -23,7 +23,7 @@[m [mssil_enabled = true[m
 transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 2)[m
 [m
 [node name="BiiCharacter" parent="." unique_id=448801977 instance=ExtResource("1_1w476")][m
[31m-transform = Transform3D(0.8660254, 0, 0.5, 0, 1, 0, -0.5, 0, 0.8660254, 0, 0, 0)[m
[32m+[m[32mtransform = Transform3D(0.9659257, 0.25866574, -0.008921881, 0, 0.034471434, 0.9994057, 0.25881955, -0.96535164, 0.033296842, -0.0002974054, 0.033313524, 0.0011099298)[m
 DNA = SubResource("Resource_qrlva")[m
 [m
 [node name="WorldEnvironment" type="WorldEnvironment" parent="." unique_id=1093388147][m
[1mdiff --git a/Mii/MiiCharacter/BiiCharacter.tscn b/Mii/MiiCharacter/BiiCharacter.tscn[m
[1mindex 5ebfd78..d92558d 100644[m
[1m--- a/Mii/MiiCharacter/BiiCharacter.tscn[m
[1m+++ b/Mii/MiiCharacter/BiiCharacter.tscn[m
[36m@@ -41,39 +41,39 @@[m [mlarm = NodePath("Guy/metarig_004/GeneralSkeleton/LeftArm")[m
 rarm = NodePath("Guy/metarig_004/GeneralSkeleton/RightArm")[m
 [m
 [node name="Guy" parent="." unique_id=1379844246 instance=ExtResource("1_oulqm")][m
[31m-transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0.0006156564, 0, -0.0038118362)[m
[32m+[m[32mtransform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0.001, -0.5, -0.004)[m
 [m
 [node name="Empty" parent="Guy" index="0" unique_id=895133763][m
 transform = Transform3D(2.0928214, 0, 0, 0, 0, -2.0928214, 0, 2.0928214, 0, 0.025786579, 1.3131268, -1)[m
 [m
 [node name="metarig_004" parent="Guy" index="1" unique_id=286958416][m
[31m-transform = Transform3D(0.9999998, -2.8179224e-05, 7.995008e-05, 2.8178605e-05, 0.99999994, 7.695747e-06, -7.995029e-05, -7.693494e-06, 0.99999994, -1.4358964e-05, -8.643215e-06, -1.3665553e-05)[m
[32m+[m[32mtransform = Transform3D(0.9999998, -2.4622854e-05, 7.551479e-05, 2.4622506e-05, 0.99999994, 4.569288e-06, -7.5514894e-05, -4.5674287e-06, 0.99999994, -1.579275e-05, -9.03739e-06, -1.5266696e-05)[m
 [m
 [node name="GeneralSkeleton" parent="Guy/metarig_004" index="0" unique_id=10120217][m
[31m-bones/1/rotation = Quaternion(-0.012097486, -1.2948428e-06, -2.157314e-06, 0.9999268)[m
[31m-bones/2/rotation = Quaternion(-0.014329709, -1.7076778e-07, -1.2837058e-06, 0.99989736)[m
[31m-bones/3/rotation = Quaternion(-0.017341191, -4.882621e-08, -1.3101427e-06, 0.9998496)[m
[31m-bones/4/rotation = Quaternion(-1.08897775e-05, -1.6030457e-07, -2.3044486e-06, 1)[m
[31m-bones/5/rotation = Quaternion(-1.0850476e-05, -1.6031231e-07, -2.3044536e-06, 1)[m
[31m-bones/6/rotation = Quaternion(-0.022451235, 3.2093403e-08, -2.3057e-06, 0.99974793)[m
[31m-bones/8/rotation = Quaternion(0.50004035, 0.49992415, 0.5000394, -0.4999961)[m
[31m-bones/9/rotation = Quaternion(0.00011780604, 0.9695941, -0.24471901, 0.00010111294)[m
[31m-bones/10/rotation = Quaternion(-0.026932068, -0.70585364, 0.029756395, 0.70721984)[m
[31m-bones/11/rotation = Quaternion(1.6911303e-05, 0.70709574, -5.236535e-06, 0.7071178)[m
[31m-bones/13/rotation = Quaternion(0.5000487, -0.49992883, -0.5000363, -0.49998635)[m
[31m-bones/14/rotation = Quaternion(0.0011214205, 0.948993, -0.31529486, -0.00046815496)[m
[31m-bones/15/rotation = Quaternion(-0.008832361, 0.7068041, -0.009810406, 0.7072862)[m
[31m-bones/16/rotation = Quaternion(8.490854e-05, -0.70704514, -7.438058e-05, 0.7071684)[m
[32m+[m[32mbones/1/rotation = Quaternion(-0.0022894095, -1.983565e-06, 9.476932e-07, 0.9999974)[m
[32m+[m[32mbones/2/rotation = Quaternion(-0.0023907947, -4.661981e-07, -1.676114e-07, 0.99999714)[m
[32m+[m[32mbones/3/rotation = Quaternion(-0.00087512715, -3.927392e-07, -1.9531907e-07, 0.99999964)[m
[32m+[m[32mbones/4/rotation = Quaternion(-1.0929567e-05, -1.8476152e-07, -2.19519e-06, 1)[m
[32m+[m[32mbones/5/rotation = Quaternion(-1.0890276e-05, -1.8477066e-07, -2.195204e-06, 1)[m
[32m+[m[32mbones/6/rotation = Quaternion(-0.004192802, 4.4396273e-08, -2.2011723e-06, 0.99999124)[m
[32m+[m[32mbones/8/rotation = Quaternion(0.50003964, 0.4999251, 0.5000394, -0.49999604)[m
[32m+[m[32mbones/9/rotation = Quaternion(-4.0818082e-05, 0.95621705, -0.29265854, -7.202174e-05)[m
[32m+[m[32mbones/10/rotation = Quaternion(-0.0010664954, -0.70711184, 0.0014179891, 0.70709956)[m
[32m+[m[32mbones/11/rotation = Quaternion(1.6258926e-05, 0.70709467, -7.691257e-06, 0.707119)[m
[32m+[m[32mbones/13/rotation = Quaternion(0.50005066, -0.49992657, -0.5000372, -0.49998575)[m
[32m+[m[32mbones/14/rotation = Quaternion(0.000268653, 0.93725497, -0.34864452, -0.00015788733)[m
[32m+[m[32mbones/15/rotation = Quaternion(-0.012602141, 0.7065838, -0.013947573, 0.7073797)[m
[32m+[m[32mbones/16/rotation = Quaternion(8.427607e-05, -0.707045, -7.495679e-05, 0.70716864)[m
 bones/18/rotation = Quaternion(-1.5631919e-07, 0.7071068, 0.7071068, -1.6371385e-07)[m
 bones/20/rotation = Quaternion(-1.5631919e-07, 0.7071068, 0.7071068, -1.6371385e-07)[m
[31m-bones/26/rotation = Quaternion(6.2372404e-05, 2.107956e-05, 1, -4.675305e-05)[m
[31m-bones/27/rotation = Quaternion(-1.8045072e-05, 1, -0.00013870437, 7.0025345e-07)[m
[31m-bones/28/rotation = Quaternion(-5.162971e-05, 0.7070411, -0.70717245, 5.960106e-05)[m
[31m-bones/29/rotation = Quaternion(3.3216243e-09, 1, 3.4385184e-07, -5.522591e-09)[m
[31m-bones/33/rotation = Quaternion(-7.5868316e-05, -5.156699e-06, 1, 5.383332e-05)[m
[31m-bones/34/rotation = Quaternion(2.5023419e-05, 1, -0.00018493539, -5.143822e-05)[m
[31m-bones/35/rotation = Quaternion(5.750647e-05, 0.7070013, -0.7072122, -6.692402e-05)[m
[31m-bones/36/rotation = Quaternion(1.6426322e-08, 1, 9.407476e-06, 1.317741e-06)[m
[32m+[m[32mbones/26/rotation = Quaternion(6.029136e-05, 2.2361188e-05, 1, -4.67881e-05)[m
[32m+[m[32mbones/27/rotation = Quaternion(-2.1544429e-05, 1, -0.00014027616, 5.314288e-06)[m
[32m+[m[32mbones/28/rotation = Quaternion(-4.889907e-05, 0.7070335, -0.70718, 5.67116e-05)[m
[32m+[m[32mbones/29/rotation = Quaternion(3.3395304e-09, 1, 3.368488e-07, -5.5320024e-09)[m
[32m+[m[32mbones/33/rotation = Quaternion(-7.4689895e-05, -1.7454971e-06, 1, 5.186883e-05)[m
[32m+[m[32mbones/34/rotation = Quaternion(2.4392442e-05, 1, -0.00018429742, -5.0706887e-05)[m
[32m+[m[32mbones/35/rotation = Quaternion(5.6236575e-05, 0.70700294, -0.7072106, -6.535574e-05)[m
[32m+[m[32mbones/36/rotation = Quaternion(5.2718416e-09, 1, 1.1662373e-05, 1.4876697e-07)[m
 bones/38/rotation = Quaternion(-2.6041172e-07, -2.8749844e-07, -0.7071068, 0.7071068)[m
 [m
 [node name="SkeletonScaler3D" type="SkeletonModifier3D" parent="Guy/metarig_004/GeneralSkeleton" index="6" unique_id=1863961602][m
[1mdiff --git a/Mii/MiiCharacter/bii_character.gd b/Mii/MiiCharacter/bii_character.gd[m
[1mindex 2a3958f..0aeb17f 100644[m
[1m--- a/Mii/MiiCharacter/bii_character.gd[m
[1m+++ b/Mii/MiiCharacter/bii_character.gd[m
[36m@@ -55,25 +55,33 @@[m [mfunc change_bii():[m
 	#larm.material_override = body_mat[m
 	[m
 # Needs the movement vector as step[m
[31m-func move(step: Vector3):[m
[32m+[m[32mfunc move_to(step: Vector3):[m
[32m+[m	[32m#look_at(step)[m[41m [m
 	translate_object_local(step)[m
 	[m
 func find_new_dest() -> Vector3:[m
[31m-	return NavigationServer3D.region_get_random_point(nav_region.get_rid(), 1, false)[m
[32m+[m	[32m"""[m
[32m+[m	[32mUsed for wandering, returns a random Vector3 in the known plane[m
[32m+[m	[32m"""[m
[32m+[m	[32mreturn NavigationServer3D.region_get_random_point(nav_region.get_rid(), 1, true)[m
 [m
 func wander(_delta : float):[m
[31m-	if (current_dest == Vector3.ZERO or $NavigationAgent3D.is_target_reached() or current_dest == global_position):[m
[32m+[m	[32mif (current_dest == Vector3.ZERO or[m[41m [m
[32m+[m	[32m$NavigationAgent3D.is_target_reached() or[m[41m [m
[32m+[m	[32mcurrent_dest == global_position):[m
[32m+[m[41m		[m
 		current_dest = find_new_dest()[m
 		$NavigationAgent3D.set_target_position(current_dest)[m
 		if nav_debug : print("Updated Destination to", current_dest)[m
 		[m
 	var next_step = $NavigationAgent3D.get_next_path_position()[m
 	var movement_vector = (next_step - global_position).normalized() * speed * _delta[m
[31m-	move(movement_vector)[m
[32m+[m	[32mmove_to(movement_vector)[m
 [m
 func _process(_delta : float):[m
 	$NavigationAgent3D.debug_enabled = nav_debug[m
 [m
 func _physics_process(_delta: float) -> void:[m
[32m+[m	[32m# Add a switch case if multiple behaviours[m
 	if (use_navigation and wander_around):[m
 		wander(_delta)[m
[1mdiff --git a/TestScene.tscn b/TestScene.tscn[m
[1mindex 0f59bc5..c399b1a 100644[m
[1m--- a/TestScene.tscn[m
[1m+++ b/TestScene.tscn[m
[36m@@ -107,19 +107,16 @@[m [mshadow_enabled = true[m
 omni_range = 6.619759[m
 [m
 [node name="Guy" parent="." unique_id=448801977 instance=ExtResource("1_mncer")][m
[31m-transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 1.6238972, 1.024282, -3.555721)[m
[32m+[m[32mtransform = Transform3D(0.99998134, 0, 0, 0, 0.999981, 0, 0, 0, 0.9999792, 5.722412, 0.29937056, -2.9696531)[m
 DNA = SubResource("Resource_cguwc")[m
[31m-nav_debug = null[m
[31m-current_dest = Vector3(1.0078017, 1.0981394, -5.781435)[m
[32m+[m[32mcurrent_dest = Vector3(0.114724636, 0.93541926, 2.7535238)[m
 [m
 [node name="BiiCharacter" parent="." unique_id=1343267674 instance=ExtResource("1_mncer")][m
[31m-transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 4.521197, 0.43315023, -2.5561016)[m
[32m+[m[32mtransform = Transform3D(0.9999807, 0, 0, 0, 0.9999987, 0, 0, 0, 0.9999857, 9.4929695, 0.68385756, -9.179052)[m
 DNA = SubResource("Resource_1fkdn")[m
[31m-nav_debug = null[m
[31m-current_dest = Vector3(2.4655027, 1.0432441, -2.2914693)[m
[32m+[m[32mcurrent_dest = Vector3(3.398011, 0.45945525, -1.5738221)[m
 [m
 [node name="BiiCharacter2" parent="." unique_id=1445243662 instance=ExtResource("1_mncer")][m
[31m-transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0.115386546, 0.9473239, 1.9310594)[m
[32m+[m[32mtransform = Transform3D(0.9999819, 0, 0, 0, 0.9999916, 0, 0, 0, 0.9999848, 1.8072642, 0.94684553, -1.1924088)[m
 DNA = SubResource("Resource_sreuk")[m
[31m-nav_debug = null[m
[31m-current_dest = Vector3(3.5543652, 0.3481394, -0.6152014)[m
[32m+[m[32mcurrent_dest = Vector3(5.355091, 0.3481394, -4.468443)[m
