extends Resource
class_name MiiData

@export_category("Characterisation")
@export var username        : String
@export var favourite_color : Color

@export_category("General")
@export var skin_color : Color

@export_category("Body")
@export_range(0.5, 1.5) var height        : float = 1
@export_range(0.5, 2) var top_radius      : float = 1
@export_range(0.5, 2) var bottom_radius   : float = 1

@export_category("Legs")
@export_range(0.5, 1.3) var leg_length : float = 1

@export_category("Hands")
@export_range(0.05, 0.15) var hand_radius : float

@export_category("Head")
@export var head_transform : Transform3D
@export var head_texture   : Texture2D
