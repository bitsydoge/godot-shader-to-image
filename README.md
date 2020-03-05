# godot-shader-to-image
A simple tool to render Image with Godot (Tested on 3.2). It use tricks with viewport and image rendering.
It's usefull because you can generate thing GPU side then use them CPU side and because godot doesn't have easy way to get a Texture to an Image POST shading.

## How to use
Drop the "ShaderToImage" folder into your Godot project.

Instance the scene GodotToImage.tscn in your current scene.
Make sure it apear on the current camera (or on the screen).

Add custom material to the generator : 
```gdscript
var custom_material = preload("my_custom.material")
func _ready():
	var my_id = shader_to_image.add_custom_type("Custom1", custom_material, ["time", "mod1"])
```

Then generate an Image :
```gdscript
shader_to_image.set_type_id(my_id) # Choose the material to use
shader_to_image.generate_image() # Start generating the image
yield(shader_to_image, "generated") # Wait the image to be rendered, it take 3 frams
var my_image = shader_to_image.get_image()
```

## Reference
### Shader Variables
```gdscript
resolution = Vector2(512,512)
```
The resolution you want the Image to be
```gdscript
multiplier = 1.0
```
Zoom in or Zoom out on the shader (keep the resolution rendering)
```gdscript
time = 0.0
```
uniform you can set to edit the shader with time
```gdscript
mod1 = 1.0
```
uniform you can set to edit the shader
```gdscript
mod2 = 0.0
```
uniform you can set to edit the shader

### Functions
```gdscript
func get_type_list() -> Array:
```
The array with the Dictionary of each material type
```gdscript
func get_image() -> Image:
```
Return the image reference
```gdscript
func add_custom_type(name : String, material : Material, args) -> int:
```
Add your custom material to the material list. Return its ID inside type_list.
args represent an array of args for this array
TODO : you will add any argument you want for now it have "hard coded" time, mod1, mod2
```gdscript
func generate_image() -> void:
```
Generate the new image. It is avaiable only when the Signal "generated" is emited.

### Signal
```gdscript
signal generated
```
Signal emited everytime an image is generated. (It need 3 frames to be generated)

## Shader example
```glsl
shader_type canvas_item;

uniform vec2 resolution;
uniform float time;

float random (vec2 source) 
{
  return fract(sin(dot(source.xy,vec2(12.9898,78.233)))*43758.5453);
}

void fragment() 
{
    vec2 coordo = FRAGCOORD.xy/resolution.xy;
    float rand = random(coordo*time);
    COLOR = vec4( vec3(rand), 1.0);
}
```

## TODO
I need to add easy custom args

## Licence Info
The MIT licence doesn't include the shaders inside the folder "ExampleShaders"
