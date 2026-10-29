extends Node2D

@export var forca_clique: float = 4.5       
@export var velocidade_queda: float = 14.0   
@export var tempo_limite: float = 10.0

var progresso: float = 0.0
var tempo_restante: float = 0.0
var minigame_ativo: bool = true

@onready var barra_progresso: ProgressBar = $CanvasLayer/BarraProgresso
@onready var label_tempo: Label = $CanvasLayer/LabelTempo
@onready var label_instrucao: Label = $CanvasLayer/LabelInstrucao
@onready var balde: Sprite2D = $Balde

var y_baixo: float = 500.0
var y_cima: float = -60.0

func _ready() -> void:
	progresso = 0.0
	tempo_restante = tempo_limite
	minigame_ativo = true
	
	if barra_progresso:
		barra_progresso.max_value = 100.0
		barra_progresso.value = 0
	if balde:
		balde.position.y = y_baixo
	if label_instrucao:
		label_instrucao.text = "CLIQUE REPETIDAMENTE!"

func _process(delta: float) -> void:
	if not minigame_ativo:
		return
		
	tempo_restante -= delta
	if label_tempo:
		label_tempo.text = "Tempo: " + str(snapped(tempo_restante, 0.1)) + "s"
		
	if tempo_restante <= 0.0 and minigame_ativo:
		_falhar_minigogo()
		return
		
	if progresso > 0:
		progresso -= velocidade_queda * delta
		progresso = max(progresso, 0.0)
		_atualizar_interface()

func _unhandled_input(event: InputEvent) -> void:
	if not minigame_ativo:
		return
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		progresso += forca_clique
		progresso = min(progresso, 100.0)
		_atualizar_interface()
		
		if progresso >= 100.0 and minigame_ativo:
			_vencer_minigogo()

func _atualizar_interface() -> void:
	if barra_progresso:
		barra_progresso.value = progresso
	if balde:
		var porcentagem = progresso / 100.0
		balde.position.y = lerp(y_baixo, y_cima, porcentagem)

func _vencer_minigogo() -> void:
	if not minigame_ativo:
		return
	minigame_ativo = false
	
	Global.jogos_ganhos += 1
	Global.minigames_done += 1
	
	# Vai para a história de vitória (story_2) de forma segura
	get_tree().call_deferred("change_scene_to_file", "res://story_2.tscn")

func _falhar_minigogo() -> void:
	if not minigame_ativo:
		return
	minigame_ativo = false
	
	Global.lives -= 1
	Global.jogos_perdidos += 1
	Global.minigames_done += 1
	
	# Se as vidas acabarem, vai para a tela de game over. Senão, vai para a história de derrota (story_3)
	if Global.lives <= 0:
		get_tree().call_deferred("change_scene_to_file", "res://death_screen.tscn")
	else:
		get_tree().call_deferred("change_scene_to_file", "res://story_3.tscn")
