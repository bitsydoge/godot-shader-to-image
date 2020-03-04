extends Node2D

onready var drawer = $Renderer
onready var shader_container = $Viewport/Shader
onready var viewport = $Viewport

var generated_image

export (float) var multiplier = 1.0
export (Vector2) var image_size = Vector2(1024,1024)

func _ready():
	___generate_image()
	
func get_image():
	return generated_image

func ___generate_image():
	viewport.size = image_size
	shader_container.rect_size = image_size
	shader_container.get_material().set_shader_param("resolution", image_size*multiplier)
	drawer.show()
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	generated_image = drawer.get_texture().get_data().duplicate()
	generated_image.save_png("user://test.png")
	drawer.hide()
