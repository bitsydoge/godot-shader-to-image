extends Control

onready var result = $Result
onready var generator = $VoronoiShaderGenerator

func _on_Button_pressed():
	var text = ImageTexture.new() 
	text.create_from_image(generator.get_image())
