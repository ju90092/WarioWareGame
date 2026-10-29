extends Node2D

@export var tempo_limite: float = 10.0

@onready var themed_timer: Node2D = $ThemedTimer
@onready var label_tempo: Label = $CanvasLayer/LabelTempo # Ajuste o caminho se a sua label estiver em outro nó

var buttons_pressed := 0
var scene_changing := false
var minigame_ativo: bool = true
var tempo_restante: float = 0.0

func _ready() -> void:
	minigame_ativo = true
	scene_changing = false
	tempo_restante = tempo_limite
	
	# Inicia o temporizador visual/lógico
	await themed_timer.start_timer(tempo_limite)
	
	# Se o timer acabou e a cena ainda não mudou por vitória, conta como derrota por tempo
	if not scene_changing and minigame_ativo:
		_derrota_por_tempo()

func _process(delta: float) -> void:
	if scene_changing or not minigame_ativo:
		return

	# Atualiza o tempo decrescente para exibir na Label
	if tempo_restante > 0.0:
		tempo_restante -= delta
		if label_tempo:
			label_tempo.text = "Tempo: " + str(snapped(tempo_restante, 0.1)) + "s"

	# Condição de vitória (pressionou os 10 botões)
	if buttons_pressed >= 10:
		_vitoria()

func _vitoria() -> void:
	if scene_changing or not minigame_ativo:
		return
		
	scene_changing = true
	minigame_ativo = false
	print("[MINIGAME 2] Vitória!")
	
	Global.jogos_ganhos += 1
	Global.minigames_done += 1
	get_tree().change_scene_to_file("res://level_scene.tscn")

func _derrota_por_tempo() -> void:
	if scene_changing or not minigame_ativo:
		return
		
	scene_changing = true
	minigame_ativo = false
	print("[MINIGAME 2] Derrota por tempo! -1 vida.")
	
	Global.lives -= 1
	Global.jogos_perdidos += 1
	Global.minigames_done += 1
	
	if Global.lives <= 0:
		get_tree().change_scene_to_file("res://death_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://level_scene.tscn")

# Funções dos botões
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
