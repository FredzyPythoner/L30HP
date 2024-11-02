extends CharacterBody2D


@onready var portal_a = $PortalA # Path to Portal A
@onready var portal_b = $PortalB # Path to Portal B

func _ready() -> void:
	rotation = 0

func teleport(target_portal):
	global_position = target_portal.global_position
	# Adjust rotation if necessary
	# Handle any state changes

# Movement speed variable
var speed = 200

func _physics_process(delta):
	# Get the mouse position in global coordinates
	var mouse_position = get_global_mouse_position()

	# Rotate to face the mouse position
	look_at(mouse_position)

	# Initialize velocity
	var velocity = Vector2()

	# Use up/down keys to control vertical movement
	if Input.is_action_pressed("up"):
		velocity.y -= 1  # Always move up in world space
	if Input.is_action_pressed("down"):
		velocity.y += 1  # Always move down in world space

	# Use left/right keys to control horizontal movement
	if Input.is_action_pressed("right"):
		velocity.x += 1  # Always move right in world space
	if Input.is_action_pressed("left"):
		velocity.x -= 1  # Always move left in world space

	# Normalize the velocity to maintain consistent speed
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	# Set the CharacterBody2D's velocity
	self.velocity = velocity

	# Move the CharacterBody2D
	move_and_slide()
	
