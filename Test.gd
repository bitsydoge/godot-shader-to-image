extends Control

onready var result = $Result
onready var generator = $VoronoiShaderGenerator

var getted_image 

func _process(delta):
	pass

func _on_Button_pressed():
	var text = ImageTexture.new()
	getted_image = generator.get_image()
	text.create_from_image(getted_image)
	result.texture = text
