extends Node2D

const PROXIMA_CENA = "res://minigame_1.tscn" 

func _ready() -> void:
	if DialogueBox.has_signal("dialogue_finished"):
		DialogueBox.dialogue_finished.connect(_on_dialogue_finished)
		
	var falas_psique: Array[String] = [
		"Once upon a time... There were three beautiful princesses. Every man would easily fall in love with them. Their parents were happy because they knew their daughters wouldn't have to suffer alone in this world when they were gone.",
		"As the years passed, each sister found someone to love... Except the youngest one, Psyche. It wasn't because of any flaw of her own. In fact, the girl was too much for any interested man to actually try something.",
		"She was the most beautiful woman in the entire kingdom. So beautiful that people started to treat her like a goddess, nurturing a kind of platonic love."
	]
	DialogueBox.start_dialogue_sequence(falas_psique)

func _on_dialogue_finished() -> void:
	get_tree().change_scene_to_file(PROXIMA_CENA)
