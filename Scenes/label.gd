extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# You can initialize something here if needed
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Assign the current kill count to the label's text
	text = str(Global.kills)
