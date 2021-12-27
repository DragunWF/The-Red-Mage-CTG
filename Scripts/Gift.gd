extends Area2D

const GRAVITY = 125

var motion = Vector2()

func _on_Gift_body_entered(body):
	if body.has_method("collect_gift"):
		body.call("collect_gift")
		queue_free()

func _process(delta):
	motion.y += GRAVITY
	motion = motion.normalized() * GRAVITY
	position += motion * delta

func item_void():
	queue_free()
