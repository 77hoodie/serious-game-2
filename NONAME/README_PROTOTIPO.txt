PROTOTIPO - Escape Room + RPG educativo

Controles:
- WASD: mover o jogador na sala
- E: interagir com painel, tutor ou porta
- 1/2/3: responder alternativas no painel e no combate
- H: atalho antigo de debug, nao usado como selecao principal de dificuldade
- ENTER: finalizar tela final
- ESC: sair do painel

Fluxo implementado:
1. rm_lab_01: sala com jogador como bola vermelha, tutor roxo, painel azul e porta.
2. O painel ensina f(x,y) = x^2 + y^2 e usa dicas progressivas.
3. A porta abre quando o jogador acerta f(1,2) = 5.
4. rm_battle_01: combate RPG por turnos contra o Monitor Sem Rosto.
5. O comportamento da batalha muda conforme a dificuldade escolhida no menu.
6. rm_end: tela final do prototipo.

Todos os sprites sao placeholders desenhados por codigo nos eventos Draw.


Correção 1: adicionados campos inheritedItemId nas instâncias das rooms para compatibilidade com o leitor JSON do GameMaker 2024.


Sprites do jogador integradas
-----------------------------
O obj_player agora usa as sprites animadas:
- sprite_player_down
- sprite_player_up
- sprite_player_left
- sprite_player_right

A escala visual do personagem fica em objects/obj_player/Create_0.gml, na variável player_sprite_scale.
Se o personagem parecer grande ou pequeno na room, ajuste esse valor.

Atualizacao de sprites de batalha
- A sprite sprite_player_battle foi integrada ao controlador de combate.
- Ela e usada como visual padrao do jogador em todas as batalhas.
- As sprites direcionais continuam sendo usadas na exploracao.


ATUALIZACAO - MENU INICIAL
-------------------------
O prototipo agora inicia em rm_title, com a tela de titulo Midnight School.
Pressione ENTER para ir ao menu de dificuldade.

Dificuldades:
- Modo Aprendizado: recomendado para aprender ou revisar os conceitos. Erros geram dicas e explicacoes progressivas.
- Modo Dificil: recomendado para jogadores com mais familiaridade. Erros em combate podem causar perda de HP.

Rooms adicionadas:
- rm_title
- rm_difficulty

Objetos adicionados:
- obj_title_controller
- obj_difficulty_controller

A dificuldade escolhida fica salva em global.difficulty_mode e global.hard_mode.

Atualizacao narrativa e HUD:
- Apos escolher a dificuldade, o jogo passa por uma tela de historia em primeira pessoa.
- ENTER avanca a historia e ESC pula a introducao.
- Ao entrar na primeira sala, o tutor inicia uma conversa automaticamente antes do jogador poder se mover.
- O painel da sala passou a ser tratado como quadro.
- A dificuldade escolhida no menu continua sendo preservada para o combate.

ATUALIZACAO - DIALOGOS E HUD
- A caixa de dialogo da sala agora usa retratos para as falas do protagonista e do tutor.
- Falas que começam com "Eu:" exibem sprite_player_dialogue.
- Falas que começam com "Tutor:" exibem sprite_tutor_dialogue.
- O quadro agora usa uma caixa propria maior, centralizada, para mostrar pergunta e alternativas sem cortar a parte inferior da tela.
- A caixa de combate tambem foi padronizada para manter comandos e texto dentro da area visivel.

IDEIA INICIAL DE MAPA
- Entrada / sala inicial: primeiro contato com o tutor e funcoes de varias variaveis.
- Corredor principal: area de ligacao entre salas.
- Sala de derivadas parciais: puzzles que mudam apenas x ou apenas y.
- Cidade inclinada ou patio distorcido: area do gradiente.
- Casa dos pontos criticos: area de maximos, minimos e ponto de sela.
- Arquivo / sala final: revisao integrada dos quatro conceitos.

Atualizacao de HUD - overlay de dialogos e quadro
-------------------------------------------------
- Dialogos da sala agora escurecem a room antes de desenhar os retratos e a caixa de texto.
- O quadro tambem escurece o fundo para funcionar como uma tela de interacao propria.
- O controlador global obj_game usa depth negativo para garantir que a UI fique por cima dos objetos da sala.
- A interface de batalha continua sendo desenhada pelo obj_battle_controller.


Atualizacao de interface:
- Dialogos e quadro pausam o movimento do player enquanto estao abertos.
- ENTER fecha dialogos livres e tambem sai da interface do quadro.
- ESC continua funcionando para sair do quadro.

Atualizacao de mapa e menu
--------------------------
- sprite_school_menu foi colocada como imagem de fundo da tela inicial.
- sprite_map_classroom_01 foi colocada como fundo da primeira sala.
- Os objetos de interacao do quadro e da porta agora aparecem como marcadores discretos sobre o mapa.
- A colisao da sala inicial esta definida por retangulos invisiveis em global.lab_01_collision_rects, dentro de obj_game/Create_0.gml.
- Para visualizar as colisoes durante ajuste, altere global.debug_collisions para true em obj_game/Create_0.gml.
- A imagem do mapa e apenas visual; movimentacao, interacoes, porta e quadro continuam sendo controlados por objetos do GameMaker.


FIX MAPA DA SALA
- O mapa da sala agora e desenhado pelo obj_room_background com draw_sprite_stretched.
- A Background Layer da rm_lab_01 foi desativada para evitar que cubra o mapa em algumas versoes do GameMaker.
- Se precisar ajustar ordem visual, altere depth no Create do obj_room_background.

## Atualizacao: batalha padronizada com Monitor Sem Rosto

A primeira batalha agora usa o Monitor Sem Rosto como inimigo inicial.

Sprites usadas:
- `sprite_msr_battle`: pose do Monitor Sem Rosto na batalha;
- `sprite_msr_dialogue`: retrato do Monitor Sem Rosto em dialogos;
- `sprite_player_battle`: pose do jogador na batalha;
- `sprite_player_dialogue`: retrato do jogador em dialogos.

Fluxo atual da batalha:
1. Ao entrar na room de batalha, acontece um dialogo curto com o Monitor Sem Rosto.
2. Depois do dialogo, o combate entra no menu de acoes.
3. O jogador escolhe uma acao por turno.
4. Depois da acao do jogador, o turno passa para o inimigo.
5. O combate volta ao jogador se nenhum personagem for derrotado.

Acoes atuais:
- Atacar: abre uma pergunta matematica e causa dano se a resposta estiver correta.
- Revisar: mostra uma revisao do conceito da sala.
- Dica: mostra uma pista direta no Modo Aprendizado; fica indisponivel no Modo Dificil.
- Item: abre a mochila, mas ainda nao ha itens nesta primeira batalha.

## Atualizacao: regras de batalha por dificuldade

Modo Aprendizado:
- inimigo com menos HP;
- dano inimigo reduzido;
- perguntas mais diretas;
- dicas mais claras;
- resposta errada mostra uma explicacao adicional;
- a acao Dica fica disponivel.

Modo Dificil:
- inimigo com mais HP;
- dano inimigo maior;
- perguntas mais longas ou com mais termos;
- a acao Dica fica indisponivel;
- a acao Revisar mostra apenas uma revisao breve.

As perguntas agora sao sorteadas no inicio da batalha a partir de dois bancos separados:
- `question_bank_learning`
- `question_bank_hard`

Esses bancos ficam em `objects/obj_battle_controller/Create_0.gml` e podem ser expandidos com novas perguntas futuramente.

A interface tambem foi ajustada:
- dialogos reais da batalha escurecem o fundo;
- falas do Monitor Sem Rosto usam `sprite_msr_dialogue` apenas em dialogos;
- acoes do inimigo nao exibem retrato de dialogo;
- mensagens de acao continuam aparecendo na caixa inferior sem retrato.


Atualizacao de combate:
- O Monitor Sem Rosto usa origem baixo-central para aparecer corretamente na batalha.
- As perguntas sao sorteadas sempre que o jogador usa Atacar.
- No Modo Aprendizado, a opcao Dica prepara uma pergunta e da uma orientacao clara antes do proximo ataque.
- No Modo Dificil, dicas seguem indisponiveis e o inimigo tem mais HP/dano.
- O quadro da primeira sala agora exibe anotacoes uteis junto da questao.
