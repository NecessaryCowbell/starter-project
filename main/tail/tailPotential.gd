extends Area2D

@export_category("node links")
@export var tailSegment: Node2D = null

@export_category("properties")
@export var spawn_delay: float = 0.2

var player = null
var time_alive = 0
enum {
	EMPTY,
	FULL
}
var state = EMPTY
var obstructed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	state = FULL
	call_deferred("despawn_tail")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		EMPTY:
			pass
		FULL:
			doStateFull(delta)

func doStateFull(delta):
	if time_alive > player.get_score():
		call_deferred("despawn_tail")
	if tailSegment.visible:
		time_alive += delta

func _on_body_entered(_body):
	obstructed = true


func _on_body_exited(body):
	obstructed = false
	if state == EMPTY:
		player = body
		delay(0.3, func(): spawn_tail(body))

func delay(_time, callback):
	await get_tree().create_timer(spawn_delay).timeout
	callback.call()

func despawn_tail():
	assert(state == FULL)
	tailSegment.visible = false
	tailSegment.find_child("CollisionShape2D").disabled = true
	tailSegment.set_physics_process(false)
	time_alive = 0
	player = null
	state = EMPTY
	
func spawn_tail(_body):
	if state == EMPTY:
		if obstructed:
			await body_exited
		if not obstructed:
			if player.get_score() > 0:
				tailSegment.visible = true
				tailSegment.find_child("CollisionShape2D").disabled = false
				tailSegment.set_physics_process(true)
				state = FULL
