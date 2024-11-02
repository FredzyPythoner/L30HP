extends Node2D

@export var target_portal: NodePath
var linked_portal: Node2D
var recently_teleported = []

func _ready():
	if target_portal: 
		linked_portal = get_node(target_portal)
	else:
		linked_portal = null
	$Area2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if linked_portal and body.has_method("teleport"):
		if body in recently_teleported:
			return  # Prevent immediate re-teleportation
		body.teleport(linked_portal)
		linked_portal.add_recently_teleported(body)

func add_recently_teleported(body):
	recently_teleported.append(body)
	await get_tree().create_timer(0.1).timeout  # Adjust the delay as needed
	recently_teleported.erase(body)
