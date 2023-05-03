extends KinematicBody2D

var speed = 250
var direction = Vector2.UP
var hp = 1.0

var reloading = 0.0

export var player_id = 0

func _physics_process(delta):
	var input = Vector2()
	
	if player_id == 0:
		input.x = Input.get_action_strength("p1_right") - Input.get_action_strength("p1_left")
		input.y = Input.get_action_strength("p1_down") - Input.get_action_strength("p1_up")
	elif player_id == 1:
		input.x = Input.get_action_strength("p2_right") - Input.get_action_strength("p2_left")
		input.y = Input.get_action_strength("p2_down") - Input.get_action_strength("p2_up")
	
	input = input.normalized()
	move_and_slide(input * speed)
	
	var heading_to = global_position + input
	look_at(heading_to)
	$UI.rotation_degrees = -rotation_degrees
	
	if reloading:
		reloading -= delta
	
	if reloading < 0:
		reloading = 0
	
	var shoot = false
	
	if player_id == 0:
		if Input.get_action_strength("p1_shoot"):
			shoot = true
	elif player_id == 1:
		if Input.get_action_strength("p2_shoot"):
			shoot = true
	
	if shoot:
		if not reloading:
			reloading = 1.0
			var grenade: Node2D = load("res://FlyingGrenade.tscn").instance()
			get_parent().add_child(grenade)
			grenade.global_position = $Gun.global_position
			grenade.rotation = rotation

func _process(delta):
	$UI/HP.scale.x = clamp(hp, 0.0, 1.0)

func hit_by_grenade(grenade, collision):
	hp = hp - 0.501
	if hp <= 0.0:
		get_tree().reload_current_scene()
		
		if player_id == 0:
			Game.p2_score += 1
		elif player_id == 1:
			Game.p1_score += 1
