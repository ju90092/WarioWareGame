extends Node2D

const PROXIMA_CENA = "res://scenes/title_screen.tscn" # Ou para onde o jogo deve ir após a winner screen (ex: menu principal)

@onready var psique: Sprite2D = $Sprite2D # Ajuste se o nome do sprite principal da vitória for diferente

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
		
	# Detecta o clique do mouse na tela para iniciar a fala da winner screen
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		jogo_iniciado = true
		_iniciar_dialogo_winner()

func _iniciar_dialogo_winner() -> void:
	# Textos da winner screen comemorando a vitória perfeita do jogador
	var falas_winner: Array[String] = [
		"Woah... You actually did it?",
		"Congratulations!",
		"You don't have any other challenge for now, but maybe in the future...?"
	]
	
	# Inicia a sequência usando o gerenciador de diálogos do projeto
	DialogueBox.start_dialogue_sequence(falas_winner)

func _on_dialogue_finished() -> void:
	# Quando o diálogo terminar, retorna ao menu principal (ou tela de título)
	get_tree().change_scene_to_file(PROXIMA_CENA)
