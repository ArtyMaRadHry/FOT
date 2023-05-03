extends HBoxContainer

func _process(delta):
	$Green.text = str(Game.p1_score)
	$Red.text = str(Game.p2_score)
