extends Node2D

func _find_timer_label() -> RichTextLabel:
		for child in get_children():
				if child is RichTextLabel:
						return child 
		return null

@onready var timer_label: RichTextLabel = _find_timer_label()
@onready var warning_sound: AudioStreamPlayer = $WarningSound

var time_left : float = 0.0
var is_running: bool = false
var last_second_played: int = -1

func start_timer(duration: float) -> void:
	time_left = duration
	is_running = true
	last_second_played = -1

	while time_left > 0.0:
		await get_tree().create_timer(0.1).timeout
		time_left -= 0.1
		
		var current_second = int(ceil(time_left))
		
		if time_left <= 3.0 and current_second != last_second_played:
			last_second_played = current_second
			if warning_sound:
				warning_sound.stop()
				warning_sound.play()
		
		if time_left < 0:
			time_left = 0.0

	is_running = false

func _process(delta: float) -> void:
	if timer_label != null:
		timer_label.text = str(snapped(time_left, 0.1))
	
