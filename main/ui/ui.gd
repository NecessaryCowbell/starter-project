extends Node

var startText: Label
var scoreText: Label
# Called when the node enters the scene tree for the first time.
func _ready():
	startText = $startText
	scoreText = $scoreText
	updateScore(0)

func updateScore(score):
	scoreText.set_text("score: " + str(score))

func startPlay():
	startText.hide()
	
