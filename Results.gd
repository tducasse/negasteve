extends Control


onready var Level = $MarginContainer/VBoxContainer/Level
onready var Score = $MarginContainer/VBoxContainer/Score

onready var Margin = $MarginContainer
onready var Vbox = $MarginContainer/VBoxContainer
onready var Margin2 = $MarginContainer/VBoxContainer/MarginContainer


func _ready():
	Level.text = "LEVEL " + str(Global.level)
	Score.text = "SCORE: " + str(Global.score)
	Margin.mouse_filter = MOUSE_FILTER_IGNORE
	Margin2.mouse_filter = MOUSE_FILTER_IGNORE
	Vbox.mouse_filter = MOUSE_FILTER_IGNORE
	mouse_filter = MOUSE_FILTER_IGNORE
	get_tree().paused = false


func _on_Back_pressed():
	var _c = get_tree().change_scene("res://Menu.tscn")



func _on_TryAgain_pressed():
	var _c = get_tree().change_scene("res://Game.tscn")
