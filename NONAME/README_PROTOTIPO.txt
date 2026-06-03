PROTOTIPO - Escape Room + RPG educativo

Controles:
- WASD: mover o jogador na sala
- E: interagir com painel, tutor ou porta
- 1/2/3: responder alternativas no painel e no combate
- H: alternar modo aprendizado/dificil
- ENTER: finalizar tela final
- ESC: sair do painel

Fluxo implementado:
1. rm_lab_01: sala com jogador como bola vermelha, tutor roxo, painel azul e porta.
2. O painel ensina f(x,y) = x^2 + y^2 e usa dicas progressivas.
3. A porta abre quando o jogador acerta f(1,2) = 5.
4. rm_battle_01: combate RPG por turnos contra Dr. Dominio.
5. Errar nao pune no modo aprendizado; no modo dificil, o erro causa dano leve.
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
