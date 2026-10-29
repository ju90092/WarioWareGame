extends Node

var lives: int = 5
var minigames_done: int = 1

# Variáveis para rastrear o placar e definir o final correto
var jogos_ganhos: int = 0
var jogos_perdidos: int = 0

func registrar_vitoria(proximo_nivel: int) -> void:
	jogos_ganhos += 1
	print("[GLOBAL] Vitória registrada! Total de ganhos: ", jogos_ganhos)
	minigames_done = proximo_nivel
	get_tree().change_scene_to_file("res://level_scene.tscn")

func registrar_derrota(proximo_nivel: int) -> void:
	lives -= 1
	jogos_perdidos += 1
	print("[GLOBAL] Derrota registrada! -1 vida. Vidas restantes: ", lives, " | Total de perdidos: ", jogos_perdidos)
	minigames_done = proximo_nivel
	get_tree().change_scene_to_file("res://level_scene.tscn")

# Função opcional para resetar tudo quando voltar para a tela de título
func reiniciar_jogo() -> void:
	lives = 5
	minigames_done = 1
	jogos_ganhos = 0
	jogos_perdidos = 0
