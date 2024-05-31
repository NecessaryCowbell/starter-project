extends Area2D

@export_category("input nodes")
@export var marker_container: Node = null

func _ready():
	position = marker_container.get_children()[5].position

func respawn():
	var current_position = position
	for i in range(1, 10):
		position = marker_container.get_children()[randi_range(0, marker_container.get_child_count())-1].position
		if position != current_position:
			break

func _on_body_entered(body):
	body.score()
	respawn()
