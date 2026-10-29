extends Node2D

const PROXIMA_CENA = "res://minigame_balde.tscn"

# Referência para a Psique ou elementos visuais desta cena (ajuste o nome se necessário)
@onready var psique: Sprite2D = $Sprite2D

func _ready() -> void:
	if psique:
		psique.show()

	if DialogueBox.has_signal("dialogue_finished"):
		DialogueBox.dialogue_finished.connect(_on_dialogue_finished)
		
	# Falas corrigidas e polidas para o inglês correto
	var falas_story1: Array[String] = [
		"It wasn't because of any flaw of her own. In fact, the girl was too much for any interested man to actually approach her.",
		"She was the most beautiful woman in the entire kingdom. So beautiful that people started to treat her like a goddess, nurturing a kind of platonic love.",
		"That's why the bucket beneath her tower is heavy with presents. Can you help her bring it to the top of the tower? Just take care, the rope may be too old for that much stuff!"
	]
	DialogueBox.start_dialogue_sequence(falas_story1)

func _on_dialogue_finished() -> void:
	# Quando essa sequência de diálogos terminar, o jogo vai direto para o minigame do balde
	get_tree().change_scene_to_file(PROXIMA_CENA)

#Começa a cena com a animação da mais velha olhando pra baixo, vendo 
#pretendente, suspirando de amor e indo embora com ele. O mesmo com
#a do meio, até que chega a vez da Psique e só tem presentes embaixo
#da janela dela, sem ninguém por perto. (Ela pode ter um "baldinho"
#onde as pessoas colocam o presente e ela só precisa puxar para
#que os presentes cheguem até o quarto dela, mas esse baldinho só
#funciona a partir da "segunda" vida dela.) Essa cena pode ser antes ou
#depois do minigame 1              Na verdade, o minigame 1 pode ser
#"puxe o balde" clicando até ele chegar ao jogador. Em cada vida, o 
#item obtido pode ser diferente ou ser o mesmo, mas com um novo ponto
#de vista adquirido.
#Aí tem duas opções: 1-Ela pula da janela e acaba caindo em cima de 
#uma moita, em segurança. 2- Ela fica lá, parada, por muito tempo, até
#que várias estrelas cadentes, cometas e meteoros caem durante a noite,
#e ela, vendo isso, faz o desejo de poder encontrar alguém que a ame,
#da mesma forma que as irmãs também conseguiram. Ela dorme e, no dia 
#seguinte, os pais dela dizem que ela vai se casar com um monstro 
#porque o oráculo passou essa mensagem. Aí, vamos para o minigame 2:
#chegar sã e salva no castelo de Eros com o vento Zéfiro, jogo de plataforma
#onde tem que pular nas nuvens
#talvez uma música (que só vai ser liberada em outras tentativas, como umas outras coisas. Talvez, todas as escolhas só sejam liberadas depois de certa quantidade de "mortes" 
#depois da primeira morte. Pra fazer isso, seria bom ter uma mecânica
#de salvar o jogo. 
#Os próximos minigames seriam sobre a dinâmica do casal e a vida solitária
#de Psique durante o dia ("jogue truco contra a parede para passar o tempo"),
#até que as irmãs vem visitar e começam a "encher de minhoca" a cabeça de
#Psique (outro minigame), não necessariamente por mal, não necessariamente por bem.
#Quando elas vão embora, começa um minigame para a Psique encontrar velas e
#uma forma de acendê-las com os itens que tem, e ela guarda tudo em um espaço
#escondidinho do quarto para poder ver o rosto do marido. Quando consegue, entretanto, 
#acaba tão embasbacada pela beleza dele que o queima sem querer, fazendo com
#que acorde. Pode ter um minigame nessa parte também, mas você falha nele 
#não importa o que aconteça, e o coração fica partido no jogo até que Eros salve
#Psique no desafio final. Os desafios também serão minigames (provavelmente, os principais da demo,
#que será mais o estilo WarioWare Game), e o de clique é o da ovelha (preciso fazer uma
#parte pra textura do mato mudar quando você clicar nele, para que a lã que parece de ouro desapareça). 
#O jogo poderia ter um esquema de conquistas, mas sem ranking porque não
#é a vibe do jogo
#Na versão demo, vou colocar: 1- Início da história
