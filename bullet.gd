extends Area2D

var color = Polygon2D
var timer: int = 0
var speed = 750
var linear_velocity = 100
func _physics_process(delta):
        position += transform.x * speed * delta

func teleport(target_portal: Node2D) -> void:
        # Move this bullet to the exit portal
        global_position = target_portal.global_position

        # Spawn an additional bullet with the same orientation
        var bullet_scene = preload("res://Scenes/bullet.tscn")
        var extra_bullet = bullet_scene.instantiate()
        extra_bullet.global_transform = global_transform
        get_parent().add_child(extra_bullet)

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
