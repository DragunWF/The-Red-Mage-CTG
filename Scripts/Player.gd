extends KinematicBody2D

const FireballRight = preload("res://Player/Fireball/FireballRight.tscn")
const FireballLeft = preload("res://Player/Fireball/FireballLeft.tscn")
const BlastRight = preload("res://Player/EnergyBall/EnergyBlastRight.tscn")
const BlastLeft = preload("res://Player/EnergyBall/EnergyBlastLeft.tscn")

const UP = Vector2(0, -1)
const GRAVITY = 20
const JUMP_HEIGHT = -325
const MAX_SCORE = 100

var motion = Vector2()
var speed = 175
var score = 0
var airborne = false
var invincible = false
var cooldown = false

#Right and Left
var right = false
var left = false

#Red and Blue Mode
var RedMage = false
var BlueMage = false

onready var PlayerSprite = get_node("AnimatedSprite")
onready var BlueMageSprite = get_node("BlueMageSprite")
onready var collision = get_node("CollisionShape2D")
onready var FireballCastTime = get_node("FireballCooldown")
onready var EnergyCastTime = get_node("EnergyBlastCooldown")
onready var InvincibleTime = get_node("InvincibilityTime")
onready var ScoreBar = get_node("CanvasLayer/Score Bar/ProgressBar")
onready var TotalScore = $CanvasLayer2/GameOver/Score

func _ready():
	PlayerSprite.play("Idle")
	right = true
	FireballCastTime.set_one_shot(false)
	EnergyCastTime.set_one_shot(false)
	InvincibleTime.set_one_shot(false)
	$CanvasLayer2/GameOver.visible = false
	RedMage = true

func _physics_process(delta):
	motion.y += GRAVITY
	ScoreBar.set_value(score)
	TotalScore.set_text(str(score))
	if score <= 0:
		score = 0
	if score >= 100:
		score = 100
	if RedMage == true and BlueMage == false:
		PlayerSprite.visible = true
		BlueMageSprite.visible = false
	if RedMage == false and BlueMage == true:
		BlueMageSprite.visible = true
		PlayerSprite.visible = false
	if invincible == true and airborne == false:
		PlayerSprite.play("Damage")
		BlueMageSprite.play("Damage")
	if invincible == true and airborne == true:
		PlayerSprite.play("JumpDamage")
		BlueMageSprite.play("JumpDamage")
	if Input.is_action_pressed("ui_right"):
		if airborne == false and invincible == false:
			PlayerSprite.play("Walk")
			BlueMageSprite.play("Walk")
		PlayerSprite.flip_h = false
		BlueMageSprite.flip_h = false
		motion.x = speed
		right = true
		left = false
	elif Input.is_action_pressed("ui_left"):
		if airborne == false and invincible == false:
			PlayerSprite.play("Walk")
			BlueMageSprite.play("Walk")
		PlayerSprite.flip_h = true
		BlueMageSprite.flip_h = true
		motion.x = -speed
		right = false
		left = true
	else:
		if airborne == false and invincible == false:
			PlayerSprite.play("Idle")
			BlueMageSprite.play("Idle")
		motion.x = 0
	if is_on_floor():
		airborne = false
		if Input.is_action_just_pressed("ui_up") and airborne == false:
			$JumpSound.play()
			PlayerSprite.play("Jump")
			BlueMageSprite.play("Jump")
			airborne = true
			motion.y = JUMP_HEIGHT
	if Input.is_action_just_pressed("ui_accept"):
		if FireballCastTime.is_stopped() and RedMage == true:
			$FireballSound.play()
			score -= 3
			cast_fireball()
			_cast_fireball_time()
		if EnergyCastTime.is_stopped() and BlueMage == true:
			$BlastSound.play()
			score -= 3
			cast_energy_blast()
			_cast_energy_blast_time()
	motion = move_and_slide(motion, UP)

func _input(event):
	if Input.is_key_pressed(KEY_Z) and BlueMage == false:
		$SwitchSound.play()
		RedMage = false
		BlueMage = true
	if Input.is_key_pressed(KEY_X) and RedMage == false:
		$SwitchSound.play()
		BlueMage = false
		RedMage = true

func cast_fireball():
	$FireballSound.play()
	if right == true:
		var fire = FireballRight.instance()
		get_parent().add_child(fire)
		fire.set_position(get_node("PositionRight").get_global_position())
	if left == true:
		var fire = FireballLeft.instance()
		get_parent().add_child(fire)
		fire.set_position(get_node("PositionLeft").get_global_position())

func _cast_fireball_time():
	FireballCastTime.set_wait_time(1)
	FireballCastTime.start()

func _on_FireballCooldown_timeout():
	FireballCastTime.set_one_shot(true)

func cast_energy_blast():
	$BlastSound.play()
	if right == true:
		var blast = BlastRight.instance()
		get_parent().add_child(blast)
		blast.set_position(get_node("PositionRight").get_global_position())
	if left == true:
		var blast = BlastLeft.instance()
		get_parent().add_child(blast)
		blast.set_position(get_node("PositionLeft").get_global_position())

func _cast_energy_blast_time():
	EnergyCastTime.set_wait_time(1)
	EnergyCastTime.start()

func _on_EnergyBlastCooldown_timeout():
	EnergyCastTime.set_one_shot(true)

func collect_gift():
	$CollectSound.play()
	score += 2

func hit_by_enemy():
	if invincible == false:
		$DamageSound.play()
		score -= 10
		invincible_time_start()

func invincible_time_start():
	InvincibleTime.set_wait_time(1)
	InvincibleTime.start()
	invincible = true

func _on_InvincibilityTime_timeout():
	invincible = false
	InvincibleTime.set_one_shot(true)

#Game Over Menu
func _on_Retry_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_Return_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Main Menu.tscn")

func _on_Quit_pressed():
	get_tree().paused = false
	get_tree().quit()

func gameover():
	if score <= 49:
		$LoseSound.play()
	if score >= 50:
		$WinSound.play()
	$CanvasLayer2/GameOver.visible = true
	get_tree().paused = true
