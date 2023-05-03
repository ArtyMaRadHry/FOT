extends KinematicBody2D

var speed = 100
var direction = Vector2.UP

func _physics_process(delta):
	var input = Vector2() 
	input.x = Input.get_action_strength("p1_right") - Input.get_action_strength("p1_left")
	input.y = Input.get_action_strength("p1_down") - Input.get_action_strength("p1_up")
	input = input.normalized()
	move_and_slide(input * speed)
