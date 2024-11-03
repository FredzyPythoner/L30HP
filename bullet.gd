extends Area2D

var speed = 750
var linear_velocity = 100
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	print("Bullet on_Bullet_body_entered")
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()


var damage: int = 20

func _on_body_entered(body: Node2D) -> void:
	print("Bullet on_body_entered")
	if body.is_in_group("mobs"):
		body.take_damage(damage)
		queue_free()
