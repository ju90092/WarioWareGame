extends Node2D

const PROXIMA_CENA = "res://level_scene.tscn" # Ou o caminho para o próximo minigame / level scene

@onready var psique: Sprite2D = $Sprite2D # Ajuste se o nome do sprite principal for diferente

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
		
	# Detecta o clique do mouse na tela para iniciar a fala da story_4
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		jogo_iniciado = true
		_iniciar_dialogo_story4()

func _iniciar_dialogo_story4() -> void:
	# Textos da story_4 com a urgência dos corações e do relógio
	var falas_story4: Array[String] = [
		"Alright... One more thing and I'll let you go...",
		"Click on every tiny heart to see what happens!",
		"Don't forget about the time...",
		"Tick tack tick tack..."
	]
	
	# Inicia a sequência usando o gerenciador de diálogos do projeto
	DialogueBox.start_dialogue_sequence(falas_story4)

func _on_dialogue_finished() -> void:
	# Quando o diálogo terminar, avança de volta para a level_scene (que chamará o próximo minigame ou etapa)
	get_tree().change_scene_to_file(PROXIMA_CENA)
