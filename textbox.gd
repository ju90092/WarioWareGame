extends CanvasLayer

signal dialogue_finished

enum State {
	READY,
	READING,
	FINISHED
}

const CHAR_RATE = 0.05

@onready var label: Label = $"TextboxContainer/MarginContainer/HBoxContainer/Text!"
@onready var textbox_container = $TextboxContainer
@onready var bg = $Container/BG if has_node("Container/BG") else null

var tween: Tween
var state: State
var current_lines: Array[String] = []
var current_line_index: int = 0
var _can_advance: bool = true

func _ready():
	_hide()
	state = State.READY

func _unhandled_input(event: InputEvent) -> void:
	if not textbox_container or not textbox_container.visible:
		return
		
	var is_click = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed
	var is_key = event.is_action_pressed("ui_select") or event.is_action_pressed("ui_accept")
	
	if is_click or is_key:
		if _can_advance:
			_handle_advance()
			get_viewport().set_input_as_handled()

func _handle_advance():
	match state:
		State.READING:
			_finish()
		State.FINISHED:
			_advance_or_close()

func _hide():
	label.text = ""
	label.visible_ratio = 0
	if bg:
		bg.visible = false
	if textbox_container:
		textbox_container.visible = false

func _show():
	if bg:
		bg.visible = true
	if textbox_container:
		textbox_container.visible = true
		
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.finished.connect(_finish)

func _finish():
	if tween and tween.is_running():
		tween.stop()
	label.visible_ratio = 1
	state = State.FINISHED

func _display_dialogue(lines: String):
	# Bloqueia temporariamente o avanço para não consumir o mesmo clique
	_can_advance = false
	state = State.READY
	label.text = lines
	_show()
	
	tween.tween_property(label, "visible_ratio", 1.0, len(lines) * CHAR_RATE)
	state = State.READING
	
	# Libera o avanço no próximo frame
	call_deferred("_enable_advance")

func _enable_advance():
	_can_advance = true

func start_dialogue_sequence(lines_array: Array[String]):
	if lines_array.is_empty():
		return
	current_lines = lines_array
	current_line_index = 0
	_display_dialogue(current_lines[current_line_index])

func _advance_or_close():
	current_line_index += 1
	if current_line_index < current_lines.size():
		_display_dialogue(current_lines[current_line_index])
	else:
		_hide()
		dialogue_finished.emit()
		state = State.READY
