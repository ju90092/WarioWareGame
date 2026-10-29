extends Node2D

@onready var garlic_container: HBoxContainer = $GarlicContainer
@onready var level: RichTextLabel = $Level
@onready var timer: RichTextLabel = $Timer

var time: float = 3.0
var transicao_em_andamento: bool = false

func _ready() -> void:
	time = 3.0
	transicao_em_andamento = false

func _process(delta: float) -> void:
	if transicao_em_andamento:
		return
		
	_atualizar_vidas_alhos()
	
	if time > 0.0:
		time -= delta
	else:
		_finalizar_transicao()
	
	if timer:
		timer.text = str(snapped(time, 0.1))
	if level:
		level.text = "Level " + str(Global.minigames_done)

func _atualizar_vidas_alhos() -> void:
	if not garlic_container:
		return
		
	var alhos = garlic_container.get_children()
	for i in range(alhos.size()):
		var alho_node = alhos[i] as CanvasItem
		if alho_node:
			if i < Global.lives:
				alho_node.show()
			else:
				alho_node.hide()

func _finalizar_transicao() -> void:
	transicao_em_andamento = true

	# 1. Se as vidas acabaram de vez -> Death Screen imediata
	if Global.lives <= 0:
		get_tree().change_scene_to_file("res://death_screen.tscn")
		return

	# 2. Se já concluiu os 3 minigames, avalia o final do jogo
	if Global.minigames_done > 3:
		_avaliar_resultado_final()
		return

	# 3. Direciona para o próximo minigame baseado no progresso atual
	if Global.minigames_done == 1:
		get_tree().change_scene_to_file("res://minigame_balde.tscn")
	elif Global.minigames_done == 2:
		get_tree().change_scene_to_file("res://minigame_1.tscn")
	elif Global.minigames_done == 3:
		get_tree().change_scene_to_file("res://minigame_2.tscn")
	else:
		# Reseta caso haja algum valor inesperado
		Global.lives = 5
		Global.minigames_done = 1
		Global.jogos_ganhos = 0
		Global.jogos_perdidos = 0
		get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

# 4. Função que decide qual tela de final exibir com base nas 4 regras atualizadas
func _avaliar_resultado_final() -> void:
	if Global.jogos_perdidos == 3:
		# Perder todos (3) = Death Screen
		get_tree().change_scene_to_file("res://death_screen.tscn")
	elif Global.jogos_ganhos == 3:
		# Ganhar todos (3) = Winner Screen
		get_tree().change_scene_to_file("res://winner_screen.tscn")
	elif Global.jogos_perdidos == 2:
		# Perder a maioria (2 perdidos) = Meia Derrota
		get_tree().change_scene_to_file("res://meia_derrota.tscn")
	elif Global.jogos_ganhos == 2:
		# Ganhar a maioria (2 ganhos) = Meia Vitória
		get_tree().change_scene_to_file("res://meia_vitoria.tscn")
	else:
		# Fallback de segurança para qualquer outra combinação atípica
		get_tree().change_scene_to_file("res://winner_screen.tscn")
