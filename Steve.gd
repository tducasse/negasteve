extends Node2D


onready var Black = $Black
onready var White = $White
onready var Death = $Death

var color = Color.black
var enabled = false

signal game_over
signal add_score

func init(c, e):
	color = c
	enabled = e
	if c == Color.black:
		Black.visible = true
		White.visible = false
		Black.play()
	else:
		Black.visible = false
		White.visible = true
		White.play()
		
		
func play_collision():
	var sound = randi() % 4 + 1
	var sound_node = get_node("Coll"+str(sound))
	sound_node.play()
	


func _on_Area2D_area_entered(area):
	if not enabled:
		return false
	var obstacle_color = area.get_color()
	area.delete()
	if obstacle_color == color:
		play_collision()
		emit_signal("add_score")
	else:
		Death.play()
		emit_signal("game_over")
