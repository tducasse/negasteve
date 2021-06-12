extends Area2D

signal delete

func delete():
	emit_signal("delete")
	
func get_color():
	return get_parent().color
