extends Control

var active = true

onready var Menu = get_node("Menu")

func _ready():
	Menu.visible = false

func _input(event):
	if Input.is_action_just_pressed("ui_cancel") and active == true:
		Menu.visible = true
		get_tree().paused = true

func _on_Resume_pressed():
	$ClickSound.play()
	Menu.visible = false
	get_tree().paused = false

func _on_Restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_Return_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Main Menu.tscn")

func _on_Quit_pressed():
	get_tree().quit()

func remove_access_to_pause_menu():
	active = false
