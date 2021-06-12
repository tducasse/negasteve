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
onready var Death = $Death
onready var Heart = $Lives/heart
onready var Heart2 = $Lives/heart2
onready var Heart3 = $Lives/heart3
onready var Hurt = $Hurt

var top_enabled = true
var score = 0
var level = 1
var level_time = 10
var paused = false
var flicker = false
var lives = 3

func _ready():
	pause_mode=PAUSE_MODE_PROCESS
	SteveTop.pause_mode=PAUSE_MODE_STOP
	SteveBot.pause_mode=PAUSE_MODE_STOP
	Spawner.pause_mode=PAUSE_MODE_STOP
	Spawner.start_timer()
	randomize()
	SteveTop.init(Color.white, true)
	SteveBot.init(Color.black, false)
	FilterTop.color = Color(0,0,0,0)
	FilterBot.color = Color(0,0,0,0.6)
	update_global()
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


func update_global():
	Global.score = score
	Global.level = level


func update_score():
	Score.text = "SCORE: " + str(score)


func update_level():
	Level.text = " LEVEL " + str(level)
	

func add_score():
	score+=10
	update_score()
	
	
func do_flicker():
	while flicker:
		if FilterTop.color == Color(0,0,0,0.6):
			FilterTop.color = Color(0,0,0,0)
			FilterBot.color = Color(0,0,0,0.6)
		else:
			FilterTop.color = Color(0,0,0,0.6)
			FilterBot.color = Color(0,0,0,0)
		yield(get_tree().create_timer(0.1), "timeout")
	


func game_over():
	if lives > 0:
		lives-=1
		Hurt.play()
		if lives < 3:
			Heart.visible = false
		if lives < 2:
			Heart2.visible = false
		if lives < 1:
			Heart3.visible = false
		return
	paused = true
	get_tree().paused = true
	Death.play()
	flicker = true
	do_flicker()
	GameTimer.start(1)


func _on_SteveTop_add_score():
	add_score()


func _on_SteveTop_game_over():
	game_over()


func _on_SteveBot_add_score():
	add_score()


func _on_SteveBot_game_over():
	game_over()


func _on_Timer_timeout():
	if paused:
		flicker = false
		update_global()
		var _c = get_tree().change_scene("res://Results.tscn")
	Spawner.speed+=1
	level+=1
	update_level()
	GameTimer.start(level_time)
