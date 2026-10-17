extends Node2D

@onready var garlic_container: HBoxContainer = $GarlicContainer
@onready var garlic: TextureRect = $GarlicContainer/Garlic
@onready var garlic_2: TextureRect = $GarlicContainer/Garlic2
@onready var garlic_3: TextureRect = $GarlicContainer/Garlic3
@onready var garlic_4: TextureRect = $GarlicContainer/Garlic4
@onready var garlic_5: TextureRect = $GarlicContainer/Garlic5
@onready var level: RichTextLabel = $Level
@onready var timer: RichTextLabel = $Timer

var time

func _ready() -> void:
	await Timer(5.0) 
	
func _process(delta: float) -> void: 
	match Global.lives: 

		4:
			garlic.hide()
		3:
			garlic.hide()
			garlic_2.hide()
		2:
			garlic.hide()
			garlic_2.hide()
			garlic_3.hide()
		1:
			garlic.hide()
			garlic_2.hide()
			garlic_3.hide()
			garlic_4.hide()
		0:
			garlic_container.hide() 
	
	timer.text = str(time) 
	level.text = "Level " + str(Global.minigames_done) 

func Timer(start_time: float): 
	
	time = start_time 
	
	while time > 0.0: 
		await wait(0.1) 
		time -= 0.1 
	if Global.minigames_done < 3: 
		Global.minigames_done = Global.minigames_done +1
		get_tree().change_scene_to_file("res://minigame_1.tscn") 
	else:
		get_tree().change_scene_to_file("res://scenes/title_screen.tscn") 

func wait(seconds: float) -> void: 
	await get_tree().create_timer(seconds).timeout 
