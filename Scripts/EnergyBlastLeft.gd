extends Area2D

const SPEED = 225

var motion = Vector2()

func _ready():
	$AnimatedSprite.play("Blast")

func _physics_process(delta):
	motion.x += -SPEED
	motion = motion.normalized() * SPEED
	position += motion * delta

func _on_EnergyBlastLeft_body_entered(body):
	if body.has_method("hit_by_energy_blast"):
		body.call("hit_by_energy_blast")
	queue_free()
