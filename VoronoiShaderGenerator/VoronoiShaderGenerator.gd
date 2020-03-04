extends Node2D

signal generated

export (Vector2) var image_size = Vector2(512,512)
export (float) var multiplier = 1.0
export (int) var _seed = 0
export(int, "Type1", "Type2") var type = 0
var ___material_list = [
	preload("res://VoronoiShaderGenerator/VoronoiShaderGenerator_Type1.material"),
	preload("res://VoronoiShaderGenerator/VoronoiShaderGenerator_Type2.material")
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
	___shader_container.set_material(___material_list[type])
	
	# Set shaders param
	___shader_container.get_material().set_shader_param("resolution", image_size*multiplier)
	___shader_container.get_material().set_shader_param("seed", _seed/4294967295.0)
	
	## Actually Generate Image
	___drawer.show()
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	___generated_image = ___drawer.get_texture().get_data().duplicate()
	emit_signal("generated")
	___drawer.hide()
