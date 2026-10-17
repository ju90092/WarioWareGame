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

func _ready():
	_hide()
	state = State.READY

func _process(_delta):
	match state:
		State.READING:
			if Input.is_action_just_pressed("ui_select"):
				_finish()
		State.FINISHED:
			if Input.is_action_just_pressed("ui_select"):
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
	# Se já estivemos em FINISHED e formos para a próxima linha, resetamos para READY primeiro
	state = State.READY
	label.text = lines
	_show()
	tween.tween_property(label, "visible_ratio", 1.0, len(lines) * CHAR_RATE)
	state = State.READING

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
