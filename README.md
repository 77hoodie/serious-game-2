# Midnight School — Serious Game Multivariável

**Midnight School** é um serious game digital feito em **GameMaker** para a disciplina **Resolução de Problemas Multivariáveis**. O projeto combina exploração top-down, escape room, puzzles matemáticos, tutoriais contextualizados e batalhas em turnos no estilo JRPG para ensinar e reforçar conteúdos de cálculo multivariável.

> Nome interno do projeto GameMaker: `NONAME`  
> Arquivo principal: `NONAME/NONAME.yyp`  
> Engine: GameMaker / GML  
> Status: finalizado

---

## 1. Objetivo do projeto

O objetivo é transformar os principais tópicos de funções de várias variáveis em uma experiência jogável, com foco em aprendizagem e não apenas em acerto/erro. O jogador precisa entender as regras matemáticas de cada sala para avançar e depois reforça o mesmo conceito em combate.

A documentação e a implementação foram organizadas para responder diretamente ao que a lauda pede:

| Exigência da lauda | Como o jogo atende |
| --- | --- |
| Jogo sério digital ou lúdico | Implementação digital em GameMaker. |
| Funções de várias variáveis | Primeira fase e batalha contra o Monitor Sem Rosto. |
| Derivadas parciais | Segunda fase e batalha contra a Aluna da Janela. |
| Vetor gradiente | Terceira fase e batalha contra o Cartógrafo. |
| Máximos e mínimos | Quarta fase e batalha contra Isiaha, com ponto crítico e Hessiana. |
| Coordenadas cartesianas | Todos os desafios usam funções do tipo `f(x,y)`, pares ordenados, derivadas parciais, gradiente em `(df/dx, df/dy)` e matrizes Hessianas. |
| Objetivos educacionais por fase/mecânica | Cada sala apresenta o conceito em um puzzle; a batalha da área revisa e aplica o mesmo conteúdo. |
| Feedback educativo | Erros geram dicas progressivas, explicações do tutor ou feedback matemático antes de nova tentativa. |
| Teste com público externo | Ainda deve ser realizado e documentado antes da entrega final. |
| Documentação técnica | Este README explica como rodar, estrutura, mecânicas e relação matemática de cada fase. |

---

## 2. Público-alvo e justificativa do formato

O jogo foi pensado para estudantes que estão aprendendo ou revisando cálculo multivariável, especialmente os conteúdos de funções de duas variáveis, derivadas parciais, gradiente e classificação de pontos críticos.

A escolha por um jogo digital top-down com combate em turnos permite:

- dividir os conceitos em fases curtas e progressivas;
- usar salas como espaços de explicação e descoberta;
- usar batalhas como reforço, sem separar a matemática da jogabilidade;
- oferecer feedback imediato quando o jogador erra;
- comparar um modo de aprendizagem com um modo de desafio.

---

## 3. Narrativa e contexto

O protagonista fica até tarde estudando cálculo multivariável no laboratório. No computador da sala, encontra um projeto chamado **Midnight School**. Ao executá-lo, a tela fica preta e ele acorda em uma versão distorcida da escola/faculdade, organizada como um RPG antigo.

As salas parecem conhecidas, mas funcionam por regras matemáticas: quadros travam portas, mapas respondem a vetores, pedestais exigem classificação de pontos e personagens aparecem como obstáculos conceituais. A saída depende de entender essas regras.

O tom é de JRPG estranho e fechado, com atmosfera leve de mistério. A matemática não aparece como paródia: ela é a regra interna do mundo.

---

## 4. Como executar

1. Extraia o ZIP do projeto.
2. Abra o **GameMaker**.
3. No GameMaker, abra o arquivo:

   ```text
   NONAME/NONAME.yyp
   ```

4. Execute pelo botão **Run/Play** da IDE.
5. A primeira room do projeto é `rm_title`, que leva ao menu de dificuldade.

Observações:

- O projeto foi salvo com metadados de IDE `2026.0.0.16`.
- O ZIP contém o código-fonte e os assets do projeto. Caso a entrega exija executável, exporte uma build Windows pelo GameMaker.
- O nome exibido na tela é **Midnight School**, mesmo que o nome interno do projeto ainda seja `NONAME`.

---

## 5. Controles

### Exploração e menus

| Tecla | Ação |
| --- | --- |
| `W`, `A`, `S`, `D` | Movimentar o personagem durante a exploração. |
| `E` | Interagir com tutor, quadro, mesa, pedestal, porta ou Booly. |
| `ENTER` ou `SPACE` | Confirmar, avançar diálogos e passar telas. |
| `ESC` | Cancelar, sair de telas ou pular a introdução narrativa. |
| `M` | Abrir/fechar o menu do jogador nas salas de exploração. |
| `A`/`D` | Alternar abas do menu entre **Itens** e **Caderno**. |
| `W`/`S` | Trocar páginas do caderno quando a aba Caderno está aberta. |

### Puzzles e batalhas

| Tecla | Ação |
| --- | --- |
| `1`, `2`, `3` | Responder alternativas de puzzles e perguntas de combate. |
| `1`, `2`, `3`, `4` | Selecionar ações de batalha: Atacar, Revisar, Dica, Item. |
| Setas ou `W`/`S` | Navegar nos menus de dificuldade, batalha e derrota. |

`H` era um atalho antigo/debug para dificuldade e não é mais a forma principal de seleção. A dificuldade agora é escolhida na room `rm_difficulty`.

---

## 6. Fluxo jogável atual

```text
rm_title
  -> rm_difficulty
  -> rm_story
  -> rm_lab_01
  -> rm_battle_01
  -> rm_lab_02
  -> rm_battle_02
  -> rm_lab_03
  -> rm_battle_03
  -> rm_lab_04
  -> rm_battle_04
  -> rm_end
```

Fluxo opcional pós-game:

```text
rm_difficulty
  -> rm_lab_booly
  -> rm_battle_booly
  -> rm_end
```

O **Modo Booly** é liberado após concluir o jogo principal no **Modo Difícil**.

---

## 7. Fases, conceitos e mecânicas matemáticas

| Fase | Room | Conceito | Mecânica de sala | Batalha |
| --- | --- | --- | --- | --- |
| Sala inicial | `rm_lab_01` | Funções de várias variáveis | O quadro introduz `f(x,y)`, pares ordenados e substituição de valores. O puzzle principal calcula `f(1,2)` para `f(x,y)=x^2+y^2`. | `rm_battle_01`, contra o **Monitor Sem Rosto**, reforça entrada, saída e substituição em funções de duas variáveis. |
| Sala das Variações | `rm_lab_02` | Derivadas parciais | O quadro explica que uma variável varia enquanto a outra fica constante. No modo aprendizado, trabalha `df/dx`; no difícil, `df/dy` com mais termos. | `rm_battle_02`, contra a **Aluna da Janela**, usa perguntas sobre `df/dx` e `df/dy`. |
| Sala do Cartógrafo | `rm_lab_03` | Vetor gradiente | A mesa cartográfica pede o vetor `grad f = (df/dx, df/dy)` e associa o conceito à direção de maior crescimento. | `rm_battle_03`, contra o **Cartógrafo**, reforça cálculo e interpretação do gradiente. |
| Câmara do Isiaha | `rm_lab_04` | Máximos, mínimos, pontos críticos e Hessiana | O pedestal tem duas etapas: encontrar ponto crítico e classificar o comportamento com a Hessiana. | `rm_battle_04`, contra **Isiaha**, tem duas fases e um evento especial chamado **Julgamento da Hessiana**. |
| Sala secreta do Booly | `rm_lab_booly` | Revisão geral | Sala pós-game liberada após finalizar o Modo Difícil. | `rm_battle_booly` mistura funções, derivadas parciais, gradiente e Hessiana em uma prova surpresa. |

---

## 8. Explicação matemática por conteúdo

### 8.1 Funções de várias variáveis

A primeira fase apresenta a ideia de que uma função `f(x,y)` recebe dois valores de entrada. O jogador precisa identificar que, em `f(1,2)`, `x=1` e `y=2`, substituir corretamente os valores e resolver a expressão.

Exemplo usado no puzzle:

```text
f(x,y) = x^2 + y^2
f(1,2) = 1^2 + 2^2 = 1 + 4 = 5
```

Na batalha, as perguntas variam expressões como `x^2 + y^2`, `2x + y`, `x + y^2`, `xy + y^2` e outras combinações para reforçar substituição e ordem das operações.

### 8.2 Derivadas parciais

A segunda fase trabalha a ideia de observar uma variável por vez:

- em `df/dx`, `x` varia e `y` é tratado como constante;
- em `df/dy`, `y` varia e `x` é tratado como constante.

Exemplos usados:

```text
f(x,y) = x^2 + 3y
Para df/dx: df/dx = 2x
No ponto (2,1): 2*2 = 4
```

No modo difícil, o puzzle usa:

```text
f(x,y) = x^2*y + 4y^2
Para df/dy: df/dy = x^2 + 8y
No ponto (2,1): 4 + 8 = 12
```

### 8.3 Vetor gradiente

A terceira fase mostra que o gradiente reúne as derivadas parciais em um vetor:

```text
grad f = (df/dx, df/dy)
```

Exemplo usado no modo aprendizado:

```text
f(x,y) = x^2 + y^2
df/dx = 2x
df/dy = 2y
No ponto (1,2): grad f = (2,4)
```

O jogo também reforça a interpretação geométrica: o gradiente indica a direção de maior crescimento da função.

### 8.4 Máximos, mínimos e Hessiana

A quarta fase trabalha dois passos:

1. encontrar ponto crítico resolvendo `df/dx = 0` e `df/dy = 0`;
2. classificar o ponto usando a Hessiana e o teste da segunda derivada.

Regras usadas no caderno e nas batalhas:

```text
D = fxx*fyy - (fxy)^2

Se D > 0 e fxx > 0: mínimo local.
Se D > 0 e fxx < 0: máximo local.
Se D < 0: ponto de sela.
Se D = 0: o teste não permite concluir.
```

A batalha contra Isiaha adiciona o **Julgamento da Hessiana**, um puzzle no meio do combate. Acertar bloqueia o ataque especial e causa dano extra; errar causa dano maior.

---

## 9. Sistemas implementados

### 9.1 Exploração top-down

O jogador explora salas com mapas desenhados por sprites e colisões invisíveis configuradas em `obj_game/Create_0.gml`. As rooms usam objetos separados para cenário, jogador, tutor, quadro/pedestal/mesa e porta.

### 9.2 Tutor e feedback progressivo

O tutor explica o conceito da sala e ajuda quando o jogador erra. O padrão pedagógico é:

1. primeiro erro: dica leve;
2. segundo erro: dica mais direta;
3. erros seguintes: explicação do tutor com caminho de resolução.

Esse sistema atende à proposta de tratar o erro como parte do aprendizado.

### 9.3 Combate em turnos

As batalhas são controladas por `obj_battle_controller` e usam uma máquina de estados com etapas como:

```text
intro -> choose -> attack_question -> player_message -> enemy_message -> victory/defeat
```

Ações disponíveis:

| Ação | Função |
| --- | --- |
| Atacar | Abre pergunta matemática. Acerto causa dano ao inimigo. |
| Revisar | Mostra uma revisão do conceito da sala. |
| Dica | Disponível no Modo Aprendizado; prepara uma pergunta e mostra orientação. |
| Item | Usa itens da mochila, como barras de cereal ou maçãs. |

As perguntas são sorteadas a partir de bancos separados por batalha e por dificuldade.

### 9.4 Dificuldades

| Modo | Descrição |
| --- | --- |
| Modo Aprendizado | Recomendado para aprender ou revisar. Erros geram dicas claras, explicações e novas tentativas sem punição pesada. |
| Modo Difícil | Recomendado para quem já tem familiaridade. Inimigos têm mais HP/dano, perguntas são mais exigentes e a ação Dica fica indisponível. |
| Modo Booly | Desafio secreto pós-game. Mistura todos os conteúdos e funciona como revisão integrada. |

### 9.5 Caderno e itens

O menu do jogador possui duas abas:

- **Itens**: mostra vida máxima, barras de cereal e maçãs;
- **Caderno**: reúne páginas desbloqueadas após vitórias em batalhas.

Recompensas atuais:

| Vitória | Recompensa |
| --- | --- |
| Monitor Sem Rosto | Página sobre funções de várias variáveis, 3 barras de cereal e +5 HP máximo. |
| Aluna da Janela | Página sobre derivadas parciais e +5 HP máximo. |
| Cartógrafo | Página sobre vetor gradiente e +8 HP máximo. |
| Isiaha | Página sobre máximos/mínimos/Hessiana e +8 HP máximo. No Modo Difícil, libera o Modo Booly e entrega 3 maçãs. |
| Booly | Página extra de revisão geral. |

### 9.6 Derrota

Ao ficar sem HP, o jogador pode:

- refazer a sala anterior, reiniciando o puzzle da fase;
- voltar ao menu inicial.

---

## 10. Estrutura técnica do projeto

```text
NONAME/
  NONAME.yyp                  Projeto principal do GameMaker
  NONAME.resource_order       Ordem dos recursos
  README_PROTOTIPO.txt        Histórico de alterações do protótipo
  objects/                    Objetos e eventos GML
  rooms/                      Rooms do fluxo principal e pós-game
  sprites/                    Sprites de personagens, mapas, backgrounds e UI
  sounds/                     Músicas de menu, exploração e batalhas
  options/                    Configurações de plataforma
README.md                     Documentação principal do projeto
```

### Rooms

| Room | Função |
| --- | --- |
| `rm_title` | Tela inicial com o título **Midnight School**. |
| `rm_difficulty` | Seleção de Modo Aprendizado, Modo Difícil e Modo Booly. |
| `rm_story` | Introdução narrativa em primeira pessoa. |
| `rm_lab_01` | Primeira sala: funções de várias variáveis. |
| `rm_battle_01` | Batalha contra o Monitor Sem Rosto. |
| `rm_lab_02` | Segunda sala: derivadas parciais. |
| `rm_battle_02` | Batalha contra a Aluna da Janela. |
| `rm_lab_03` | Terceira sala: vetor gradiente. |
| `rm_battle_03` | Batalha contra o Cartógrafo. |
| `rm_lab_04` | Quarta sala: pontos críticos e Hessiana. |
| `rm_battle_04` | Batalha contra Isiaha. |
| `rm_lab_booly` | Sala secreta do Booly. |
| `rm_battle_booly` | Batalha secreta de revisão geral. |
| `rm_end` | Tela final, com variações para final normal, difícil e Booly. |

### Objetos principais

| Objeto | Função |
| --- | --- |
| `obj_title_controller` | Controla a tela inicial. |
| `obj_difficulty_controller` | Controla seleção de dificuldade, reset de progresso e desbloqueio do Booly. |
| `obj_story_controller` | Controla a introdução narrativa. |
| `obj_game` | Controlador global das salas: HUD, diálogos, menu, inventário, caderno, música e colisões. |
| `obj_player` | Movimento, animações direcionais e interação com objetos próximos. |
| `obj_tutor` | NPC de apoio pedagógico nas salas. |
| `obj_puzzle_panel` | Quadro, mesa cartográfica ou pedestal, dependendo da sala. |
| `obj_door` | Transição da sala para a batalha correspondente após resolver o puzzle. |
| `obj_battle_controller` | Controlador padronizado de todas as batalhas. |
| `obj_room_background` | Desenha o mapa visual de cada sala. |
| `obj_booly` | NPC da sala secreta do Booly. |
| `obj_end_controller` | Controla as telas finais. |

### Onde alterar conteúdos importantes

| Conteúdo | Arquivo principal |
| --- | --- |
| Perguntas de batalha | `NONAME/objects/obj_battle_controller/Create_0.gml` |
| Fórmulas e respostas dos puzzles de sala | `NONAME/objects/obj_puzzle_panel/Create_0.gml` e `Step_0.gml` |
| Textos do tutor e introduções de sala | `NONAME/objects/obj_game/Create_0.gml` e `NONAME/objects/obj_tutor/Create_0.gml` |
| HUD, menu, caderno e caixas de diálogo | `NONAME/objects/obj_game/Draw_0.gml` |
| Recompensas de vitória | `NONAME/objects/obj_battle_controller/Step_0.gml` |
| Música de batalha por boss | `NONAME/objects/obj_battle_controller/Create_0.gml` |
| Colisões invisíveis dos mapas | `NONAME/objects/obj_game/Create_0.gml` |

---

## 11. Assets atuais

### Sprites

O projeto já possui sprites para:

- jogador em exploração (`sprite_player_down`, `sprite_player_up`, `sprite_player_left`, `sprite_player_right`);
- jogador em batalha e diálogo (`sprite_player_battle`, `sprite_player_dialogue`);
- tutor em exploração e diálogo;
- antagonistas: Monitor Sem Rosto, Aluna da Janela, Cartógrafo, Isiaha e Booly;
- mapas das salas (`sprite_map_classroom_01` a `sprite_map_classroom_04`, `sprite_map_classroom_booly`);
- backgrounds de batalha (`sprite_battle_room_01` a `sprite_battle_room_04`, `sprite_battle_room_booly`);
- tela de menu (`sprite_school_menu`).

### Sons e músicas

| Recurso | Uso no jogo | Autor/Nome da música |
| --- | --- | --- |
| `snd_menu_theme` | Tela inicial e menu. | Scott Cawthon - FNAF 2 Menu Theme |
| `snd_background_theme` | Salas de exploração. | No More Heroes Original Sound Tracks - N.M.H. |
| `snd_battle_theme` | Batalha do Monitor Sem Rosto. | Che - DOE DEER |
| `snd_battle_theme_02` | Batalha da Aluna da Janela. | Toby Fox - Battle Against A True Hero |
| `snd_battle_theme_03` | Batalha do Cartógrafo. | Toby Fox - THE WORLD REVOLVING |
| `snd_battle_theme_04` | Batalha de Isiaha. | bleood - munni & drugs |
| `snd_battle_theme_booly` | Batalha secreta do Booly. | boolymon - like kentrell |

---

## 15. Equipe

| Nome |
| --- |
| João Pedro |
| Samuel Salheb |
| Yuri Fernandes |
| Arthur Aviz |

