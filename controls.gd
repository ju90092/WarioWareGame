extends Button

@export_file("*.tscn") var scene_path: String = "res://title_screen.tscn"

func _pressed() -> void:
	if scene_path != "":
		get_tree().change_scene_to_file(scene_path)
	else:
		push_warning("Backbutton: Nenhuma cena configurada em 'scene_path' no Inspector!")

func _mouse_enter() -> void:
	modulate.a = 0.5

func _mouse_exit() -> void:
	modulate.a = 1.0
