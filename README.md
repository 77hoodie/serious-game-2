# Serious Game Multivariável

Protótipo de jogo sério desenvolvido em **GameMaker** para a disciplina de **Resolução de Problemas Multivariáveis**.

O projeto combina elementos de **escape room** com **combate RPG em turnos**, usando desafios matemáticos como parte central da progressão do jogador.

## Status do projeto

Protótipo inicial em desenvolvimento.

Nesta versão, o jogo possui:

* uma sala básica de exploração;
* movimentação do jogador;
* interação com painel matemático;
* sistema simples de dicas;
* porta desbloqueável após resolução do desafio;
* transição para combate RPG;
* combate em turnos com pergunta matemática;
* modo aprendizado e modo difícil;
* placeholders visuais feitos por código.

Os sprites, músicas, efeitos sonoros, interface final e demais elementos visuais ainda estão em desenvolvimento.

## Objetivo educacional

O objetivo do jogo é reforçar conceitos de cálculo multivariável por meio de mecânicas interativas.

Os principais conteúdos previstos são:

* funções de várias variáveis;
* derivadas parciais;
* vetor gradiente;
* máximos e mínimos;
* pontos críticos;
* classificação por Hessiana.

A proposta prioriza feedback educativo. Quando o jogador erra, o jogo apresenta dicas ou explicações progressivas para apoiar o aprendizado.

## Tecnologias utilizadas

* GameMaker
* GameMaker Language, GML

## Como executar

1. Abra o projeto no GameMaker.
2. Carregue o arquivo principal do projeto.
3. Execute pelo botão de play da IDE.
4. Inicie o teste pela primeira room do protótipo.

## Controles

| Tecla              | Ação                                   |
| ------------------ | -------------------------------------- |
| `W`, `A`, `S`, `D` | Movimentar o personagem                |
| `E`                | Interagir                              |
| `1`, `2`, `3`      | Selecionar alternativas                |
| `H`                | Alternar modo aprendizado/modo difícil |
| `ESC`              | Sair de interação ou painel            |
| `ENTER`            | Avançar em telas específicas           |

## Estrutura atual do protótipo

### Rooms

| Room           | Função                          |
| -------------- | ------------------------------- |
| `rm_lab_01`    | Sala inicial de exploração      |
| `rm_battle_01` | Combate RPG inicial             |
| `rm_end`       | Tela de encerramento provisória |

### Objetos principais

| Objeto                  | Função                                      |
| ----------------------- | ------------------------------------------- |
| `obj_game`              | Controla variáveis globais e estado inicial |
| `obj_player`            | Controla o jogador                          |
| `obj_puzzle_panel`      | Painel de desafio matemático                |
| `obj_tutor`             | NPC de apoio e explicação                   |
| `obj_door`              | Porta desbloqueável                         |
| `obj_battle_controller` | Controlador do combate                      |
| `obj_end_controller`    | Controlador da tela final                   |

## Mecânicas implementadas

### Exploração

O jogador se move livremente pela sala e pode interagir com objetos próximos.

### Puzzle matemático

O jogador responde uma questão baseada em função de várias variáveis.

Ao errar, recebe dicas progressivas.
Ao acertar, desbloqueia a porta da sala.

### Combate RPG

Após sair da sala, o jogador entra em uma batalha em turnos.

O combate utiliza perguntas matemáticas como forma de ataque. Acertos causam dano ao inimigo. Erros ativam explicações ou penalidades leves, dependendo do modo ativo.

### Modos de jogo

| Modo             | Descrição                                              |
| ---------------- | ------------------------------------------------------ |
| Modo aprendizado | Erros geram dicas e explicações, sem punição pesada    |
| Modo difícil     | Erros podem causar penalidades leves durante o combate |

## Diretrizes de desenvolvimento

Este projeto segue algumas decisões de design:

* o erro deve servir como oportunidade de aprendizado;
* os desafios devem ter relação direta com os conceitos matemáticos;
* o jogador deve receber feedback claro;
* a dificuldade deve crescer de forma progressiva;
* o combate deve reforçar o conteúdo aprendido nas salas;
* a apresentação visual pode ser substituída gradualmente sem alterar a lógica principal.

## Próximas etapas

* Substituir placeholders por sprites definitivos.
* Adicionar música de combate.
* Adicionar efeitos sonoros.
* Melhorar interface de diálogos e escolhas.
* Criar novas salas para derivadas parciais, gradiente e Hessiana.
* Expandir o sistema de combate.
* Organizar melhor os scripts e estados do jogo.
* Criar relatório de testes com jogadores externos.
* Documentar como cada mecânica representa um conceito matemático.

## Créditos de músicas e sons

Atualizar esta seção conforme os assets forem adicionados ao projeto.

| Música/Som | Autor/Fonte   | Uso no jogo |
| ---------- | ----------- | ----------- |
| DOE DEER  | Che    | Tema de batalha do primeiro boss   |

## Créditos de arte

Atualizar esta seção conforme sprites, tilesets, ícones ou outros recursos visuais forem adicionados.

| Asset     | Autor/Fonte | Licença   | Uso no jogo | Link      |
| --------- | ----------- | --------- | ----------- | --------- |
| A definir | A definir   | A definir | A definir   | A definir |

## Equipe

| Nome      | Função    |
| --------- | --------- |
| A definir | A definir |
| A definir | A definir |
| A definir | A definir |
| A definir | A definir |

## Observações

Este repositório contém uma versão inicial do protótipo. A estrutura e os assets ainda podem mudar durante o desenvolvimento.

O foco desta etapa é validar a base jogável: exploração, interação, feedback educativo e combate RPG.
