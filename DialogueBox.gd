extends CanvasLayer

signal dialogue_finished

enum State {
	READY,
	READING,
	FINISHED
}

const CHAR_RATE = 0.05

@onready var label = $Container/TextContainer/Panel/Label
@onready var bg = $Container/BG
var tween: Tween
var state: State
var current_lines: Array[String] = []
var current_line_index: int = 0

func _ready():
	_hide()
	state = State.READY

func _process(delta):
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
	bg.visible = false

func _show():
	bg.visible = true
	tween = create_tween()
	tween.finished.connect(_finish)

func _finish():
	tween.stop()
	label.visible_ratio = 1
	state = State.FINISHED

# Função para exibir uma frase isolada
func _display_dialogue(lines):
	if state != State.READY:
		return
	label.text = lines
	_show()
	tween.tween_property(label, "visible_ratio", 1, len(lines) * CHAR_RATE)
	state = State.READING

# Função para iniciar uma sequência inteira de diálogos (separada corretamente!)
func start_dialogue_sequence(lines_array: Array[String]):
	if state != State.READY:
		return
	current_lines = lines_array
	current_line_index = 0
	_display_dialogue(current_lines[current_line_index])

# Função para avançar para a próxima fala ou fechar a caixa
func _advance_or_close():
	current_line_index += 1
	if current_line_index < current_lines.size():
		_display_dialogue(current_lines[current_line_index])
	else:
		_hide()
		dialogue_finished.emit()
		state = State.READY
