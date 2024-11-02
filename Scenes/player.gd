extends Area2D

# Speed of the player movement in pixels per second
var speed = 400

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	# Check for movement input
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1

	# Normalize the input vector to prevent faster diagonal movement
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		# Move the player
		position += input_vector * speed * delta
