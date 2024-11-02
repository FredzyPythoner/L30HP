extends Area2D

var damage: int = 20
var health: int = 100

func take_damage(amount: int):
	health -= amount
	print("Enemy took damage: ", amount)
	print("Remaining health: ", health)

	if health <= 0:
		die()

func die():
	print("Player has died!")
	queue_free()  # This will remove the player from the scene


func _on_area_entered(area):
	take_damage(damage)

@export var player: CharacterBody2D

func _process(delta: float) -> void:
	$".".transform.Position += (player.position - position).normalized() * delta * 20
