# godot-shader-to-image
A simple tool to render Image with Godot (Tested on 3.2). It use tricks with viewport and image rendering.
It's usefull because you can generate thing GPU side then use them CPU side and because godot doesn't have easy way to get a Texture to an Image POST shading.

## How to use
Drop the "ShaderToImage" folder into your Godot project.

Instance the scene ShaderToImage.tscn in your current scene.

Then generate the Image :

```gdscript
my_material = load("some_material_path.material")
shader_to_image.generate_image(my_material) # Start generating the image
yield(shader_to_image, "generated") # Wait the image to be rendered, it take 3 frams
var my_image = shader_to_image.get_image()
```

## Reference
### Functions

```gdscript
func generate_image(material : Material, resolution := Vector2(512,512), multiplier := 1.0, args := {}):
```
Generate the new image. It is avaiable only when the Signal "generated" is emited.
- material (Material) : the material you want to render
- resolution (Vector2) : the final Image resolution, it can be passed to your shader as a uniform
- multiplier (float) : if you have an uniform it will "zoom in" "zoom out" on your shader will keeping the output resolution
- args (Dictionary) : You can pass argument to the uniform of the shader with a Dictionary. Ex : `{"time": 50.2, "mod1" : 0.8, "mod2" : 0.45}`

```gdscript
func get_image() -> Image:
```
Return the image reference, if no image have been generated return null and print an error

### Signal
```gdscript
signal generated
```
Signal emited everytime an image is generated. (It need 3 frames to be generated)

### Shader Uniform
```gdscript
uniform vec2 resolution
```
Add it to your shader to handle the surface resoltion, it will take the value from the value `resolution*multiply` from generate_image function

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

## Licence Info
The MIT licence doesn't include the shaders inside the folder "ExampleShaders"
