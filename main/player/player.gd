extends CharacterBody2D

@export_category("node links")
@export var ui: Node = null

@export_category("properties")
@export var speed: float = 400
@export var jump_velocity: float = -950.0
@export var gravity: float = 50

enum {
	START,
	PLAY,
	GAMEOVER
}
var direction = 0
var state = START

func get_input():
	if Input.is_action_just_pressed("action_left"):
		direction = -1
	if Input.is_action_just_pressed("action_right"):
		direction = 1
	if Input.is_action_just_pressed("action_jump") and is_on_floor():
		velocity.y = jump_velocity
	if Input.is_action_just_pressed("action_reset"):
		get_tree().reload_current_scene()

func _physics_process(delta):
	get_input()
	match state:
		START:
			doStartState()
		PLAY:
			doPlayState(delta)
		GAMEOVER:
			doGameOverState()
			
func doStartState():
	if direction != 0:
		state = PLAY
		ui.startPlay()
		
func doGameOverState():
	pass

func doPlayState(_delta):
	if not is_on_floor():
		velocity.y += gravity

	velocity.x = direction * speed

	move_and_slide()
	
	for i in get_slide_collision_count():
		processCollision(get_slide_collision(i))
	
	if checkIfStopped():
		state = GAMEOVER

var latestWall = null

func processCollision(collision: KinematicCollision2D):
	var collider: Object = collision.get_collider()
	if abs(collision.get_normal().y) < 0.01:
		if collider.has_meta("wall"):
			latestWall = collider

func checkIfStopped():
	if is_on_wall() and is_on_floor():
		if latestWall != null and latestWall.has_method("highlight"):
			latestWall.highlight()
			
		return true
	return false

var current_score = 0
func score():
	current_score += 1
	ui.updateScore(current_score)
	
func get_score():
	return current_score
