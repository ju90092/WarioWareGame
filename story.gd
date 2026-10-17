extends Node2D

func _ready() -> void:
	var falas_psique: Array[String] = [
		"O vento de Zéfiro está soprando forte...",
		"Preciso me concentrar na queda!",
		"Lá embaixo estão os desafios."
	]
	DialogueBox.start_dialogue_sequence(falas_psique)
