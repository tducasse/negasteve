extends Control

onready var UI = $VBoxContainer
onready var Credits = $Credits
onready var CreditsDialog = $CreditsDialog
onready var BackgroundMusic = $BackgroundMusic
onready var DialogMusic = $DialogMusic

func _on_Button_pressed():
	BackgroundMusic.stop()
	DialogMusic.play()
	UI.visible = false
	Credits.visible = false
	var dialog = Dialogic.start('main')
	add_child(dialog)


func _on_Credits_pressed():
	CreditsDialog.popup_centered()
