extends CharacterBody2D

var damage: int = 20
var health: int = 100
var player: Node2D

func take_damage(amount: int):
	health -= amount
	print("Enemy took damage: ", amount)
	print("Remaining health: ", health)

	if health <= 0:
		
		die()
		kill()

func die():
	print("Enemy has died!")
	$Polygon2D.visible = false
	$Explosion.emitting = true
	await $Explosion.finished
	queue_free()  # This will remove the player from the scene

func kill():
	Global.kills += 1  # Increment global kills counter
	print("Total kills: ", Global.kills)

func _on_area_entered(area):
	# area er skud
	print("Enemy on_area_entered")
	take_damage(damage)

func _process(delta: float) -> void:
	if player:
		velocity = (player.global_position - global_position).normalized() * 100
		var collision = move_and_collide(velocity * delta)
		if collision and collision.get_collider().has_method("take_damage"):
			collision.get_collider().take_damage(10)
			queue_free()



func _on_body_entered(body: Node2D) -> void:
	print("Enemy on_body_entered")
	# fjende rammer player
	body.take_damage(damage)
	queue_free()
