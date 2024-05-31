extends StaticBody2D

@export_category("textures")
@export var normal_texture: Texture2D = null
@export var highlight_texture: Texture2D = null
var sprite: Sprite2D

func _ready():
	sprite = $sprite
	set_meta("wall", "tail")
	sprite.set_texture(normal_texture)

func highlight():
	sprite.set_texture(highlight_texture)
