extends Node2D

@export var tempo_limite: float = 10.0

var minigame_ativo: bool = true
var tempo_restante: float = 0.0
var coracoes_restantes: int = 6

@onready var label_tempo: Label = $CanvasLayer/LabelTempo

func _ready() -> void:
	tempo_restante = tempo_limite
	minigame_ativo = true
	print("[MINIGAME 1] Iniciado.")

func registrar_coleta() -> void:
	if not minigame_ativo:
		return
		
	coracoes_restantes -= 1
	print("[MINIGAME 1] Coração coletado! Faltam: ", coracoes_restantes)
	
	if coracoes_restantes <= 0:
		minigame_ativo = false
		print("[MINIGAME 1] Vitória!")
		
		# Registra vitória no placar global
		Global.jogos_ganhos += 1
		Global.minigames_done += 1
		
		call_deferred("_mudar_para_story4")

func _physics_process(delta: float) -> void:
	if not minigame_ativo:
		return
		
	tempo_restante -= delta
	if label_tempo:
		label_tempo.text = "Tempo: " + str(snapped(tempo_restante, 0.1)) + "s"
		
	if tempo_restante <= 0.0:
		minigame_ativo = false
		print("[MINIGAME 1] Tempo esgotado! -1 vida.")
		
		# Registra derrota e perda de vida
		Global.lives -= 1
		Global.jogos_perdidos += 1
		Global.minigames_done += 1
		
		# Se as vidas acabarem totalmente, vai para o Game Over. Senão, vai para a story_4
		if Global.lives <= 0:
			call_deferred("_mudar_para_game_over")
		else:
			call_deferred("_mudar_para_story4")

func _mudar_para_story4() -> void:
	# Sempre vai para a story_4 após o minigame 1 (seja vitória ou derrota)
	get_tree().change_scene_to_file("res://story_4.tscn")

func _mudar_para_game_over() -> void:
	get_tree().change_scene_to_file("res://death_screen.tscn")
