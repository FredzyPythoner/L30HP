extends CharacterBody2D


# Movement speed variable
var speed = 200
var health: int = 100

@export var Bullet : PackedScene
@onready var portal_a = $PortalA # Path to Portal A
@onready var portal_b = $PortalB # Path to Portal B
@onready var sound_player = $"../AudioShoot"  # Adjust the path if necessary


func teleport(target_portal):
	global_position = target_portal.global_position



func _physics_process(delta):
	# Get the mouse position in global coordinates
	var mouse_position = get_global_mouse_position()

	# Rotate to face the mouse position
	look_at(mouse_position)

	# Initialize velocity
	velocity = Vector2()

	# Use up/down keys to control vertical movement
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1  # Always move up in world space
	if Input.is_action_pressed("move_down"):
		velocity.y += 1  # Always move down in world space

	# Use left/right keys to control horizontal movement
	if Input.is_action_pressed("move_right"):
		velocity.x += 1  # Always move right in world space
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1  # Always move left in world space

	# Normalize the velocity to maintain consistent speed
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	# Set the CharacterBody2D's velocity
	self.velocity = velocity

	# Move the CharacterBody2D
	move_and_slide()
	if Input.is_action_just_pressed("fire"):
		shoot()
		on_some_event()
		$fireparticles.emitting = true

func play_sound():
	sound_player.play()  # This plays the sound

# Example function to call when an event occurs
func on_some_event():
	play_sound()  # Call this to play the sound when the event happens


		

func shoot():
	var b = Bullet.instantiate()
	get_parent().add_child(b)
	b.global_transform = $Muzzle.global_transform


func take_damage(amount: int):
	health -= amount
	print("Player took damage: ", amount)
	print("Remaining health: ", health)

	if health <= 0:
		die()

func die():
	print("Player has died!")
	#queue_free()  # This will remove the player from the scene
	get_tree().paused = true


var player: Node2D

func _ready():
	# Get the player node from the "Player" group
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() > 0:
		player = players[0]
	else:
		print("Player not found in the scene tree.")
