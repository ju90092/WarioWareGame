extends Node2D

const PROXIMA_CENA = "res://level_scene.tscn" # Ou para onde o jogo deve ir após a história de derrota

@onready var psique: Sprite2D = $Sprite2D # Ajuste se o nome do sprite do balde caído for diferente

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
		
	# Detecta o clique do mouse na tela para iniciar a conversa sobre o balde quebrado
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		jogo_iniciado = true
		_iniciar_dialogo_derrota()

func _iniciar_dialogo_derrota() -> void:
	# Insira aqui os textos da história de derrota (com o balde e a corda arrebentada)
	var falas_story3: Array[String] = [
		"Ups... Guess it was a failure?",
		"Anyways... We don't have time to cry about it. You need to go and catch those little (big) hearts on the floor! Pick all of them!!!"
	]
	
	# Inicia a sequência usando exatamente o mesmo gerenciador do seu projeto
	DialogueBox.start_dialogue_sequence(falas_story3)

func _on_dialogue_finished() -> void:
	# Quando o diálogo terminar, avança para a próxima cena (ou volta ao hub)
	get_tree().change_scene_to_file(PROXIMA_CENA)
