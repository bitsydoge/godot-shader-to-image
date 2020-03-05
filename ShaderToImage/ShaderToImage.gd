extends Node2D

signal generated

export (Vector2) var resolution = Vector2(512,512)
export (float) var multiplier = 1.0

export(int) var type = 0
var ___type_list = []

#########################
# Internal
# Onready
onready var ___drawer = $Renderer
onready var ___shader_container = $Viewport/Shader
onready var ___viewport = $Viewport

# ###
var ___generated_image

func set_type(id : int) -> void:
	type = id

func get_type_list() -> Array:
	return ___type_list;

func get_image() -> Image:
	if ___generated_image != null:
		return ___generated_image
	else:
		printerr("No image generated, use generate_image() and wait for \"generated\" signal")
		return null

func add_custom_type(name : String, material : Material) -> int:
	___type_list.push_back({
		"name" : name,
		"material" : material,
	})
	return ___type_list.size()-1

func generate_image(args : Dictionary = {}):
	# Resize generating nodes
	___viewport.size = resolution
	___viewport.render_target_update_mode = Viewport.UPDATE_ALWAYS
	___shader_container.rect_size = resolution
	
	# Set material type
	___shader_container.set_material(___type_list[type].material)
	
	#TODO use args array
	# Set shaders param
	___shader_container.get_material().set_shader_param("resolution", resolution*multiplier)
	
	for arg in args:
		___shader_container.get_material().set_shader_param(arg, args[arg])
	
	## Actually Generate Image
	___drawer.show()
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	___generated_image = ___drawer.get_texture().get_data().duplicate()
	emit_signal("generated")
	___viewport.render_target_update_mode = Viewport.UPDATE_DISABLED
	___drawer.hide()
