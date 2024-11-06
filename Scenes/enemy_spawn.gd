extends Node2D

var time = 0.001
# Exported variables
@export var enemy_scene = preload("res://Scenes/enemy.tscn")
@export var spawn_area = Vector2(800, 500) # Define the spawn area size
@export var spawn_interval = 1000        # Time in seconds between spawns
@export var player: Node2D

# Internal timer for spawning
var _spawn_timer = 0

func _ready():
	_spawn_timer = spawn_interval
	randomize() # Ensure we get different random numbers each time

func _process(delta):
	# Decrement the spawn timer
	time += (delta/10)
	_spawn_timer -= delta
	_spawn_timer -= time

	# Check if it's time to spawn an enemy
	if _spawn_timer <= 0:
		spawn_enemy()
		_spawn_timer = spawn_interval # Reset the timer

func spawn_enemy():
	# Instance a new enemy
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.player = player

	# Randomize the enemy's position within the spawn area
	var random_position = Vector2(
		randf_range(-spawn_area.x / 2, spawn_area.x / 2),
		randf_range(-spawn_area.y / 2, spawn_area.y / 2)
	)
	
	enemy_instance.position = position + random_position # Adjust relative to spawner position

	# Add the enemy to the scene tree
	add_child(enemy_instance)
