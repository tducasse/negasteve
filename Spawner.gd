extends Node2D

var ObstacleScene = preload("res://Obstacle.tscn")

# how many obstacles per second
var speed = 1

onready var SpawnTimer = $Timer


func start_timer():
	SpawnTimer.start(10/(12+speed+rand_range(0,10)))


func _on_Timer_timeout():
	spawn_obstacle()
	start_timer()


func spawn_obstacle():
	var Obstacle = ObstacleScene.instance()
	add_child(Obstacle)
	Obstacle.init(speed, get_rand_color())


func get_rand_color():
	return [Color.black, Color.white][randi() % 2]
