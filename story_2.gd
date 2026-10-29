extends Node2D

const PROXIMA_CENA = "res://level_scene.tscn" # Retorna para o fluxo de níveis para ir ao minigame de coletar os corações

@onready var psique: Sprite2D = $Sprite2D # Ajuste se o nome do sprite da vitória for diferente

var jogo_iniciado: bool = false

func _ready() -> void:
	if psique:
		psique.show()

	# Conecta o sinal do DialogueBox para saber quando a fala acabar
	if DialogueBox.has_signal("dialogue_finished"):
		DialogueBox.dialogue_finished.connect(_on_dialogue_finished)

func _unhandled_input(event: InputEvent) -> void:
	# Evita cliques múltiplos enquanto o diálogo já está rodando
	if jogo_iniciado:
		return
		
	# Detecta o clique do mouse na tela para iniciar a conversa de vitória
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		jogo_iniciado = true
		_iniciar_dialogo_vitoria()

func _iniciar_dialogo_vitoria() -> void:
	# Textos da história de vitória (com o balde salvo e subido com sucesso)
	var falas_story2: Array[String] = [
		"Yey, you did it!",
		"But we don't have any more time to lose. You need to go and catch those little (big) hearts on the floor! Pick all of them!!!"
	]
	
	# Inicia a sequência usando o gerenciador de diálogos do projeto
	DialogueBox.start_dialogue_sequence(falas_story2)

func _on_dialogue_finished() -> void:
	# Quando o diálogo terminar, avança de volta para a level_scene (que chamará o próximo minigame)
	get_tree().change_scene_to_file(PROXIMA_CENA)
