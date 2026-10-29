extends Node2D

@onready var self_area: Area2D = $Area2D
@onready var player_area: CharacterBody2D = $"../Player" # Ou o caminho correto para o player

var coletado: bool = false

func _process(_delta: float) -> void:
	if coletado:
		return
		
	# Procura o player na cena de forma segura
	var player = get_node_or_null("../Player")
	if not player:
		return
		
	# Se a área do coração encostar no player (ou na área dele)
	if $Area2D.overlaps_body(player) or (has_node("../Player/Area2D") and $Area2D.overlaps_area($"../Player/Area2D")):
		coletado = true
		
		# Informa o script principal do minigame que um coração foi pego
		var minigame = get_parent()
		if minigame and minigame.has_method("registrar_coleta"):
			minigame.registrar_coleta()
			
		queue_free() # Some com o coração
