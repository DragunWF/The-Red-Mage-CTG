extends Area2D

const SPEED = 250

var motion = Vector2()

func _ready():
	$AnimatedSprite.play("Fire")

func _physics_process(delta):
	motion.x += -SPEED
	motion = motion.normalized() * SPEED
	position += motion * delta

func _on_FireballRight_body_entered(body):
	if body.has_method("hit_by_fireball"):
		body.call("hit_by_fireball")
	queue_free()

