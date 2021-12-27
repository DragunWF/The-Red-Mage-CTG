extends KinematicBody2D

const GRAVITY = 20
const SPEED = 125

var motion = Vector2()
var right = false
var left = false

func _ready():
	$AnimatedSprite.play("Walk")

func _physics_process(delta):
	motion.y += GRAVITY
	motion.x = SPEED
	motion = move_and_slide(motion, Vector2(0, -1))

func disband_right():
	queue_free()

func hit_by_fireball():
	queue_free()

func hit_by_energy_blast():
	$Absorb.play()

func _on_Hitbox_body_entered(body):
	if body.has_method("hit_by_enemy"):
		body.call("hit_by_enemy")