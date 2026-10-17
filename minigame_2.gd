extends Node2D
@onready var themed_timer: Node2D = $ThemedTimer

var buttons_pressed := 0
var timer_end = false

func _ready() -> void:
	await themed_timer.start_timer(10.0)
	timer_end = true 


func _process(delta: float) -> void:
	if buttons_pressed == 4:
		if Global.minigames_done > 3:
			get_tree().change_scene_to_file("res://scenes/done_screen.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/timer_screen.tscn")
	
	if timer_end:
		Global.lives -= 1
		Global.minigames_done -=1
		get_tree().change_scene_to_file("res://scenes/timer_screen.tscn")


func _on_button_1_pressed() -> void:
	buttons_pressed +=1
	$Button_1.hide()

func _on_button_2_pressed() -> void:
	buttons_pressed +=1
	$Button_2.hide()

func _on_button_3_pressed() -> void:
	buttons_pressed += 1
	$Button_3.hide()

func _on_button_4_pressed() -> void:
	buttons_pressed += 1
	$Button_4.hide()


func _on_button_5_pressed() -> void:
	buttons_pressed += 1
	$Button_5.hide()

func _on_button_6_pressed() -> void:
	buttons_pressed += 1
	$Button_6.hide()

func _on_button_7_pressed() -> void:
	buttons_pressed += 1
	$Button_7.hide()

func _on_button_8_pressed() -> void:
	buttons_pressed += 1
	$Button_8.hide()

func _on_button_9_pressed() -> void:
	buttons_pressed += 1
	$Button_9.hide()

func _on_button_10_pressed() -> void:
	buttons_pressed += 1
	$Button_10.hide()
