extends Area2D

var damage: int = 20
var health: int = 100

func _on_body_entered(body: Node2D) -> void:
	if 1 == 1:
		body.take_damage(damage)

func take_damage(amount: int):
	health -= amount
	print("Enemy took damage: ", amount)
	print("Remaining health: ", health)

	if health <= 0:
		die()

func die():
	print("Player has died!")
	queue_free()  # This will remove the player from the scene
