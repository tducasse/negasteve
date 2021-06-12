extends Node2D

var speed = null
var color = Color.black
onready var Wall = $Wall
onready var CollisionShapeItem = $ObstacleArea/CollisionShape2D

var min_x = 20
var max_x = 50
var min_y = 50
var max_y = 530


func init(s, c):
	speed = 10+s
	color = c
	Wall.color = c
	set_random_size()


func _process(_delta):
	move()


func move():
	position.x-=speed


func _on_ObstacleArea_delete():
	queue_free()


func set_random_size():
	var x = rand_range(min_x, max_x)
	var y = rand_range(min_y, max_y)
	Wall.rect_size.x = x
	Wall.rect_size.y = y
	Wall.rect_position.y = -y/2
	Wall.rect_position.x = -x/2
