extends AudioStreamPlayer2D

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	
	self.global_position = get_global_mouse_position()
	
	if $AudioStreamPlayer2D.playing == false:
		$AudioStreamPlayer2D.play()
	pass
	
