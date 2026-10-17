extends Node2D

@onready var themed_timer: Node2D = $ThemedTimer

var buttons_pressed := 0
var scene_changing := false

func _ready() -> void:
	# Inicia o timer e aguarda ele terminar
	await themed_timer.start_timer(10.0)
	
	# Se o timer acabou e o jogador ainda não clicou nos 10 botões, ele perde
	if not scene_changing:
		scene_changing = true
		Global.lives -= 1
		Global.minigames_done -= 1
		get_tree().change_scene_to_file("res://title_screen.tscn")


func _process(delta: float) -> void:
	if scene_changing:
		return

	# Se clicou em todos os 10 botões a tempo, ganha e muda de cena antes do timer acabar
	if buttons_pressed >= 10:
		scene_changing = true
		if Global.minigames_done > 3:
			get_tree().change_scene_to_file("res://scenes/done_screen.tscn")
		else:
			get_tree().change_scene_to_file("res://title_screen.tscn")


func _on_button_1_pressed() -> void:
	if $Button_1.visible:
		buttons_pressed += 1
		$Button_1.hide()

func _on_button_2_pressed() -> void:
	if $Button_2.visible:
		buttons_pressed += 1
		$Button_2.hide()

func _on_button_3_pressed() -> void:
	if $Button_3.visible:
		buttons_pressed += 1
		$Button_3.hide()

func _on_button_4_pressed() -> void:
	if $Button_4.visible:
		buttons_pressed += 1
		$Button_4.hide()

func _on_button_5_pressed() -> void:
	if $Button_5.visible:
		buttons_pressed += 1
		$Button_5.hide()

func _on_button_6_pressed() -> void:
	if $Button_6.visible:
		buttons_pressed += 1
		$Button_6.hide()

func _on_button_7_pressed() -> void:
	if $Button_7.visible:
		buttons_pressed += 1
		$Button_7.hide()

func _on_button_8_pressed() -> void:
	if $Button_8.visible:
		buttons_pressed += 1
		$Button_8.hide()

func _on_button_9_pressed() -> void:
	if $Button_9.visible:
		buttons_pressed += 1
		$Button_9.hide()

func _on_button_10_pressed() -> void:
	if $Button_10.visible:
		buttons_pressed += 1
		$Button_10.hide()
