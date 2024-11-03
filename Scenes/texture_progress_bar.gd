extends TextureProgressBar

@export var player: Node2D


func _process(delta: float) -> void:
	value = player.health
