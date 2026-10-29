extends Node2D

const PROXIMA_CENA = "res://scenes/title_screen.tscn" # Ou para onde deseja ir após o final (ex: menu principal)

@onready var psique: Sprite2D = $Sprite2D # Ajuste se o nome do sprite for diferente

var jogo_iniciado: bool = false

func _ready() -> void:
	if psique:
		psique.show()

	if DialogueBox.has_signal("dialogue_finished"):
		DialogueBox.dialogue_finished.connect(_on_dialogue_finished)

func _unhandled_input(event: InputEvent) -> void:
	if jogo_iniciado:
		return
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		jogo_iniciado = true
		_iniciar_dialogo_meia_vitoria()

func _iniciar_dialogo_meia_vitoria() -> void:
	var falas_meia_vitoria: Array[String] = [
		"Hmm... Good job. It wasn't perfect, so I'll call it half win"
	]
	
	DialogueBox.start_dialogue_sequence(falas_meia_vitoria)

func _on_dialogue_finished() -> void:
	get_tree().change_scene_to_file(PROXIMA_CENA)
