extends Node2D

onready var Spawner = $Spawner
onready var SteveTop = $SteveTop
onready var SteveBot = $SteveBot
onready var FilterTop = $FilterTop
onready var FilterBot = $FilterBot
onready var Score = $Score
onready var GameTimer = $Timer
onready var Level = $Level
onready var Switch = $Switch

var top_enabled = true
var score = 0
var level = 1
var level_time = 10

func _ready():
	Spawner.start_timer()
	randomize()
	SteveTop.init(Color.white, true)
	SteveBot.init(Color.black, false)
	FilterTop.color = Color(0,0,0,0)
	FilterBot.color = Color(0,0,0,0.6)
	update_score()
	update_level()
	GameTimer.start(level_time)


func _process(_delta):
	if Input.is_action_just_pressed("switch"):
		Switch.play()
		top_enabled = not top_enabled
		SteveTop.enabled = top_enabled
		SteveBot.enabled = not top_enabled
		if top_enabled:
			FilterTop.color = Color(0,0,0,0)
			FilterBot.color = Color(0,0,0,0.6)
		else:
			FilterTop.color = Color(0,0,0,0.6)
			FilterBot.color = Color(0,0,0,0)


func update_score():
	Score.text = "SCORE: " + str(score)


func update_level():
	Level.text = " LEVEL: " + str(level)
	

func add_score():
	score+=10
	update_score()


func game_over():
	pass
#	get_tree().quit()


func _on_SteveTop_add_score():
	add_score()


func _on_SteveTop_game_over():
	game_over()


func _on_SteveBot_add_score():
	add_score()


func _on_SteveBot_game_over():
	game_over()


func _on_Timer_timeout():
	Spawner.speed+=1
	level+=1
	update_level()
	GameTimer.start(level_time)
