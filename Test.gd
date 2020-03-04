extends Control

onready var result = $Panel/Result
onready var generator = $VoronoiShaderGenerator
onready var multiplier = $Panel/Multiplier
onready var _seed = $Panel/Seed
onready var type = $Panel/NoiseType

var getted_image

func _process(delta):
	pass

func _on_Button_pressed():
	var text = ImageTexture.new()
	
	generator.multiplier = multiplier.value
	generator._seed = int(_seed.text)
	generator.type = type.get_selected_id()
	generator.___generate_image()
	yield(generator, "generated")
	getted_image = generator.get_image()
	text.create_from_image(getted_image)
	result.texture = text


func _on_RandomSeed_pressed():
	generator._seed = randi()
	_seed.text = str(generator._seed)
