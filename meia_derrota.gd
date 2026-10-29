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
		_iniciar_dialogo_meia_derrota()

func _iniciar_dialogo_meia_derrota() -> void:
	var falas_meia_derrota: Array[String] = [
		"Well... Good luck next time? I don't know what to say. At least, you still have one or two hearts, right? So, it is a half lose, then!"
	]
	
	DialogueBox.start_dialogue_sequence(falas_meia_derrota)

func _on_dialogue_finished() -> void:
	get_tree().change_scene_to_file(PROXIMA_CENA)
