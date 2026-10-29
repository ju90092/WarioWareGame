extends Node2D

const PROXIMA_CENA = "res://story_1.tscn" 

@onready var cenario: TextureRect = $TextureRect2
@onready var princesa_1: Sprite2D = $Sprite2D
@onready var princesa_2: Sprite2D = $Sprite2D1
@onready var princesa_3: Sprite2D = $Sprite2D2

# Novos elementos (3 e 4)
@onready var elemento_3: Sprite2D = $Sprite2D3
@onready var elemento_4: Sprite2D = $Sprite2D4

var linha_atual: int = 0

func _ready() -> void:
	if princesa_1: princesa_1.hide()
	if princesa_2: princesa_2.hide()
	if princesa_3: princesa_3.hide()
	if elemento_3: elemento_3.hide()
	if elemento_4: elemento_4.hide()

	if DialogueBox.has_signal("dialogue_finished"):
		DialogueBox.dialogue_finished.connect(_on_dialogue_finished)
		
	var falas_psique: Array[String] = [
		"Once upon a time... There were three beautiful princesses.",
		"Every man would easily fall in love with them. Their parents were happy because they knew their daughters wouldn't have to suffer alone in this world when they were gone.",
		"As the years passed, each sister found someone to love... Except the youngest one, Psyche."
	]
	DialogueBox.start_dialogue_sequence(falas_psique)

func _unhandled_input(event: InputEvent) -> void:
	var avanca_acao = event.is_pressed() and (
		(event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT) or
		(event is InputEventKey and (event.keycode == KEY_SPACE or event.keycode == KEY_ENTER))
	)
	
	if avanca_acao:
		linha_atual += 1
		
		# 1º Clique: Mostra as princesas
		if linha_atual == 1:
			if princesa_1: princesa_1.show()
			if princesa_2: princesa_2.show()
			if princesa_3: princesa_3.show()
			
		# 4º Clique: Mostra os elementos 3 e 4
		elif linha_atual == 4:
			if elemento_3: elemento_3.show()
			if elemento_4: elemento_4.show()

func _on_dialogue_finished() -> void:
	get_tree().change_scene_to_file(PROXIMA_CENA)
