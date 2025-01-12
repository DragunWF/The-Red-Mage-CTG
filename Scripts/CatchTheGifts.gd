extends Node2D

const FireEnemy = preload("res://Enemies/Fire Dood/FireDood.tscn")
const FireEnemy2 = preload("res://Enemies/Fire Dood/FireDood2.tscn")
const EnergyEnemy = preload("res://Enemies/Energy Dood/EnergyDood.tscn")
const EnergyEnemy2 = preload("res://Enemies/Energy Dood/EnergyDood2.tscn")
const Gift = preload("res://Items/Gift/Gift.tscn")

var TimeLimit = 100
var start = false
var random_number = 0
var random_enemy_number = 0

#Item Spawn Points
onready var Point1 = get_node("Spawn Points/Item Points/Position1")
onready var Point2 = get_node("Spawn Points/Item Points/Position2")
onready var Point3 = get_node("Spawn Points/Item Points/Position3")
onready var Point4 = get_node("Spawn Points/Item Points/Position4")
onready var Point5 = get_node("Spawn Points/Item Points/Position5")
onready var Point6 = get_node("Spawn Points/Item Points/Position6")
onready var Point7 = get_node("Spawn Points/Item Points/Position7")
onready var Point8 = get_node("Spawn Points/Item Points/Position8")
onready var Point9 = get_node("Spawn Points/Item Points/Position9")

onready var EnPosition1 = get_node("Spawn Points/Enemy Points/Position1")
onready var EnPosition2 = get_node("Spawn Points/Enemy Points/Position2")
onready var TimeBar = get_node("CanvasLayer/Time Bar/ProgressBar")

func _ready():
	$GameTime.set_one_shot(false)
	$EnterTime.set_one_shot(false)
	$NumberGenerator.set_one_shot(false)
	$EnemySpawnTime.set_one_shot(false)
	$EnterTime.set_wait_time(3)
	$EnterTime.start()

func _process(delta):
	TimeBar.set_value(TimeLimit)
	if TimeLimit <= 0:
		TimeLimit = 0
	if TimeLimit == 0:
		get_node("CanvasLayer(Layer6)/PauseMenu").remove_access_to_pause_menu()
		get_node("Player").gameover()

# Absolutely terrible code below...
# Oi, it was 2 years ago and I was quite oblivious to pretty much a lot of things back then
# This was when back when I barely knew how to program things properly...
func spawn_gift():
	if random_number == 1:
		var gift = Gift.instance()
		get_parent().add_child(gift)
		gift.set_position(Point1.get_global_position())
	if random_number == 2:
		var gift = Gift.instance()
		get_parent().add_child(gift)
		gift.set_position(Point2.get_global_position())
	if random_number == 3:
		var gift = Gift.instance()
		get_parent().add_child(gift)
		gift.set_position(Point3.get_global_position())
	if random_number == 4:
		var gift = Gift.instance()
		get_parent().add_child(gift)
		gift.set_position(Point4.get_global_position())
	if random_number == 5:
		var gift = Gift.instance()
		get_parent().add_child(gift)
		gift.set_position(Point5.get_global_position())
	if random_number == 6:
		var gift = Gift.instance()
		get_parent().add_child(gift)
		gift.set_position(Point6.get_global_position())
	if random_number == 7:
		var gift = Gift.instance()
		get_parent().add_child(gift)
		gift.set_position(Point7.get_global_position())
	if random_number == 8:
		var gift = Gift.instance()
		get_parent().add_child(gift)
		gift.set_position(Point8.get_global_position())
	if random_number == 9:
		var gift = Gift.instance()
		get_parent().add_child(gift)
		gift.set_position(Point9.get_global_position())

func spawn_enemy():
	if random_enemy_number == 1:
		var enemy = FireEnemy.instance()
		get_parent().add_child(enemy)
		enemy.set_position(EnPosition1.get_global_position())
	if random_enemy_number == 2:
		var enemy = EnergyEnemy2.instance()
		get_parent().add_child(enemy)
		enemy.set_position(EnPosition2.get_global_position())
	if random_enemy_number == 3:
		var enemy = FireEnemy2.instance()
		get_parent().add_child(enemy)
		enemy.set_position(EnPosition2.get_global_position())
	if random_enemy_number == 4:
		var enemy = EnergyEnemy.instance()
		get_parent().add_child(enemy)
		enemy.set_position(EnPosition1.get_global_position())

func _on_Right_body_entered(body):
	if body.has_method("disband_left"):
		body.call("disband_left")

func _on_Left_body_entered(body):
	if body.has_method("disband_right"):
		body.call("disband_right")

func _on_EnterTime_timeout():
	if start == false:
		start = true
		start_game_time()
		start_number_generator()
		enemy_spawn_time_start()

func start_game_time():
	$GameTime.set_wait_time(1)
	$GameTime.start()

func _on_GameTime_timeout():
	TimeLimit -= 1
	$GameTime.set_one_shot(true)
	start_game_time()

func start_number_generator():
	$NumberGenerator.set_wait_time(0.5)
	$NumberGenerator.start()

func _on_NumberGenerator_timeout():
	random_number = randi()%9 +1
	start_number_generator()
	spawn_gift()
	$NumberGenerator.set_one_shot(true)

func _on_ItemVoid_area_entered(area):
	if area.has_method("item_void"):
		area.call("item_void")

func enemy_spawn_time_start():
	$EnemySpawnTime.set_wait_time(2)
	$EnemySpawnTime.start()

func _on_EnemySpawnTime_timeout():
	random_enemy_number = randi()%4 +1
	enemy_spawn_time_start()
	spawn_enemy()
	$EnemySpawnTime.set_one_shot(true)
