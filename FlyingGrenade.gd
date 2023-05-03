extends KinematicBody2D

var speed = 300

func _physics_process(delta):
	var move = Vector2.RIGHT * speed * delta
	var collision = move_and_collide(move.rotated(rotation))
	if collision:
		self.get_parent().remove_child(self)
		
		if  collision.collider.has_method("hit_by_grenade"):
			collision.collider.hit_by_grenade(self, collision)
