extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const SPEED := 400
const ACCELERATION := 800
const FRICTION := 1000
const JUMP_VELOCITY := -550
const GRAVITY := 1000

func _process(delta):
	# Gravidade
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Pulo curto ao soltar o botão
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4

	# Pulo normal
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Movimentação Horizontal
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else: 
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
	# --- GERENCIAMENTO DE ANIMAÇÕES CORRIGIDO ---
	if not is_on_floor():
		# Se estiver no ar, prioriza as animações de pulo/queda
		if direction < 0:
			animated_sprite.play("jump_left")
		elif direction > 0:
			animated_sprite.play("jump_right")
		else:
			animated_sprite.play("jump") # Pulo reto ou padrão
	else:
		# Se estiver no chão, gerencia caminhar ou parado
		if direction < 0:
			animated_sprite.play("walk_left")
		elif direction > 0:
			animated_sprite.play("walk_right")
		else:
			animated_sprite.play("Idle")

	move_and_slide()
