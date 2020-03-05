extends Control

onready var result = $Panel/Result
onready var generator = $VoronoiShaderGenerator
onready var multiplier = $Panel/Multiplier
onready var type = $Panel/NoiseType
onready var time = $Panel/Time
onready var mod1 = $Panel/Mod1
onready var mod2 = $Panel/Mod2

var enable_time = false

var getted_image

func build_noise_type():
	for _type in generator.___type_list:
		var name = _type.name
		name += " ("
		for arg in _type.args:
			name+=arg+", "
		name += ")"
		type.add_item(name) 
	pass

func _ready():
	build_noise_type();

func _process(_delta):
	if enable_time:
		time.text = str(OS.get_ticks_msec()/1000.0)
	pass

func _on_Button_pressed():
	generator.multiplier = multiplier.value
	generator.type = type.get_selected_id()
	generator.time = int(time.text)
	generator.mod1 = mod1.value
	generator.mod2 = mod2.value
	
	generator.___generate_image()
	yield(generator, "generated")
	getted_image = generator.get_image()
	
	var text = ImageTexture.new()
	text.create_from_image(getted_image)
	result.texture = text


func _on_EnableTime_pressed():
	enable_time=!enable_time
	pass # Replace with function body.
