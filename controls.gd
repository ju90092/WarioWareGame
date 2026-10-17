extends Button

@export var scene_path: String
func on_back_button_pressed() -> void:
	var _change_scene: Error = get_tree().change_scene_to_file(scene_path)
	
	
func on_mouse_exited() -> void:
	modulate.a =1.0
	
	
func on_mouse_entered() -> void:
	modulate.a = 0.5
	
