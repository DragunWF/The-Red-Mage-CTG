extends Control

onready var StartMenu = get_node("StartMenu")
onready var GuideMenu = get_node("HowtoPlay")
onready var Controls = get_node("Controls")
onready var Enemies = get_node("Enemies")
onready var Score = get_node("Score")
onready var Objective = get_node("Objective")

#Main Menu
func _ready():
	$Music.play()
	$RedMage.play("Idle")
	$BlueMage.play("Idle")

func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/CatchTheGifts.tscn")

func _on_About_pressed():
	$Click.play()
	StartMenu.visible = false
	GuideMenu.visible = true

func _on_Quit_pressed():
	get_tree().quit()

#Guide Menu
func _on_Controls_pressed():
	$Click.play()
	GuideMenu.visible = false
	Controls.visible = true

func _on_Objective_pressed():
	$Click.play()
	GuideMenu.visible = false
	Objective.visible = true

func _on_Enemies_pressed():
	$Click.play()
	GuideMenu.visible = false
	Enemies.visible = true

func _on_Score_pressed():
	$Click.play()
	GuideMenu.visible = false
	Score.visible = true

func _on_Back_pressed():
	$Click.play()
	GuideMenu.visible = false
	StartMenu.visible = true

#Back to Guide Menu Buttons
func _on_BackGM_pressed():
	$Click.play()
	Controls.visible = false
	GuideMenu.visible = true

func _on_BackGME_pressed():
	$Click.play()
	Enemies.visible = false
	GuideMenu.visible = true

func _on_BackGMS_pressed():
	$Click.play()
	Score.visible = false
	GuideMenu.visible = true

func _on_BackGMO_pressed():
	$Click.play()
	Objective.visible = false
	GuideMenu.visible = true
