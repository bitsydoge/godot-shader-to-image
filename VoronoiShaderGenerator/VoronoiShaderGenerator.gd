extends Node2D

signal generated

export (Vector2) var image_size = Vector2(512,512)

export (float) var multiplier = 1.0
export (float) var time = 0
export (float) var mod1 = 1.0
export (float) var mod2 = 0.0

export(int) var type = 0
var ___type_list = [
	{
		"name" : "Type1",
		"material" : preload("Materials/VoronoiShaderGenerator_Type1.material"),
		"args" : ["time"]
	},
	{
		"name" : "Type2",
		"material" : preload("Materials/VoronoiShaderGenerator_Type2.material"),
		"args" : ["time", "mod1"]
	},
	{
		"name" : "Type3",
		"material" : preload("Materials/VoronoiShaderGenerator_Type3.material"),
		"args" : ["time"]
	},
	{
		"name" : "Type4",
		"material" : preload("Materials/VoronoiShaderGenerator_Type5.material"),
		"args" : ["time", "mod1"]
	},
	{
		"name" : "Type5",
		"material" : preload("Materials/VoronoiShaderGenerator_Type5.material"),
		"args" : ["time", "mod1"]
	},
	{
		"name" : "Type6",
		"material" : preload("Materials/VoronoiShaderGenerator_Type6.material"),
		"args" : ["time"]
	},
	{
		"name" : "Type7",
		"material" : preload("Materials/VoronoiShaderGenerator_Type7.material"),
		"args" : ["mod1", "mod2"]
	},
	{
		"name" : "Type8",
		"material" : preload("Materials/VoronoiShaderGenerator_Type8.material"),
		"args" : ["time"]
	},
	{
		"name" : "Type9",
		"material" : preload("Materials/VoronoiShaderGenerator_Type9.material"),
		"args" : ["time", "mod1"]
	},
]

#########################
# Internal
# Onready
onready var ___drawer = $Renderer
onready var ___shader_container = $Viewport/Shader
onready var ___viewport = $Viewport

# ###
var ___generated_image

func get_image():
	if ___generated_image != null:
		return ___generated_image
	else:
		printerr("No image generated")
		return null

func ___generate_image():
	# Resize generating nodes
	___viewport.size = image_size
	___shader_container.rect_size = image_size
	
	# Set material type
	___shader_container.set_material(___type_list[type].material)
	
	# Set shaders param
	___shader_container.get_material().set_shader_param("resolution", image_size*multiplier)
	___shader_container.get_material().set_shader_param("mod1", mod1)
	___shader_container.get_material().set_shader_param("mod2", mod2)
	___shader_container.get_material().set_shader_param("time", time)
	
	## Actually Generate Image
	___drawer.show()
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	___generated_image = ___drawer.get_texture().get_data().duplicate()
	emit_signal("generated")
	___drawer.hide()
