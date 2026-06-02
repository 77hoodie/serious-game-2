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
